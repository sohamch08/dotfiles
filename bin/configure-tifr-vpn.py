#!/usr/bin/env python3
"""Create a Fedora strongSwan profile from the user's Juniper import log.

Usage:
    sudo python3 configure-tifr-vpn.py /path/to/NcpImport.log

This script contains no VPN secrets and makes no network requests. It reads the
PSK from the specified local log and prompts privately for the XAuth password.
Only /etc/strongswan/swanctl/conf.d/tifr.conf is written. An existing file is
replaced only after confirmation. No services, routing, DNS, or firewall settings
are changed by this script. The generated profile is an interoperability attempt,
not a configuration tested against TIFR.

The profile uses the observed IKEv1 PSK/XAuth settings. The remote IKE identity,
ModeConfig push mode and full IPv4 selector come from the phone's connection log.
The proprietary Juniper configuration-download/PathFinder functions are not
reproduced. Connection requires direct IKE/IPsec reachability.

References:
https://docs.strongswan.org/docs/latest/swanctl/swanctlConf.html
https://docs.strongswan.org/docs/latest/config/IKEv1.html
https://docs.strongswan.org/docs/latest/config/proposals.html
https://datatracker.ietf.org/doc/html/rfc4106#section-8.3
"""
from __future__ import annotations

import argparse
import getpass
import os
import re
import shutil
import stat
import sys
import tempfile
import warnings
from pathlib import Path

PROFILE = "vpn.tifr.res.in/tifruser"
GATEWAY = "158.144.9.1"
CLIENT_ID = "srx@tifr.res.in.tifruser"
OUTPUT = Path("/etc/strongswan/swanctl/conf.d/tifr.conf")


def section(text: str, kind: str, name: str) -> str:
    """Find the last complete successful import of one named section."""
    start = re.escape(f'Importing {kind} "{name}"')
    end = re.escape(f'successfully imported {kind} "{name}"')
    matches = list(re.finditer(start + r"(.*?)" + end, text, re.DOTALL))
    if not matches:
        raise ValueError(f"No complete successful import of {kind} was found.")
    return matches[-1].group(1)


def field(text: str, name: str) -> str:
    """Read a logged parameter without printing any value."""
    pattern = r"^[ \t]*added " + re.escape(name) + r"=([^\r\n]*)"
    values = re.findall(pattern, text, re.MULTILINE)
    if not values or len(set(values)) != 1 or not values[0]:
        raise ValueError(f"The {name} field is missing, empty, or ambiguous.")
    return values[0]


def require_fields(text: str, expected: dict[str, str]) -> None:
    for key, value in expected.items():
        if field(text, key) != value:
            raise ValueError(f"Unexpected {key} setting; do not use this profile unchanged.")


def read_psk(text: str) -> str:
    """Validate the observed profile and return its PSK privately."""
    vpn = section(text, "VPN profile", PROFILE)
    require_fields(vpn, {
        "Gateway": GATEWAY,
        "ExchMode": "4",
        "IkeIdType": "3",
        "IkeIdStr": CLIENT_ID,
        "UsePreShKey": "1",
        "UseXAUTH": "1",
        "PFS": "19",
    })
    ike = section(text, "IKE Proposal", field(vpn, "IKE-Policy"))
    require_fields(ike, {
        "crypto algorithm": "7", "crypto key length": "256",
        "IkeHash": "4", "IkeDhGroup": "19",
    })
    esp = section(text, "IpSec Proposal", field(vpn, "IPSec-Policy"))
    require_fields(esp, {
        "crypto algorithm": "20", "crypto key length": "256", "IpsecAuth": "0",
    })
    return field(vpn, "Secret")


def encoded_secret(value: str) -> str:
    # Hex avoids quote, backslash, dollar-sign and comment parsing issues.
    # This is reversible encoding, NOT encryption. The file must stay private.
    return "0x" + value.encode("utf-8").hex()


def make_config(psk: str, username: str, password: str) -> str:
    if not re.fullmatch(r"[A-Za-z0-9_.@+-]+", username):
        raise ValueError("Unsupported characters in username.")
    if not psk or not password or "\x00" in psk or "\x00" in password:
        raise ValueError("Secrets must be nonempty and may not contain NUL characters.")
    return f"""# TIFR IKEv1/IPsec interoperability profile.
# Contains credentials encoded as hex, NOT encrypted. Keep root-owned, mode 0600.
# Based on the supplied Juniper import and connection logs; not live-tested.
# IPv4 full tunnel only: IPv6 is not covered and this is NOT a kill switch.
connections {{
    tifr {{
        version = 1
        aggressive = yes
        remote_addrs = {GATEWAY}
        proposals = aes256-sha256-ecp256
        vips = 0.0.0.0
        pull = no
        dpd_delay = 60s

        local-psk {{
            auth = psk
            id = {CLIENT_ID}
        }}
        local-xauth {{
            auth = xauth
            xauth_id = {username}
        }}
        remote-psk {{
            auth = psk
            id = {GATEWAY}
        }}
        children {{
            tifr-net {{
                mode = tunnel
                local_ts = dynamic
                remote_ts = 0.0.0.0/0
                esp_proposals = aes256gcm16-ecp256
                life_time = 1h
                start_action = none
            }}
        }}
    }}
}}
secrets {{
    ike-tifr {{
        id = {GATEWAY}
        secret = {encoded_secret(psk)}
    }}
    xauth-tifr {{
        id = {username}
        secret = {encoded_secret(password)}
    }}
}}
"""


def write_private(path: Path, content: str) -> None:
    """Atomically write a root-owned 0600 file in the existing config directory."""
    if path.is_symlink():
        raise ValueError("Refusing to replace a symbolic link.")
    if path.exists() and not stat.S_ISREG(path.stat().st_mode):
        raise ValueError("The output path is not a regular file.")
    fd, name = tempfile.mkstemp(prefix=".tifr-", suffix=".conf", dir=path.parent)
    try:
        with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as out:
            os.fchmod(out.fileno(), 0o600)
            os.fchown(out.fileno(), 0, 0)
            out.write(content)
            out.flush()
            os.fsync(out.fileno())
        os.replace(name, path)
    finally:
        if os.path.exists(name):
            os.unlink(name)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("import_log", type=Path, help="Local path to NcpImport.log")
    parser.add_argument("--username", default="soham.chatterjee", help="XAuth username")
    args = parser.parse_args()
    if os.geteuid() != 0:
        parser.error("Run using sudo so the generated credentials are root-owned.")
    if not sys.stdin.isatty():
        parser.error("Run from an interactive terminal; the password must not be echoed.")
    if not shutil.which("swanctl") or not OUTPUT.parent.is_dir():
        parser.error("Install Fedora's strongswan package first: sudo dnf install strongswan")
    if not re.fullmatch(r"[A-Za-z0-9_.@+-]+", args.username):
        parser.error("Unsupported characters in username.")
    source = args.import_log.expanduser()
    if source.stat().st_size > 2_000_000:
        raise ValueError("Import log is unexpectedly large.")
    psk = read_psk(source.read_text(encoding="utf-8-sig"))
    print("Matched the TIFR profile and found its PSK. The key will not be displayed.")
    print(f"XAuth username: {args.username}")
    print(f"Output: {OUTPUT} (root:root, mode 0600)")
    print("The file will store both credentials in reversible hex encoding.")
    print("This script does not connect. The profile requests a full IPv4 tunnel.")
    if OUTPUT.is_symlink():
        raise ValueError("Refusing to replace a symbolic link.")
    if OUTPUT.exists():
        answer = input("Replace the existing tifr.conf? [y/N] ").strip().lower()
        if answer not in {"y", "yes"}:
            print("Cancelled; no configuration changed.")
            return 0
    # Abort rather than falling back to an echoing password prompt.
    with warnings.catch_warnings():
        warnings.simplefilter("error", getpass.GetPassWarning)
        password = getpass.getpass("TIFR VPN password (same as the mobile app): ")
        repeat = getpass.getpass("Repeat VPN password: ")
    if password != repeat:
        raise ValueError("Passwords did not match; no configuration changed.")
    config = make_config(psk, args.username, password)
    write_private(OUTPUT, config)
    print("Configuration written. No VPN connection has been initiated.")
    print("Next run: sudo restorecon /etc/strongswan/swanctl/conf.d/tifr.conf")
    print("Then follow the strongSwan start/load/initiate commands from the instructions.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (KeyboardInterrupt, EOFError):
        print("\nCancelled.", file=sys.stderr)
        raise SystemExit(130)
    except getpass.GetPassWarning:
        print("Error: a hidden password prompt is unavailable. Use an interactive terminal.",
              file=sys.stderr)
        raise SystemExit(1)
    except UnicodeError:
        print("Error: the input is not a UTF-8/ASCII import log. Do not pass ncpphone.cfg.",
              file=sys.stderr)
        raise SystemExit(1)
    except (OSError, ValueError) as exc:
        print(f"Error: {exc}", file=sys.stderr)
        raise SystemExit(1)

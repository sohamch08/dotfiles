#!/usr/bin/env python3

import subprocess
import os
import sys
import shutil
from pathlib import Path

# ── Config ────────────────────────────────────────────────────────────────────

APP          = "yt-dlp"
DOWNLOAD_DIR = Path.home() / "Downloads" / "yt-dlp_songs"
HISTORY_FILE = Path.home() / ".local" / "share" / "yt-download" / "history.txt"
OUTPUT_TEMPLATE = str(DOWNLOAD_DIR / "%(channel)s" / "%(title)s - %(channel)s.%(ext)s")

# ── Colors ────────────────────────────────────────────────────────────────────

RED    = "\033[0;31m"
GREEN  = "\033[0;32m"
YELLOW = "\033[1;33m"
CYAN   = "\033[0;36m"
BOLD   = "\033[1m"
DIM    = "\033[2m"
RESET  = "\033[0m"

def info(msg):    print(f"  {CYAN}→{RESET} {msg}")
def success(msg): print(f"  {GREEN}✔{RESET} {GREEN}{msg}{RESET}")
def warn(msg):    print(f"  {YELLOW}⚠{RESET} {YELLOW}{msg}{RESET}")
def error(msg):   print(f"  {RED}✘{RESET} {RED}{msg}{RESET}")
def header(msg):  print(f"\n{BOLD}{CYAN}{msg}{RESET}\n")

# ── Progress Bar ──────────────────────────────────────────────────────────────

BAR_WIDTH  = 35
BAR_FILL   = "█"
BAR_EMPTY  = "░"

_current_title = ""

def _format_bytes(b: float) -> str:
    for unit in ("B", "KB", "MB", "GB"):
        if b < 1024:
            return f"{b:.1f} {unit}"
        b /= 1024
    return f"{b:.1f} TB"

def _draw_bar(percent: float, downloaded: float, total: float, speed: float, eta: int, title: str):
    filled  = int(BAR_WIDTH * percent / 100)
    bar     = f"{GREEN}{BAR_FILL * filled}{DIM}{BAR_EMPTY * (BAR_WIDTH - filled)}{RESET}"
    pct     = f"{CYAN}{percent:5.1f}%{RESET}"
    sizes   = f"{_format_bytes(downloaded)} / {_format_bytes(total)}" if total else ""
    spd     = f"{GREEN}{_format_bytes(speed)}/s{RESET}" if speed else ""
    eta_str = f"{YELLOW}ETA {eta}s{RESET}" if eta else ""

    # Truncate title to fit terminal
    term_width = shutil.get_terminal_size().columns
    max_title  = max(20, term_width - BAR_WIDTH - 40)
    short_title = (title[:max_title - 1] + "…") if len(title) > max_title else title

    line1 = f"  {DIM}{short_title}{RESET}"
    line2 = f"  {bar} {pct}  {sizes}  {spd}  {eta_str}"

    sys.stdout.write(f"\r\033[1A\033[2K{line1}\n\033[2K{line2}")
    sys.stdout.flush()

def progress_hook(d: dict):
    global _current_title
    status = d.get("status")

    if status == "downloading":
        title      = d.get("info_dict", {}).get("title", _current_title)
        _current_title = title
        downloaded = d.get("downloaded_bytes", 0) or 0
        total      = d.get("total_bytes") or d.get("total_bytes_estimate") or 0
        speed      = d.get("speed") or 0
        eta        = d.get("eta") or 0
        percent    = (downloaded / total * 100) if total else 0
        _draw_bar(percent, downloaded, total, speed, eta, title)

    elif status == "finished":
        title = d.get("info_dict", {}).get("title", _current_title)
        elapsed = d.get("elapsed") or 0
        total   = d.get("total_bytes") or d.get("total_bytes_estimate") or 0
        # Complete bar
        _draw_bar(100, total, total, 0, 0, title)
        print(f"\n  {GREEN}✔{RESET} {GREEN}Done{RESET}  {DIM}({elapsed:.1f}s){RESET}")

    elif status == "error":
        print(f"\n  {RED}✘ Download error{RESET}")

# ── Helpers ───────────────────────────────────────────────────────────────────

def ensure_files():
    DOWNLOAD_DIR.mkdir(parents=True, exist_ok=True)
    HISTORY_FILE.parent.mkdir(parents=True, exist_ok=True)
    HISTORY_FILE.touch(exist_ok=True)

def load_history() -> set:
    with open(HISTORY_FILE, "r") as f:
        return set(line.strip() for line in f if line.strip())

def save_to_history(entries: list[str]):
    history = load_history()
    history.update(entries)
    with open(HISTORY_FILE, "w") as f:
        for entry in sorted(history):
            f.write(entry + "\n")

def get_entries(url: str) -> list[str]:
    """Get title(s) from URL — works for single video and playlists."""
    cmd = [
        APP, "--get-filename",
        "-o", "%(title)s - %(channel)s",
        "--yes-playlist" if is_playlist(url) else "--no-playlist",
        url
    ]
    try:
        result = subprocess.check_output(cmd, stderr=subprocess.DEVNULL).decode().strip()
        return [line.strip() for line in result.splitlines() if line.strip()]
    except subprocess.CalledProcessError:
        error("Failed to fetch video info. Check the URL.")
        sys.exit(1)

def is_playlist(url: str) -> bool:
    return "list=" in url or "/playlist" in url

def check_history(entries: list[str]) -> list[str]:
    history = load_history()
    return [e for e in entries if e in history]

# ── Download ──────────────────────────────────────────────────────────────────

def _ydl_opts(extra: dict, playlist: bool) -> dict:
    base = {
        "outtmpl"         : OUTPUT_TEMPLATE,
        "progress_hooks"  : [progress_hook],
        "quiet"           : True,
        "no_warnings"     : True,
        "noplaylist"      : not playlist,
    }
    return {**base, **extra}

def download_audio(url: str, playlist: bool):
    try:
        from yt_dlp import YoutubeDL
    except ImportError:
        error("yt-dlp Python package not found. Install with: pip install yt-dlp")
        sys.exit(1)

    info("Downloading audio (MP3)...")
    print("\n\n")   # reserve two lines for the progress bar
    opts = _ydl_opts({
        "format"        : "140",
        "postprocessors": [{
            "key"            : "FFmpegExtractAudio",
            "preferredcodec" : "mp3",
            "preferredquality": "0",
        }],
    }, playlist)
    with YoutubeDL(opts) as ydl:
        ydl.download([url])

def download_thumbnail(url: str, playlist: bool):
    try:
        from yt_dlp import YoutubeDL
    except ImportError:
        return

    info("Downloading thumbnails...")
    print("\n\n")
    opts = _ydl_opts({
        "skip_download"      : True,
        "writethumbnail"     : True,
        "convert_thumbnails" : "png",
    }, playlist)
    with YoutubeDL(opts) as ydl:
        ydl.download([url])

def convert_thumbnails():
    """Convert any leftover .webp thumbnails to .png using magick."""
    result = subprocess.run(
        ["find", str(DOWNLOAD_DIR), "-name", "*.webp"],
        capture_output=True, text=True
    )
    webp_files = result.stdout.strip().splitlines()
    if not webp_files:
        return
    info("Converting leftover thumbnails...")
    for webp in webp_files:
        subprocess.run(["magick", webp, webp + ".png"], check=False)
        os.remove(webp)

def run_download(url: str, entries: list[str]):
    playlist = is_playlist(url)
    try:
        download_audio(url, playlist)
        download_thumbnail(url, playlist)
        convert_thumbnails()
        save_to_history(entries)
        print()
        success(f"All done! {len(entries)} track(s) downloaded.")
    except Exception as e:
        error(f"Download failed: {e}")
        sys.exit(1)

# ── Main ──────────────────────────────────────────────────────────────────────

def prompt_url() -> str:
    try:
        url = input(f"  {CYAN}Enter URL:{RESET} ").strip()
        if not url:
            error("No URL provided.")
            sys.exit(1)
        return url
    except (KeyboardInterrupt, EOFError):
        print()
        error("Cancelled.")
        sys.exit(0)

def confirm(prompt: str) -> bool:
    try:
        ans = input(f"  {YELLOW}{prompt} [y/N]:{RESET} ").strip().lower()
        return ans in ("y", "yes")
    except (KeyboardInterrupt, EOFError):
        print()
        return False

def main():
    ensure_files()
    header("yt-dlp Downloader")

    # Get URL from argument or prompt
    if len(sys.argv) > 1:
        url = sys.argv[1]
        info(f"URL: {DIM}{url}{RESET}")
    else:
        url = prompt_url()

    # Detect playlist
    playlist = is_playlist(url)
    if playlist:
        info("Playlist detected")
    else:
        info("Single video detected")

    # Fetch entry names
    info("Fetching video info...")
    entries = get_entries(url)
    print()

    if not entries:
        error("Could not retrieve video info.")
        sys.exit(1)

    # Show what will be downloaded
    print(f"  {BOLD}{'Tracks' if len(entries) > 1 else 'Track'}:{RESET}")
    for i, entry in enumerate(entries, 1):
        print(f"  {DIM}{i:>3}.{RESET} {entry}")
    print()

    # Check history
    already_downloaded = check_history(entries)

    if already_downloaded:
        warn(f"{len(already_downloaded)} of {len(entries)} track(s) already in history:")
        for entry in already_downloaded:
            print(f"       {DIM}- {entry}{RESET}")
        print()

        if len(already_downloaded) == len(entries):
            # All already downloaded
            if not confirm("All tracks already downloaded. Download again?"):
                info("Skipping. No changes made.")
                sys.exit(0)
        else:
            # Some already downloaded
            if not confirm("Some tracks already downloaded. Download all anyway?"):
                info("Skipping. No changes made.")
                sys.exit(0)

    print()
    run_download(url, entries)

if __name__ == "__main__":
    main()

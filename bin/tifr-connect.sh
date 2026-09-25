#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  printf 'Usage: %s on|off|status\n' "$0" >&2
  exit 2
fi

case "$1" in
on)
  sudo systemctl start strongswan
  sudo swanctl --load-all --file /etc/strongswan/swanctl/conf.d/tifr.conf
  sudo swanctl --initiate --child tifr-net
  ;;
off)
  sudo swanctl --terminate --ike tifr
  ;;
status)
  sudo swanctl --list-sas --ike tifr
  ;;
*)
  printf 'Usage: %s on|off|status\n' "$0" >&2
  exit 2
  ;;
esac

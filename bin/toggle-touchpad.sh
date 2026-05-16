#!/bin/bash

GSETTINGS_KEY="org.gnome.desktop.peripherals.touchpad"
GSETTINGS_PROP="send-events"

current=$(gsettings get "$GSETTINGS_KEY" "$GSETTINGS_PROP" 2>/dev/null)

if [ $? -ne 0 ]; then
    notify-send -u critical -t 3000 "Touchpad" "Failed to read touchpad state"
    exit 1
fi

case "$current" in
    "'enabled'")
        gsettings set "$GSETTINGS_KEY" "$GSETTINGS_PROP" "disabled"
        notify-send -t 2000 -i input-touchpad "Touchpad" "Disabled"
        ;;
    "'disabled'"|"'disabled-on-external-mouse'")
        gsettings set "$GSETTINGS_KEY" "$GSETTINGS_PROP" "enabled"
        notify-send -t 2000 -i input-touchpad "Touchpad" "Enabled"
        ;;
    *)
        notify-send -u critical -t 3000 "Touchpad" "Unknown state: $current"
        exit 1
        ;;
esac

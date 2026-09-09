#!/bin/bash

set -e

read_number() {
    local prompt="$1" pattern="$2" value
    while true; do
        read -r -p "$prompt" value || exit 1
        if [[ "$value" =~ $pattern ]]; then
            REPLY=$((10#$value))
            return
        fi
        echo "Invalid value. Please try again." >&2
    done
}

read_number "Year (YYYY): " '^[0-9]{4}$'
year=$REPLY
read_number "Month (1-12): " '^(0?[1-9]|1[0-2])$'
month=$REPLY
while true; do
    read_number "Date (day of month, 1-31): " '^(0?[1-9]|[12][0-9]|3[01])$'
    day=$REPLY
    printf -v calendar_date '%04d-%02d-%02d' "$year" "$month" "$day"
    if date --date="$calendar_date" +%F >/dev/null 2>&1; then
        break
    fi
    echo "That date does not exist in the selected month/year. Try again." >&2
done
read_number "Hour (0-23): " '^([01]?[0-9]|2[0-3])$'
hour=$REPLY
read_number "Minute (0-59): " '^[0-5]?[0-9]$'
minute=$REPLY

# Seconds are always zero; date expects MMDDhhmmYYYY.ss.
printf -v DATE '%02d%02d%02d%02d%04d.00' "$month" "$day" "$hour" "$minute" "$year"

# Set the system date
sudo date "$DATE"

# Synchronize hardware clock with system time
sudo hwclock --systohc

# Clear log files
sudo cp /dev/null /var/run/utmp
sudo cp /dev/null /var/log/wtmp

# Reboot the system
sudo reboot

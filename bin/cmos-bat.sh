#!/bin/bash

# Prompt for date if not provided
if [ -z "$1" ]; then
    read -p "Enter the date (format: MMDDhhmmYYYY.ss): " DATE
else
    DATE="$1"
fi

# Set the system date
sudo date "$DATE"

# Synchronize hardware clock with system time
sudo hwclock --systohc

# Clear log files
sudo cp /dev/null /var/run/utmp
sudo cp /dev/null /var/log/wtmp

# Reboot the system
sudo reboot

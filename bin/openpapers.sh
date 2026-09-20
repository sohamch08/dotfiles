#!/usr/bin/env bash

cd "$HOME/My Papers" || exit 1

choose_pdf() {
    case ":${XDG_CURRENT_DESKTOP^^}:" in
        *:GNOME:*)
            zenity --list --title="Open paper" --column="PDF" \
                --width=800 --height=600
            ;;
        *)
            fuzzel --dmenu --lines 20 --prompt "PDF: "
            ;;
    esac
}

selected=$(fd --type f --hidden --no-ignore --ignore-case --glob '*.pdf' --color never |
    sort | choose_pdf) || exit 0

[[ -n "$selected" ]] || exit 0
exec flatpak run org.kde.okular "$PWD/$selected"

#!/usr/bin/env bash
# Waybar custom/layout: map xkb layout names to short labels (us/co/es).
label() {
    case "$1" in
        "English (US)")     echo "us" ;;
        "English (Colemak)") echo "co" ;;
        "Spanish")          echo "es" ;;
        *)                  echo "$1" ;;
    esac
}

emit() {
    local n
    n=$(swaymsg -t get_inputs | jq -r \
        '[.[]|select(.type=="keyboard")][0].xkb_active_layout_name')
    jq -cn --arg t "$(label "$n")" --arg tip "$n" '{text:$t,tooltip:$tip,class:$t}'
}

emit
while true; do
    swaymsg -t subscribe -m '["input"]' \
        | jq --unbuffered -r 'select(.change=="xkb_layout")|.input.xkb_active_layout_name' \
        | while read -r n; do
            jq -cn --arg t "$(label "$n")" --arg tip "$n" \
                '{text:$t,tooltip:$tip,class:$t}'
        done
    sleep 1 # swaymsg exited (sway restart); retry
done

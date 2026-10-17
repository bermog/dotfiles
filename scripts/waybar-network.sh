#!/usr/bin/env bash
# Network status widget for waybar.
#
# Hidden by default; toggled visible with:
#   - $mod+n in sway, or
#   - clicking the module when it is visible
# Always shown automatically when there is no active connection.
#
# Usage:
#   waybar-network.sh          print status as waybar JSON
#   waybar-network.sh toggle   flip visibility and refresh waybar

set -u

STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-network-visible"

# --- toggle mode: flip the state file and poke waybar ------------------------
if [[ "${1:-}" == "toggle" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        rm -f "$STATE_FILE"
    else
        touch "$STATE_FILE"
    fi
    # signal 8 matches "signal": 8 in the waybar config.
    # Note: psmisc killall doesn't understand RTMIN+N signal names; procps
    # pkill does.
    pkill -RTMIN+8 -x waybar 2>/dev/null
    exit 0
fi

# --- collect connection info via nmcli ---------------------------------------
# Active ethernet device + IPv4
eth_dev=$(nmcli -t -f DEVICE,TYPE,STATE dev 2>/dev/null \
    | awk -F: '$2 == "ethernet" && $3 == "connected" { print $1; exit }')
eth_ip=""
if [[ -n "$eth_dev" ]]; then
    eth_ip=$(nmcli -g IP4.ADDRESS dev show "$eth_dev" 2>/dev/null \
        | head -n1 | cut -d/ -f1)
fi

# Active wifi SSID + signal (empty when wifi radio is off)
read -r wifi_ssid wifi_signal <<<"$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi 2>/dev/null \
    | awk -F: '$1 == "yes" { print $2, $3; exit }')"

# --- decide what to show -----------------------------------------------------
connected=false
class=""
text=""
tooltip=""

if [[ -n "$wifi_ssid" ]]; then
    connected=true
    class="wifi"
    text="󰤨 ${wifi_ssid} (${wifi_signal}%)"
    tooltip="Wifi: ${wifi_ssid}
Signal: ${wifi_signal}%"
elif [[ -n "$eth_dev" ]]; then
    connected=true
    class="ethernet"
    text="󰈀 ${eth_ip:-$eth_dev}"
    tooltip="Ethernet: ${eth_dev}
IP: ${eth_ip:-unknown}"
else
    # no active connection: always visible, red warning state
    class="disconnected"
    text="󰤮 disconnected"
    tooltip="No active network connection"
fi

# Hidden (and connection is fine): print empty text, which hides the module
if [[ "$connected" == true && ! -f "$STATE_FILE" ]]; then
    echo '{"text": ""}'
    exit 0
fi

# Public IP: shown after the local address in text and tooltip.
# Cached for 5 minutes so the 10s waybar refresh doesn't hammer the API;
# on a failed fetch the last known value is kept.
if [[ "$connected" == true ]]; then
    pub_cache="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-network-public-ip"
    pub_ip=""
    if [[ -f "$pub_cache" && $(( $(date +%s) - $(stat -c %Y "$pub_cache") )) -lt 300 ]]; then
        pub_ip=$(<"$pub_cache")
    else
        if pub_ip=$(curl -4fsS --max-time 3 https://api.ipify.org 2>/dev/null) &&
           [[ "$pub_ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            printf '%s' "$pub_ip" > "$pub_cache"
        elif [[ -f "$pub_cache" ]]; then
            pub_ip=$(<"$pub_cache")
        else
            pub_ip=""
        fi
    fi
    if [[ -n "$pub_ip" ]]; then
        text="${text} · ${pub_ip}"
        tooltip="${tooltip}
Public IP: ${pub_ip}"
    fi
fi

# Escape backslashes, double quotes, and newlines for JSON
json_escape() {
    printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' | awk 'BEGIN{ORS="\\n"} 1' | sed '$ s/\\n$//'
}

printf '{"text": "%s", "class": "%s", "tooltip": "%s"}\n' \
    "$(json_escape "$text")" \
    "$class" \
    "$(json_escape "$tooltip")"

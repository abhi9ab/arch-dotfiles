#!/bin/bash

battery="/sys/class/power_supply/BAT1"

capacity=$(cat "$battery/capacity")
status=$(cat "$battery/status")

# Notification timeout in milliseconds
timeout=1500

# File to store last notification state
notify_file="/tmp/.battery_notify_level"
[ ! -f "$notify_file" ] && echo "none" > "$notify_file"
prev_notify=$(cat "$notify_file")

# Battery low (but not charging)
if [ "$capacity" -le 20 ] && [ "$status" != "Charging" ]; then
    if [ "$prev_notify" != "low" ]; then
        notify-send -u critical -t $timeout "󰁻 Battery Low" "Battery at ${capacity}%"
        echo "low" > "$notify_file"
    fi

# Battery charged (80% or more and charging)
elif [ "$capacity" -ge 80 ] && [ "$status" = "Charging" ]; then
    if [ "$prev_notify" != "high" ]; then
        notify-send -u normal -t $timeout "⚡ Battery Charged" "Battery at ${capacity}%. You can unplug the charger."
        echo "high" > "$notify_file"
    fi

# Reset state (no popup)
else
    echo "none" > "$notify_file"
fi

# Output capacity for Waybar module display
echo "${capacity}%"


#!/bin/bash

DEVICE="elan0b00:00-04f3:3261-touchpad"
STATE_FILE="/tmp/.touchpad_enabled"

# Ensure hyprctl works in scripts
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

if [[ -f "$STATE_FILE" ]]; then
	notify-send -u normal -t 1500 "Disabling Touchpad"
	hyprctl keyword "device[$DEVICE]:enabled" false
    rm "$STATE_FILE"
else
	notify-send -u normal -t 1500 "Enabling Touchpad"
	hyprctl keyword "device[$DEVICE]:enabled" true
    touch "$STATE_FILE"
fi


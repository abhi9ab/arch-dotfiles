#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Kill wofi if already running
pgrep -x "wofi" && pkill -x "wofi" && exit

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) \
    -exec file --mime-type {} + | grep -E 'image/' | cut -d: -f1 | sort | awk '{print "img:"$0}'
}

main() {
    choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    
    [[ -z "$selected_wallpaper" ]] && exit

    # Set wallpaper and update theming
    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
    wal -i "$selected_wallpaper" -n --cols16
    swaync-client --reload-css

    cp ~/.cache/wal/colors-kitty.conf ~/.config/kitty/current-theme.conf
    pywalfox update

    # Update Cava colors
    color1=$(awk 'match($0, /color2=\47(.*)\47/, a) { print a[1] }' ~/.cache/wal/colors.sh)
    color2=$(awk 'match($0, /color3=\47(.*)\47/, a) { print a[1] }' ~/.cache/wal/colors.sh)
    sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" ~/.config/cava/config
    sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" ~/.config/cava/config
    pkill -USR2 cava 2>/dev/null
}
main


#!/bin/bash

# Wait until wayland socket is available
while [ ! -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; do
    sleep 0.2
done

# Start clipboard history watchers
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &


#!/bin/bash

# Check if wlogout is already running
if pgrep -x wlogout > /dev/null; then
    # Kill it if running
    pkill -x wlogout
else
    # Launch wlogout with background option
    wlogout -b 2 &
fi


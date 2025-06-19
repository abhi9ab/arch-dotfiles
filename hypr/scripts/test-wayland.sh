#!/bin/bash

{
  echo "Time: $(date)"
  echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
  echo "XDG_RUNTIME_DIR: $XDG_RUNTIME_DIR"
  echo "Socket exists: $(test -S "$XDG_RUNTIME_DIR/wayland-0" && echo yes || echo no)"
  echo "---"
} >> /tmp/wayland-test.log


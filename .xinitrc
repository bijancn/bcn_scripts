#!/usr/bin/env bash
if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap &
fi
xset -dpms &  # energy saving
xset s off &  # disable screensaver

# mouse settings
echo 200 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity &
echo 150 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed &

# Start a terminal emulator in the background
gnome-terminal &

# Start the window manager
#exec awesome

#!/usr/bin/env bash
if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap &
fi
#xset -dpms &  # energy saving
xset s off &  # disable screensaver

battery-set-normal-charge-levels

xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 1.5
xsetwacom set 'Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus' Area 20 30 30900 17340
xsetwacom set 'Wacom Co.,Ltd. Pen and multitouch sensor Pen eraser' Area 20 30 30900 17340

# Needs su rights
#set-mouse-settings

# Start the window manager
#exec awesome

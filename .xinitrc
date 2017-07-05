#!/usr/bin/env bash
setxkbmap -option compose:rctrl # set compose key
if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap &
fi
# xset -dpms &                  # energy saving
# xset s off &                    # disable screensaver

battery-set-normal-charge-levels

# xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 1
# xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 1.0
# xsetwacom set 'Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus' Area 20 30 30900 17340
# xsetwacom set 'Wacom Co.,Ltd. Pen and multitouch sensor Pen eraser' Area 20 30 30900 17340
# xsetwacom set "Wacom Co.,Ltd. Pen and multitouch sensor Finger touch" MapToOutput eDP1
# xsetwacom set "Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus" MapToOutput eDP1
# xsetwacom set "Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus" MapToOutput eDP1

# touch screen, pointer and eraser
# xinput map-to-output 9 eDP1
# xinput map-to-output 10 eDP1
# xinput map-to-output 16 eDP1

# Needs su rights
#set-mouse-settings

# ~/thinkpad-scripts/trackpoint-fast-libinput.sh

# Start the window manager
#exec awesome

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

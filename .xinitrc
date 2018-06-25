#!/usr/bin/env bash
setxkbmap -option compose:rctrl # set compose key
if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap &
fi
# xset -dpms &                  # energy saving
# xset s off &                    # disable screensaver

# battery-set-normal-charge-levels

# xrandr --output eDP-1 --primary --mode 2560x1440 --dpi 150
# xinput --disable "SynPS/2 Synaptics TouchPad"
# xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.4
# xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Velocity Scaling" 50

# xsetwacom set 'Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus' Area 20 30 30900 17340
# xsetwacom set 'Wacom Co.,Ltd. Pen and multitouch sensor Pen eraser' Area 20 30 30900 17340
# xsetwacom set "Wacom Co.,Ltd. Pen and multitouch sensor Finger touch" MapToOutput eDP1
# xsetwacom set "Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus" MapToOutput eDP1
# xsetwacom set "Wacom Co.,Ltd. Pen and multitouch sensor Pen stylus" MapToOutput eDP1
# touch screen, pointer and eraser
# xinput map-to-output 9 eDP1
# xinput map-to-output 10 eDP1
# xinput map-to-output 16 eDP1

# Start the window manager
#exec awesome

# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

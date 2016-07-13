if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi
xset -dpms
xset s off
echo 200 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity
echo 150 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed

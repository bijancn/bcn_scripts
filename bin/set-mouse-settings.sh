#!/usr/bin/env bash
# mouse settings
echo 200 | tee /sys/devices/platform/i8042/serio1/serio2/sensitivity &
echo 150 | tee /sys/devices/platform/i8042/serio1/serio2/speed &

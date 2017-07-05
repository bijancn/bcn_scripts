#!/bin/sh
autotrash -v -d 30 2>&1 | systemd-cat -t autotrash -p info

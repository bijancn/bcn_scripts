#!/bin/bash
# Killing one random process. Serves as a hand break.

kid=`ps -U bcho | tail -n 1 | awk '{print $1;}'`
kill -9 $kid

#!/bin/sh
pids=`pgrep mupdf`
for pid in $pids; do
  kill -1 $pid
done

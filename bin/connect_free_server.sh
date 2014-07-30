#/bin/bash

j=0
for i in {22..01} ; do
  load=`ssh theoc$i uptime | awk '{print $12}'`
  echo theoc$i: average load during 15 min: ${load}
  load=${load:0:1}
  if [ -z "$1" ]; then
    toskip=0
  else
    toskip=$1
  fi
  if [ ${load} == 0 ]; then
    if [ "$j" = "${toskip}" ]; then
      ssh theoc$i
      break
    fi
    j=$((j+1))
  fi
done

#/bin/bash

for i in {22..01} ; do
  load=`ssh theoc$i uptime | awk '{print $12}'`
  echo theoc$i: average load during 15 min: ${load}
  load=${load:0:1}
  if [ ${load} = 0 ]; then
    ssh theoc$i
    break
  fi
done

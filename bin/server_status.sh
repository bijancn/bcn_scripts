#/bin/bash

for i in {22..01} ; do
  load=`ssh theoc$i uptime | awk '{print $12}'`
  echo theoc$i: average load during 15 min: ${load}
done

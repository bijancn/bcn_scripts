#/bin/bash

j=0
for i in {26..01} ; do
  userload=`ssh bcho@theoc$i uptime | awk '{print "users:", $6, "\tload(15min):", $12}'`
  echo -e "theoc$i \t ${userload}"
done

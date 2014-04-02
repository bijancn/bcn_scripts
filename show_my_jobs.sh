#/bin/bash

for i in {22..01} ; do
  load=`ssh theoc$i ps`
  echo theoc$i
  echo $load
done

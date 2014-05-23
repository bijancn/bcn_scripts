#!/bin/bash
range=192.168.1

is_alive_ping()
{
  ping -c 1 $1 > /dev/null
  [ $? -eq 0 ] && echo $i >> ips.log
}

for i in $range.{2..254} 
do
  is_alive_ping $i & disown
done
cat ips.log | sort -V
rm ips.log

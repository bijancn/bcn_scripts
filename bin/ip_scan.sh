#!/bin/bash
# better alternative if possible : nmap -PS 192.168.2.*
if test "$#" -ne 1; then
    echo "Missing argument. Usage: ip-scan.sh [0-9]*.[0-9]*.[0-9]*"
    exit
fi
range=$1

is_alive_ping()
{
  ping -c 50 $1 > /dev/null
  [ $? -eq 0 ] && echo $i >> ips.log
}

for i in $range.{2..254} 
do
  is_alive_ping $i & disown
done
cat ips.log | sort -V
rm ips.log

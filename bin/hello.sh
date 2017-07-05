#!/bin/bash
if true ; then
  echo "for real"
fi
if ! false ; then
  echo "but not this"
else
  echo "it is false"
fi
if [ "$1" = "-v" ]
then
  echo "switching to verbose output in $0"
  VERBOSE=1
fi
i="0"
while [ $i -lt 4 ]; do
  echo "$i is the best number"
  let i=i+1
done
greeting='Hello '
echo ${greeting}World
echo ${greeting%llo}World
echo ${greeting#He}World
myarray=(one two three 4)
for i in ${myarray[*]}; do
  echo $i
done
for i in ${myarray[*]}; do
  case $i in
    one|two)  echo 'ONE OR TWO' ;;
    three)    echo 'THREE'      ;;
    *)        echo 'no match'   ;;
  esac
done
function fact {
  result=1
  n=$1
  while [ "$n" -ge 1 ]
  do
    let result=n*result
    let n=n-1
  done
  echo $result
}
for i in {1..10}; do
  echo "$i `fact $i`"
done

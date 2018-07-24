#!/bin/bash

function fa () {
  find -iname "*$1*"
}

function count-lines-of-code () {
  echo "`fa \.scala | grep -v html | xargs wc -l | grep total`" | sed 's/ total//'
}

cd src
for commit in $(git rev-list HPO-3268-replace-lis); do
  date=`git log -n 1 --pretty='format:%cd' --date=format:'%Y-%m-%d' $commit`
  git checkout $commit &> /dev/null
  lines=`count-lines-of-code`
  echo "$date $lines"
done

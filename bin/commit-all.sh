#!/bin/bash

DIRS="$HOME/safe/phd/thesis $HOME/vimwiki/"
for dir in $DIRS; do
  echo "-------------- Updating $dir --------------"
  cd $dir
  git add .
  git commit -m "Automatic commit on `date +%F`"
  git push
done

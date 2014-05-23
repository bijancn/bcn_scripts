#/bin/bash

for i in *.sin; do
  folder="${i%.*}"
  mkdir ${folder}
  mv $i ${folder}/run.sin
done

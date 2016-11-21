#!/bin/sh

if [ $# -eq 0 ]
then
  echo "Syntax: $0 PRINTER1 [PRINTER2] [PRINTER3] .."
  exit 1
fi

for i in $*
do
  echo "Going to install DESY printer $i"
  echo "---------"
  echo "Downloading the PostScript Printer Description (PPD)"
  wget http://www-it.desy.de/systems/services/printing/unix/cups/PPD/$i.ppd
  echo "---------"
  echo "Adding $i to CUPS"
  sudo /usr/sbin/lpadmin -p $i -E -v lpd://spool-lpr/$i -P $i.ppd
  echo "---------"
  echo "Removing the downloaded files"
  rm $i.ppd
  echo "---------"
  echo "Done with $i"
  echo "====================="
done

echo "Done with all printers!"

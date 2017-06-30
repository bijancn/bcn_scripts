for i in *$1*/ ; do
  # TODO: (bcn 2017-02-21) combine with or
  # if ! grep 'event sample complete' $i/whizard.log; then
  if ! grep -q 'RES' $i/whizard.log; then
    echo "Not complete in $i"
    cd $i
    qsub ../submit
    rm done
    cd -
  else
    echo "complete in $i"
    touch $i/done
  fi
done

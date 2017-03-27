pids=`ps x | grep -v ssh | grep -v bash | tail -n +2 | awk '{print $1}'`
echo "PIDS: $pids"
for pid in $pids; do
  if ! grep 'kill-my-jobs' /proc/$pid/cmdline; then
    echo "Killing now `ps -p $pid -o comm -p 27598 -o comm=`"
    kill -9 $pid
  fi
done

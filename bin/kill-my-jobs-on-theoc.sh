#/bin/bash

for i in {36..01} ; do
  echo theoc$i
  cmd='for pid in `ps aux | grep "$USER " | grep -v "sshd\|bash\|ps\|grep\|sed\|awk\|bin\/sh\|ssh\|sort" | awk '\''{print $2}'\''`; do kill -9 $pid; done'
  ssh theoc$i $cmd
done

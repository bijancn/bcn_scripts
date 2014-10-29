#/bin/bash

echo -e '%CPU\t%MEM\tSTART\tTIME\tCOMMAND'
for i in {22..16} ; do
  echo theoc$i
  cmd="ps aux | grep bcho | sed 's/\/afs\/desy.de\/user\/b\/bcho//g' | awk -v OFS='\t' '{ print \$3, \$4, \$9, \$10, \$11}' | sort | grep -v 'sshd\|bash\|ps\|grep\|sed\|awk\|bin\/sh\|ssh\|sort'"
  ssh theoc$i $cmd
done

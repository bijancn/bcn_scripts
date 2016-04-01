#/bin/bash

echo -e '%CPU\t%MEM\tSTART\tTIME\tCOMMAND'
for i in {35..01} ; do
  echo theoc$i
  cmd="ps aux | grep '$USER ' | grep -v 'sshd\|bash\|ps\|grep\|sed\|awk\|bin\/sh\|ssh\|sort' | sed 's/\/afs\/desy.de\/user\/b\/bcho//g' | awk -v OFS='\t' '{ print \$3, \$4, \$9, \$10, \$11}' | sort"
  ssh theoc$i $cmd
done

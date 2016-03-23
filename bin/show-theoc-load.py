#!/usr/bin/env python
import subprocess, re, collections
from termcolor import colored
import math

safety = 1
re_l = re.compile("([0-9]+\.[0-9]+), ([0-9]+\.[0-9]+)$")
total_cores = 0
total_use_cores = 0
total_load = 0.0
f = open ('host_file', 'w')
for i in range(36,0,-1):
  machine = "theoc%02d" % (i)
  node = "bcho@" + machine
  ret = subprocess.check_output(["ssh", node, "uptime &&", "who &&",
    "ps -eo pcpu,user | sed -e 's/^[[:space:]]*//' | sort -k1 -r | head -41 |tail -40 &&",
    "grep '^core id' /proc/cpuinfo | sort -u | wc -l &&",
    "echo $(($(grep \"^physical id\" /proc/cpuinfo | awk \'{print $4}\' | sort -un | tail -1)+1))"]);
  lines = ret.split('\n')
  if lines.pop() != '':
    print "show-theoc-load.py: ALERT THIS SHOULD HAVE BEEN EMPTY"
  real_cores = int(lines.pop()) * int(lines.pop())
  total_cores += real_cores
  load5 = float(re_l.search(lines.pop(0)).group(1))
  total_load += min(load5, real_cores)
  users = []
  for line in lines[:-40]:
    users += [line.split(' ')[0]]
  if len(users) > 0:
    users_strg = ','.join(set(users))
  else:
    users_strg = '[]'

  if load5 / real_cores > 0.5:
    color = 'red'
  elif load5 / real_cores < 0.05:
    color = 'green'
  else:
    color = 'yellow'

  top_processes = filter(lambda line: float(line.split(' ')[0]) > 5, lines[-40:])
  top_usage = {}
  for line in top_processes:
    usage = float(line.split(' ')[0])
    user  = line.split(' ')[1]
    tmp = {user: usage}
    try:
      top_usage[user] += usage
    except KeyError:
      top_usage.update(tmp)
  usage_strg = ''
  for user in top_usage:
    usage_strg += user + ':%3.1f' % (top_usage[user]/100) + ' '

  string = machine + " load5: %4.1f" % load5 + '  cores: %2i' % real_cores + \
      "  loggedin:%20s" % users_strg + '  usage: ' + usage_strg
  print colored(string, color)
  use_cores = max(int(math.floor(real_cores - load5 - safety)), 0)
  if use_cores > 0:
    f.write(machine + ':' + str(use_cores) + '\n')
  total_use_cores += use_cores
f.close()
print "="*80
print "total number of cores:" + str(total_cores) + " loaded with " + \
    str(total_load) + " (%4.1f" % (total_load / total_cores * 100) + " %)"
print "going to use " + str(total_use_cores) + " cores with the produced host_file"

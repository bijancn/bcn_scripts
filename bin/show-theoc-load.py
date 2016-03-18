#!/usr/bin/env python
import subprocess, re

re_l = re.compile("([0-9]+\.[0-9]+)$")
for i in range(25,1,-1):
  machine = "theoc%02d" % (i + 1)
  node = "bcho@" + machine
  ret = subprocess.check_output(["ssh", node, "uptime &&", "who"]);
  lines = ret.split('\n')
  users = []
  for line in lines[1:-1]:
    users += [line.split(' ')[0]]
  load15 = re_l.search(lines[0]).group(1)
  print machine, "\tload(15min): ", load15, "\t logged in: ", ' '.join(users)

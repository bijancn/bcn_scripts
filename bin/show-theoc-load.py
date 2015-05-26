#/usr/bin/python
import subprocess, re

re_u = re.compile("([0-9]+) users?")
re_l = re.compile("([0-9]+\.[0-9]+)$")
for i in range(25):
  node = "bcho@theoc%02d" % (i + 1)
  ret = subprocess.check_output(["ssh", node, "uptime"]);
  users = re_u.search(ret).group(1)
  load15 = re_l.search(ret).group(1)
  print node, "\t load(15min): ", load15, "\t users: ", users

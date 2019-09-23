#!/usr/bin/env python3
from tempfile import mkstemp
from shutil import move
from os import fdopen, remove
import git
#  import re

projects = ["erp-api-service", "inventory-api-service", "api-auth-service", "contacts-api-service", "salesorders-api-service"]

#  version = re.compile('sbtN4BuildVersion = ".*"')

def show(file_path, pattern):
  with open(file_path) as old_file:
    for line in old_file:
      if (pattern in line):
        print(line)

def replace(file_path, pattern, subst):
    fh, abs_path = mkstemp()
    with fdopen(fh,'w') as new_file:
        with open(file_path) as old_file:
            for line in old_file:
                #  version.match(line)
                #  new_file.write(line.replace(pattern, subst))
                if (pattern in line):
                  new_file.write(subst)
    remove(file_path)
    move(abs_path, file_path)

def latest(project):
  g = git.cmd.Git(project)
  g.checkout("master")
  g.pull()

for project in projects:
  print("### " + project + " ###")
  latest(project)
  show(project + "/project/plugins.sbt", 'sbtN4BuildVersion = "')
  replace(project + "/project/plugins.sbt", 'sbtN4BuildVersion = "', 'val sbtN4BuildVersion = "0.5.4"')

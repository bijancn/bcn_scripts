#!/usr/bin/env python

import os
import sys
import argparse
import shutil
import subprocess
from distutils import spawn
from bcn_tools import *

# Parse command line options
parser = argparse.ArgumentParser(description='Check the Whizard')

# optional tasks that will be performed
parser.add_argument("-c", '--clean', action='store_true',
    help='Perform clean rebuilds')

# options how to behave
parser.add_argument("-j", '--jobs', default=2,
    help='Set number of jobs for make and make check')
parser.add_argument("-n", '--noerrors', action='store_true',
    help='Hide STDERR during all executed commands')

args = parser.parse_args()

# Select a base path
base_path = get_base_path()

nostatic_builds = ['develop', 'extended', 'quadruple', 'ifort-stdsemantics',
                   'ifort-quadruple', 'ifort', 'nagfor-jenkins', 'dist']
builds = ['nagfor-dist-disabled'] + [b + '-nostatic' for b in nostatic_builds]
# builds = ['nagfor-jenkins-develop']

print 'builds to consider:', builds

def run(cmd, log_filename):
  logfilen = log_filename.replace(' ', '_')
  with open(logfilen, 'wb', 0) as logfile:
    return subprocess.Popen(cmd, stdout=logfile)

if args.clean:
  flag = '-A'
else:
  flag = '-mk'
cmds = []
for b in builds:
  if 'dist' in b:
    this_flag = flag + 'd'
  else:
    this_flag = flag
  cmd = ['time', 'build-tool.py', b, '-j' + str(args.jobs), this_flag]
  cmds.append(cmd)

for c in cmds:
  print ('c =    ', c) ### Debugging

processes = {run(c, 'subprocess.%s.log' % c) for c in cmds}
while processes:
    for p in processes:
        if p.poll() is not None:
           processes.remove(p)
           print('{} done, status {}'.format(p.args, p.returncode))
           break

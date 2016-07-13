#!/usr/bin/env python

import argparse
import subprocess
from bcn_tools import get_base_path

# Parse command line options
parser = argparse.ArgumentParser(description='Check the Whizard',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

# optional tasks that will be performed
parser.add_argument("-c", '--clean', action='store_true',
    help='Perform clean rebuilds')

# options how to behave
parser.add_argument("-j", '--jobs', default=2,
    help='Set number of jobs for make and make check')

args = parser.parse_args()

# Select a base path
base_path = get_base_path()

nostatic_builds = ['extended', 'gfortran', 'ifort-stdsemantics',
                   'ifort-quadruple', 'nagfor-jenkins', 'dist']
builds = ['nagfor-dist-disabled'] + [b + '-nostatic' for b in nostatic_builds]

print 'builds to consider:', builds


def run(cmd, log_filename):
  logfilen = log_filename.replace(' ', '_')
  with open(logfilen, 'wb', 0) as logfile:
    return (cmd, subprocess.Popen(cmd, stdout=logfile))

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
  print ('c =    ', c)

processes = [run(c, 'subprocess.%s.log' % c) for c in cmds]
while processes:
  for p in processes:
    if p[1].poll() is not None:
      processes.remove(p)
      print "Done with " + str(p[0]) + "return code is " + str(p[1].returncode)
      break

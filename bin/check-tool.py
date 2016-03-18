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
                   'ifort-quadruple', 'ifort', 'nagfor-jenkins', 'disabled']
builds = ['ifort-dist'] + [b + '-nostatic' for b in nostatic_builds]
# builds = ['nagfor-jenkins-develop']

print 'builds to consider:', builds

if args.clean:
  flag = '-A'
else:
  flag = '-mk'
for b in builds:
  if 'dist' in b:
    this_flag = flag + 'd'
  else:
    this_flag = flag
  cmd = ['time', 'build-tool.py', b, '-j' + str(args.jobs), this_flag]
  print 'calling ', cmd
  subprocess.Popen(cmd)

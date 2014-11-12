#!/usr/bin/env python

import os
import sys
import argparse
import shutil
import subprocess
import collections

def mkdirs(directory):
  if not os.path.exists(directory):
    os.makedirs(directory)

def show_file(fname):
  with open(fname, 'r') as fin:
    print fin.read()

def call_verbose(action):
  if isinstance(action, list): string = ' '.join(action)
  else: string = action
  print('Performing ' + string + ' ...\n')
  try:
    # Redirect stderr to stdout
    if args.errors: log = subprocess.check_output(action)
    else:           log = subprocess.check_output(action, stderr=subprocess.STDOUT)
    show = []
    interesting = ['Package name:', 'Version:', 'Date:', 'Status:', 'version',
                   ' path.', ' path ']
    for line in log.splitlines():
      for interest in interesting:
        if interest in line:
          show.append(line)
    print('\n'.join(list(collections.OrderedDict.fromkeys(show))))
  except (subprocess.CalledProcessError, OSError) as e:
    print("Execution of " + string + " failed:\n" + str(e) + '\n' + e.output)
  print('\n... done!')

# Parse command line options
parser = argparse.ArgumentParser(description='Build the Whizard')
parser.add_argument('build', help='The name of the build')
parser.add_argument('tag', nargs='?',
    help='Optional tag, if given, add to buildname: build-tag')

# optional tasks that will be performed
parser.add_argument("-c", '--configure', action='store_true',
    help='Perform configure')
parser.add_argument("-a", '--autoreconf', action='store_true',
    help='Perform autoreconf')
parser.add_argument("-m", '--make', action='store_true',
    help='Perform make')
parser.add_argument("-k", '--makecheck', action='store_true',
    help='Perform make check')
parser.add_argument("-r", '--remove', action='store_true',
    help='Remove build dir before building')

# options how to behave
parser.add_argument("-j", '--jobs', default=1,
    help='Set number of jobs for make and make check')
parser.add_argument("-e", '--errors', action='store_true',
    help='Show STDERR during all executed commands')

# options that result in another build folder
parser.add_argument("-C", '--configureflags', action='append',
    help='Set configure flags')
parser.add_argument("-o", '--compiler', action='append',
    help="Add this compiler to build list. Default: -FC=['gfortran']")
parser.add_argument("-O", '--optimization', action='append', metavar='X',
    help="Add this optimization flag to the compiler(s). Default: -O['2']")
parser.add_argument("-f", '--fcflags', action='append',
    help="Add this flag to the compiler(s) (optimization see above). Default:" +
         " -FCFLAGS=['-fmax-errors=1 -O2 -fbounds-check']")
parser.add_argument("-p", '--openmp', action='store_true',
    help='Activate OpenMP')
args = parser.parse_args()

# Select a base path
base_paths = ['~/trunk', '/data/bcho/trunk']
for bpath in base_paths:
  if os.path.exists(bpath):
    base_path = bpath
try:
  print('base_path'.ljust(17) + '=\t' + base_path)
except NameError:
  print('No known base directory found!')
  sys.exit(1)

# Default compiler and optimization level
#def set_default(option, value):
  #if not args.getitem(option):
    #args.setitem(option) = [value]
#set_default('compiler', 'gfortran')
if not args.compiler:
  args.compiler = ['gfortran']
if not args.optimization:
  args.optimization = ['2']
if not args.fcflags:
  args.fcflags = ['-fmax-errors=1 -fbounds-check']
if not args.configureflags:
  args.configureflags = ['']

# Convenience builds
if 'ifort' in args.build:
  args.compiler = ['ifort']
  args.optimization = ['3']
  args.fcflags = ['']

if 'omp' in args.build:
  args.configureflags = ['--enable-fc-openmp']

# show set options for builder
tasks = ['configure', 'autoreconf', 'make', 'makecheck', 'remove']
options = ['jobs', 'errors']
variants = ['configureflags', 'compiler', 'optimization', 'fcflags', 'build', 'tag']
arg_dict = vars(args)
for item in tasks + options + variants:
  print(item.ljust(17) + '=\t' + str(arg_dict[item]))

# autoreconf if desired
os.chdir(base_path)
if args.autoreconf:
  call_verbose('autoreconf')

# create build dirs
build_name = args.build
if args.tag:
  build_name += '-' + args.tag
build_path = os.path.join('build', build_name)
if args.remove:
  shutil.rmtree(build_path)
mkdirs(build_path)
os.chdir(build_path)

# configure if desired
compiler = args.compiler[0]
optimization = args.optimization[0]
fcflags = args.fcflags[0]
configureflags = args.configureflags[0]

prefix = '--prefix=' + os.path.join(base_path, 'install', build_name)
fortran_compiler = 'FC=' + compiler
fortran_flags = "FCFLAGS=-O" + optimization + " " + fcflags
configure_options = [prefix, fortran_compiler, fortran_flags, configureflags]
if args.configure:
  if compiler == 'ifort': package = os.path.join(base_path, 'omega')
  else:                   package = base_path
  call_verbose([os.path.join(package, 'configure')] + configure_options)

# build if desired
if args.make:
  call_verbose(['make', '-j' + args.jobs])
  call_verbose(['make', '-j' + args.jobs, 'install'])

# check if desired
if args.makecheck:
  call_verbose(['make', '-j' + args.jobs, 'check'])
  show_file(os.path.join('tests', 'test-suite.log'))

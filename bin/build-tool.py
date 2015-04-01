#!/usr/bin/env python

import os
import sys
import argparse
import shutil
from bcn_tools import *

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
parser.add_argument("-A", '--all', action='store_true',
    help='Remove, configure, make, make check')

# options how to behave
parser.add_argument("-j", '--jobs', default=4,
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
parser.add_argument('--only_omega', action='store_true',
    help='Only build the OMega subpackage.')

args = parser.parse_args()

# Select a base path
base_path = get_base_path()

# -fbounds-check is included in fcheck=all. Does not play well with the gosam
# interface however
warnings = '-fmax-errors=1 -Wall -Wuninitialized -Wextra -fno-whole-program '
# gcc doesn't recognize our test function construction as use of a function
warnings += '-Wno-unused-function -Wno-unused-parameter -Wno-unused-dummy-argument '
warnings += '-fimplicit-none -pedantic -fbacktrace '
if not args.compiler:
  args.compiler = ['gfortran']
if not args.optimization:
  args.optimization = ['2']
if not args.fcflags:
  args.fcflags = [warnings]
if not args.configureflags:
  args.configureflags = [['--enable-fastjet']]

# Convenience magic
if 'ifort' in args.build:
  args.compiler = ['ifort']
  args.optimization = ['3']
  args.fcflags = ['']
  args.only_omega = True

if 'pgf' in args.build:
  args.compiler = ['pgf90_2015']
  args.optimization = ['0']
  args.fcflags = ['']

if 'pgf95' in args.build:
  args.compiler = ['pgf95_2015']
  args.optimization = ['0']
  args.fcflags = ['']

if 'gosam' in args.build:
  args.fcflags = [warnings]
  gosam_dir = os.path.expanduser('~/hep/GoSam/local')
  gosam_options = ['--with-gosam=', '--with-golem=', '--with-samurai=',
                   '--with-ninja=', '--with-form=', '--with-qgraf=']
  gosam_dirs = [go + gosam_dir for go in gosam_options]
  args.configureflags[0] += ['--enable-gosam']

if 'openloops' in args.build:
  args.fcflags = [warnings]
  openloops_dir = os.path.expanduser('~/hep/OpenLoops')
  args.configureflags[0] += ['--enable-openloops']
  args.configureflags[0] += ['--with-openloops=' + openloops_dir]

if 'omega' in args.build:
  args.only_omega = True

if 'omp' in args.build:
  args.configureflags[0] += ['--enable-fc-openmp']

if 'slim' in args.build:
  args.configureflags[0] += ['--disable-pythia6', '--disable-static',
                          '--disable-omega']

if 'profile' in args.build:
  args.optimization = ['2']
  args.configureflags[0] += ['--enable-fc-profiling', '--enable-static']

if 'dist' in args.build:
  args.optimization = ['0']
  args.configureflags[0] += ['--enable-distribution']

if 'extended' in args.build:
  args.optimization = ['0']
  args.fcflags = [warnings + '-fcheck=all ']
  args.configureflags[0] += ['--enable-fc-extended']

if 'develop' in args.build:
  args.optimization = ['0']
  args.fcflags = [warnings]
  args.configureflags[0] += ['--disable-static']

debug_warnings = warnings + '-g -fcheck=all ' + \
    '-ffpe-trap=invalid,zero,overflow,underflow,denormal'
if 'debug' in args.build:
  args.optimization = ['0']
  args.fcflags = [debug_warnings]
  args.configureflags[0] = ['--enable-fc-profiling']

if 'debugnan' in args.build:
  args.compiler = ['gfortran']
  args.optimization = ['0']
  args.fcflags = [debug_warnings + '-finit-real=nan']
  args.configureflags[0] = ['--enable-fc-profiling']

if args.all:
  args.remove = True
  args.configure = True
  args.make = True
  args.makecheck = True

# show set options for builder
tasks = ['autoreconf', 'remove', 'configure', 'make', 'makecheck', 'all']
options = ['jobs', 'errors']
variants = ['configureflags', 'compiler', 'optimization', 'fcflags', 'build', 'tag']
arg_dict = vars(args)
for item in tasks + options + variants:
  show_variable(item, arg_dict[item])

def _call_verbose(cmd):
  lines_to_show = ['Package name:', 'Version:', 'Date:', 'Status:', 'version',
                   ' path.', ' path ']
  call_verbose(cmd, filter_strgs=lines_to_show, show_errors=args.errors)

# autoreconf if desired
os.chdir(base_path)
if args.autoreconf:
  _call_verbose('autoreconf')

# create build dirs
build_name = args.build
if args.tag:
  build_name += '-' + args.tag
build_path = os.path.join('_build', build_name)
if args.remove:
  if os.path.isdir(build_path):
    shutil.rmtree(build_path)
mkdirs(build_path)
os.chdir(build_path)

# configure if desired
compiler = args.compiler[0]
optimization = args.optimization[0]
fcflags = args.fcflags[0]
configureflags = args.configureflags[0]

prefix = '--prefix=' + os.path.join(base_path, '_install', build_name)
fortran_compiler = 'FC=' + compiler
fortran_flags = "FCFLAGS=-O" + optimization + " " + fcflags
configure_options = [prefix, fortran_compiler, fortran_flags] + configureflags
if args.configure:
  if args.only_omega: package = os.path.join(base_path, 'omega')
  else:                   package = base_path
  _call_verbose([os.path.join(package, 'configure')] + configure_options)

# build if desired
if args.make:
  _call_verbose(['make', '-j' + str(args.jobs)])
  _call_verbose(['make', '-j' + str(args.jobs), 'install'])

# check if desired
if args.makecheck:
  _call_verbose(['make', '-j' + str(args.jobs), 'check'])
  show_file(os.path.join('tests', 'test-suite.log'))

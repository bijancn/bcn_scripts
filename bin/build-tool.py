#!/usr/bin/env python

import os
import sys
import argparse
import shutil
from distutils import spawn
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
gf_warnings = '-fmax-errors=1 -Wall -Wuninitialized -Wextra -fno-whole-program '
# gcc doesn't recognize our test function construction as use of a function
gf_warnings += '-Wno-unused-function -Wno-unused-parameter -Wno-unused-dummy-argument '
# -fimplicit-none does not work with the PDFs
gf_warnings += '-pedantic -fbacktrace '
gf_debug_warnings = gf_warnings + '-fcheck=all -ggdb ' + \
    '-ffpe-trap=invalid,zero,overflow,underflow,denormal '
if not args.compiler:
  args.compiler = 'gfortran'
if not args.fcflags:
  args.fcflags = gf_warnings
if not args.configureflags:
  args.configureflags = []

# Plugins
if spawn.find_executable('fastjet-config'):
  args.configureflags += ['--enable-fastjet']

if spawn.find_executable('gosam-config.py'):
  args.configureflags += ['--enable-gosam']

# Need to build my own
#fmcfio = '/afs/desy.de/group/theorie/software/ELF64/lib/libFmcfio.a'
#if os.path.isfile(fmcfio):
  #args.configureflags += ['FMCFIO=' + fmcfio]
#stdhep = '/afs/desy.de/group/theorie/software/ELF64/lib/libstdhep.a'
#if os.path.isfile(stdhep):
  #args.configureflags += ['STDHEP=' + stdhep]

if spawn.find_executable('simjob'):
  args.configureflags += ['--enable-lcio']

ol_path = None
for path in os.environ["LD_LIBRARY_PATH"].split(':'):
  if 'OpenLoops' in path:
    ol_path = path
if ol_path:
  args.configureflags += ['--enable-openloops',
                          '--with-openloops=' + ol_path[0:-3]]


# Convenience magic
if 'pgf' in args.build:
  args.compiler = 'pgf90_2015'

if 'omega' in args.build:
  args.only_omega = True

if 'omp' in args.build:
  args.configureflags += ['--enable-fc-openmp']

if 'autoparallel' in args.build:
  graphite_enabled = False
  cores = 8
  args.fcflags = ''
  args.fcflags += '-ftree-parallelize-loops=' + str(cores) + ' '
  if graphite_enabled:
    args.fcflags += '-floop-parallelize-all '

if 'vectorize' in args.build:
  args.optimization = '3'
  args.fcflags += '-ftree-vectorizer-verbose=2 '

if 'disabled' in args.build:
  args.configureflags += ['--disable-pythia6', '--disable-static',
                          '--disable-omega']

if 'profile' in args.build:
  args.configureflags += ['--enable-fc-profiling', '--enable-static']

if 'dist' in args.build:
  args.configureflags += ['--enable-distribution']

if 'extended' in args.build:
  args.configureflags += ['--enable-fc-extended', '--with-precision=extended']

if 'develop' in args.build:
  args.fcflags += '-fcheck=all '
  args.configureflags += ['--disable-static']

if 'ifort' in args.build:
  args.compiler = 'ifort'
  args.optimization = '3'
  args.fcflags = ' '

if 'nagfor' in args.build:
  args.compiler = 'nagfor'
  if args.optimization is None:
    args.optimization = '1'
  # -gline         Compile code to produce a traceback if an error occurs.
  # -C=all         Maximum runtime checking.
  # => doesnt work with LHAPDF6 somehow due to q2max
  # -mtrace=all    Enable all memory allocation options.
  # -nan           Set unSAVEd local variables etc. to signalling NaN.
  # -maxcontin=512 Increase max number of continuation lines to 512
  args.fcflags = '-colour'

if 'nagfor-jenkins' in args.build:
  args.compiler = 'nagfor'
  args.optimization = '0'
  args.fcflags = '-C=all -nan -w -f2003 -gline -maxcontin=512'

if 'debug' in args.build:
  args.optimization = '0'
  if args.compiler == 'nagfor':
    args.fcflags = '-g -gline -mtrace=all -colour '
  elif args.compiler == 'gfortran':
    args.fcflags = gf_debug_warnings
  args.configureflags += ['--enable-fc-profiling']

if 'NaN' in args.build:
  args.optimization = '0'
  if args.compiler == 'nagfor':
    args.fcflags += '-nan '
  elif args.compiler == 'gfortran':
    args.fcflags += '-finit-real=nan '

if not args.optimization:
  args.optimization = '2'
else:
  args.optimization = ' '.join(args.optimization)

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
show_variable('base_path', base_path)
for item in tasks + options + variants:
  show_variable(item, arg_dict[item])

def _call_verbose(cmd):
  lines_to_show = ['Package name:', 'Version:', 'Date:', 'Status:', 'version',
                   ' path.', ' path ', 'checking for ']
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
compiler = args.compiler
optimization = args.optimization
fcflags = args.fcflags
configureflags = args.configureflags

prefix = '--prefix=' + os.path.join(base_path, '_install', build_name)
fortran_compiler = 'FC=' + compiler
fortran_flags = "FCFLAGS=-O" + optimization + " " + fcflags
configure_options = [prefix, fortran_compiler, fortran_flags] + configureflags
if args.configure:
  if args.only_omega: package = os.path.join(base_path, 'omega')
  else:               package = base_path
  _call_verbose([os.path.join(package, 'configure')] + configure_options)

# build if desired
if args.make:
  _call_verbose(['make', '-j' + str(args.jobs)])
  _call_verbose(['make', '-j' + str(args.jobs), 'install'])

# check if desired
if args.makecheck:
  _call_verbose(['make', '-j' + str(args.jobs), 'check'])

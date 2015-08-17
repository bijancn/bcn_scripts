# encoding=utf-8 ==============================================================#
#                                  bcn_tools                                   #
#==============================================================================#

from __future__ import print_function
import os
import subprocess
import collections
import textwrap
from termcolor import colored, cprint
import sys

def mkdirs(directory):
  if not os.path.exists(directory):
    os.makedirs(directory)

def show_file(fname):
  with open(fname, 'r') as fin:
    print(fin.read())

def make_filename(strg):
  strg = strg.replace(' ', '_')
  strg = strg.replace(get_base_path(), '')
  strg = strg.replace(r'/', '')
  strg = (strg[:130] + '..') if len(strg) > 130 else strg
  return strg

def pcmd(strg):
  return colored(strg, 'blue', attrs=['bold'])

def perr(strg):
  return colored(strg, 'red', attrs=['bold'])

def pgood(strg):
  return colored(strg, 'green', attrs=['bold'])

def plog(strg):
  return colored(strg, 'blue')

def call_verbose(action, filter_strgs=None, show_errors=False):
  if isinstance(action, list): string = ' '.join(action)
  else: string = action
  print(pcmd('Performing ') + plog(string) + pcmd(' ...\n'))
  try:
    # Redirect stderr to stdout
    if show_errors: log = subprocess.check_output(action)
    else:           log = subprocess.check_output(action, stderr=subprocess.STDOUT)
    show = []
    if filter_strgs:
      for line in log.splitlines():
        for interest in filter_strgs:
          if interest in line:
            show.append(line)
      print('\n'.join(list(collections.OrderedDict.fromkeys(show))))
    else:
      print(log)
    with open('log_' + make_filename(string), 'w') as fout:
      fout.write(log)
  except (subprocess.CalledProcessError, OSError) as e:
    print(pcmd("Execution of ") + plog(string) + pcmd(" failed:\n") +\
        perr(str(e)) + '\n' + e.output)
  print(pcmd('\n... done!'))

def show_variable(var_name, var):
  varlist = None
  if isinstance(var, bool):
    if var:
      smb = '✓'
      text2 = pgood(smb)
    else:
      smb = '✗'
      text2 = perr(smb)
  else:
    varlist = textwrap.wrap(str(var))
    if len(varlist) > 0:
      text2 = plog(varlist[0])
    else:
      text2 = ''
  text1 = pcmd(var_name.ljust(17))
  print(text1 + '  =  ' + text2)
  if varlist:
    text1 = ''.ljust(17)
    for s in varlist[1:]:
      text2 = plog(s)
      print(text1 + '      ' + text2)

def get_base_path():
  base_paths = ['/data/bcho/trunk', '~/trunk', '/scratch/bcho/trunk']
  base_paths = map(os.path.expanduser, base_paths)
  for bpath in base_paths:
    if os.path.exists(bpath):
      base_path = bpath
  try:
    return base_path
  except NameError:
    print('No known base directory found!')
    sys.exit(1)

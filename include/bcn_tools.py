from __future__ import print_function
import os
import subprocess
import collections

def mkdirs(directory):
  if not os.path.exists(directory):
    os.makedirs(directory)

def show_file(fname):
  with open(fname, 'r') as fin:
    print(fin.read())

def call_verbose(action, filter_strgs=None, show_errors=False):
  if isinstance(action, list): string = ' '.join(action)
  else: string = action
  print('Performing ' + string + ' ...\n')
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
  except (subprocess.CalledProcessError, OSError) as e:
    print("Execution of " + string + " failed:\n" + str(e) + '\n' + e.output)
  print('\n... done!')

def show_variable(var_name, var):
  print(var_name.ljust(17) + '=\t' + str(var))

def get_base_path():
  base_paths = ['~/trunk', '/data/bcho/trunk']
  base_paths = map(os.path.expanduser, base_paths)
  for bpath in base_paths:
    if os.path.exists(bpath):
      base_path = bpath
  try:
    show_variable('base_path', base_path)
    return base_path
  except NameError:
    print('No known base directory found!')
    sys.exit(1)

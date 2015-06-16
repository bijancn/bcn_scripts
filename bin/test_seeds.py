#!/usr/bin/env python
# Run the same file with N different seeds

import os
import subprocess
import shutil
import fileinput
import multiprocessing as mp

N = 50
init_file = 'run.sin'
whiz = '~/trunk-install/bin/whizard -r '
#N_proc = mp.cpu_count()
N_proc = 12

class cd:
    """Context manager for changing the current working directory"""
    def __init__(self, newPath):
        self.newPath = newPath

    def __enter__(self):
        self.savedPath = os.getcwd()
        os.chdir(self.newPath)

    def __exit__(self, etype, value, traceback):
        os.chdir(self.savedPath)

def run(i):
  directory = 'dir_' + str(i)
  if not os.path.exists(directory):
      os.makedirs(directory)
  shutil.copyfile(init_file, directory + '/' + init_file)
  with cd(directory):
    # Somehow adds empty lines but I don't care in this context
    for line in fileinput.input(init_file, inplace=True):
      line = line.replace('seed = 1','seed = ' + str(i+1))
      print line
    subprocess.call(whiz + init_file, shell=True)

if __name__ == "__main__":
  pool = mp.Pool(processes=N_proc)
  results = pool.map(run, range(N))

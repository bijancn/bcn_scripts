#!/usr/bin/python

import os
import sys
import re
import subprocess
import shutil
import fileinput
import multiprocessing as mp

N_proc = 12

base_dir = '/scratch/bcho'
if not os.path.exists(base_dir):
  base_dir = '/data/bcho'
if not os.path.exists(base_dir):
  base_dir = '~'
print('Using ' + base_dir + ' as base_dir.')

bytecode_dir = base_dir + '/bytecodes'
if not os.path.exists(bytecode_dir):
  os.makedirs(bytecode_dir)
bin_dir = base_dir + '/trunk/install/ifort/bin'
QCD = bin_dir + '/omega_QCD_VM.opt'
QED = bin_dir + '/omega_QED_VM.opt'
SM = bin_dir + '/omega_SM_VM.opt'
binaries = [QCD, QED, SM]
if not any(map(os.path.isfile, binaries)):
  sys.exit('At least one of ' + ' '.join(binaries) + ' were not found!')

processes_QCD = ['u u -> u u',
                 'u u -> u d',
                 'u d -> u d',
                 'u d -> u d',
                 'u ubar -> u ubar',
                 'u ubar -> t tbar',
                 't tbar -> t tbar',
                 'u ubar -> d dbar',
                 'u ubar -> gl gl',
                 'u gl -> u gl',
                 'gl gl -> gl gl',
                 'gl gl -> u ubar' ]

def gluons_amplitude(n):
  return 'gl gl ->' + ' gl' * n

def photons_amplitude(n):
  return 'e+ e- ->' + ' A' * n

def repl(match):
  return match.group(1) + str(len(match.group(2)))

def file_name_of_proc(proc):
  proc = proc.replace(' -> ', '_to_')
  proc = re.sub(r"(.*_to_)([ A]*)", repl, proc)
  return proc

for i in range(7):
  print photons_amplitude(i)
  print file_name_of_proc(photons_amplitude(i))

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

#if __name__ == "__main__":
  #pool = mp.Pool(processes=N_proc)
  #results = pool.map(run, range(N))

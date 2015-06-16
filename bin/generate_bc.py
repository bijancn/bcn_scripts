#!/usr/bin/env python

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
  base_dir = os.path.expanduser('~')
print('Using ' + base_dir + ' as base_dir.')

bytecode_dir = base_dir + '/bytecodes'
if not os.path.exists(bytecode_dir):
  os.makedirs(bytecode_dir)
bin_dir = base_dir + '/trunk/install/ifort/bin'
bin_QCD = bin_dir + '/omega_QCD_VM.opt'
bin_QED = bin_dir + '/omega_QED_VM.opt'
bin_SM = bin_dir + '/omega_SM_VM.opt'
binaries = [bin_QCD, bin_QED, bin_SM]
binaries_F95 = map(lambda x: x.replace('_VM', ''), binaries)
bin_QCD_F95, bin_QED_F95, bin_SM_F95 = binaries_F95
if not any(map(os.path.isfile, binaries)):
  sys.exit('At least one of ' + ' '.join(binaries) + ' were not found!')
binaries2 = [binaries, binaries_F95]

def gluons_amplitude(n):
  return 'gl gl ->' + ' gl' * n

def photons_amplitude(n):
  return 'e+ e- ->' + ' A' * n

def file_name_of_proc(proc, flv=None):
  if flv:
    def repl(match):
      if len(flv) == 1:
        return match.group(1) + str(len(match.group(2))/2+1)
      elif len(flv) == 2:
        return match.group(1) + str((len(match.group(2))+1)/3)
      else:
        raise ValueError("Not tested")
    proc = re.sub(r"(.* -> )([ (" + flv + ")]*)", repl, proc)
    proc = proc + flv
  proc = proc.replace(':', '-')
  proc = proc.replace(' -> ', '_to_')
  proc = proc.replace(' ', '')
  return proc

def test_file_name_of_proc():
  from nose.tools import eq_
  eq_(file_name_of_proc(photons_amplitude(1), 'A'), 'e+e-_to_1A')
  eq_(file_name_of_proc(photons_amplitude(2), 'A'), 'e+e-_to_2A')
  eq_(file_name_of_proc(photons_amplitude(5), 'A'), 'e+e-_to_5A')
  eq_(file_name_of_proc(gluons_amplitude(1), 'gl'), 'glgl_to_1gl')
  eq_(file_name_of_proc(gluons_amplitude(6), 'gl'), 'glgl_to_6gl')
  eq_(file_name_of_proc('u u -> u d'), 'uu_to_ud')
  eq_(file_name_of_proc('u:d u -> u:d d'), 'u-du_to_u-dd')
  eq_(file_name_of_proc('u u -> u u', 'u'), 'uu_to_2u')
  eq_(file_name_of_proc('u ubar -> t tbar'), 'uubar_to_ttbar')

def produce_bc(binary, process, suffix):
  filename = os.path.join(bytecode_dir, file_name_of_proc(process)) + \
                                                                '.' + suffix
  cmd = binary + " -scatter '" + process + "' > " + filename
  print cmd
  subprocess.call(cmd, shell=True)

def produce(i, process, suffix):
  if suffix == 'hbc':
    produce_bc(binaries2[0][i], process, suffix)
  else:
    produce_bc(binaries2[1][i], process, suffix)

def produce_QCD(process):
  produce(0, process, 'hbc')

def produce_QCD_F95(process):
  produce(0, process, 'f95')

def produce_QED(process):
  produce(0, process, 'hbc')

def produce_QED_F95(process):
  produce(0, process, 'f95')

def produce_SM(process):
  produce(0, process, 'hbc')

def produce_SM_F95(process):
  produce(0, process, 'f95')

processes_QCD = ['u u -> u u',
                 'u u -> u d',
                 'u d -> u d',
                 'u u:d -> u u:d',
                 'u ubar -> u ubar',
                 'u ubar -> t tbar',
                 't tbar -> t tbar',
                 'u ubar -> gl gl',
                 'u gl -> u gl',
                 'u:d gl -> u:d gl',
                 'gl gl -> u ubar' ]

processes_QCD += map(gluons_amplitude, range(2,6))

if __name__ == "__main__":
  pool = mp.Pool(processes=N_proc)
  results = pool.map(produce_QCD, processes_QCD)
  results = pool.map(produce_QCD_F95, processes_QCD)

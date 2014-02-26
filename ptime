#!/usr/bin/python
# Allows to time an executable reliably with several reruns
# Copy me to /usr/bin/ptime
import sys
import os.path
import timeit
import subprocess as sp
import numpy as np

reruns = 3

def execute(cmd):
  p = sp.Popen(cmd, stdout=sp.PIPE, stderr=sp.PIPE, shell=True)
  stdout, stderr = p.communicate()
  #print stdout

def speedtest(exe):
  t = timeit.Timer(lambda : execute(exe))
  times = t.repeat(repeat=reruns, number=1)
  print "Mean:\t", np.mean(times)
  print "Error:\t", np.std(times)

try:
  exe = str(sys.argv[1])
except IndexError:
  print 'Give me an executable to measure!'
  sys.exit(2)

try:
  reruns = int(sys.argv[2])
except IndexError:
  print 'Using 3 runs to measure'

speedtest(exe)

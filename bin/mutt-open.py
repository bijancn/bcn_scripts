#!/usr/bin/env python

import sys
import os
import hashlib
from shutil import copyfile
from subprocess import call


def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

if __name__ == '__main__':
  print 'sys.argv = ', sys.argv # Debugging
  if (len(sys.argv) < 2):
      print('Usage: %s <filename> [suffix]')
      sys.exit(-1)

  oldfile = sys.argv[1]

  suffix = str(md5(oldfile)) + '_' + os.path.basename(oldfile)
  if len(sys.argv) == 3:
      suffix += sys.argv[2]

  #newfile = mkstemp(suffix=suffix, prefix='mutt_bak_')[1]
  newfile = os.path.join('/tmp', 'mutt_bak_' + suffix)

  copyfile(oldfile, newfile)
  call(['gnome-open', newfile])

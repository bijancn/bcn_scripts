# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# bcn relink_bcn.sh - Create soft links from this repo to the home folder
#
# Copyright (C) 2014         Bijan Chokoufe Nejad         <bijan@chokoufe.com>
# Recent versions:  https://github.com/bijancn/bcn_scripts
#
# This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
# can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
# http://www.gnu.org/licenses/gpl-2.0-standalone.html
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#!/usr/bin/env python
# svn merge-tool python wrapper for meld
import sys
import subprocess

try:
   # path to meld
   meld = "/usr/bin/meld"

   # file paths
   base   = sys.argv[1]
   theirs = sys.argv[2]
   mine   = sys.argv[3]
   merged = sys.argv[4]

   # the call to meld
   cmd = [meld, mine, base, theirs, merged]

   # Call meld, making sure it exits correctly
   # TODO: (bcn 2014-08-11) This most likely has to be changed to the new
   # version of meld
   subprocess.check_call(cmd)
except:
   print "There has been an error!"
   sys.exit(-1)

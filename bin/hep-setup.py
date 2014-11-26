#!/usr/bin/env python

#import sys
#import argparse
#import shutil
import wgetter
import tarfile
from bcn_tools import *

def install(package, source, configure_options):
  tfile = package + '.tar.gz'
  filename = wgetter.download(source + tfile, outdir=os.path.join(home, 'Downloads'))
  tar = tarfile.open(name=os.path.join(home, 'Downloads', tfile), mode='r:gz')
  tar.extractall()
  os.chdir(os.path.join(hep, package))
  mkdirs('build')
  os.chdir('build')
  prefix = '--prefix=' + os.path.join(home, 'install')
  call_verbose(['../configure', prefix] + configure_options)
  call_verbose(['make'])
  call_verbose(['make', '-j'])
  call_verbose(['make', '-j', 'install'])
  call_verbose(['make', '-j', 'check'])

def get_PDFs(version, source, pdfsets):
  pdf_source = source + 'pdfsets/' + version + '/'
  for pdfset in sets:
    tfile = pdfset + '.tar.gz'
    print 'Getting ' + pdfset
    filename = wgetter.download(pdf_source + tfile, outdir=os.path.join(home, 'Downloads'))
    tar = tarfile.open(name=os.path.join(home, 'Downloads', tfile), mode='r:gz')
    tar.extractall(path=os.path.join(home, 'install', 'share', 'LHAPDF'))

home = os.path.expanduser('~')
hep = os.path.join(home, 'hep')
mkdirs(hep)

package = 'HepMC-2.06.09'
source = 'http://lcgapp.cern.ch/project/simu/HepMC/download/'
configure_options = ['--with-momentum=GEV', '--with-length=MM']
#install(package, source, configure_options)

version = '6.1.4'
package = 'LHAPDF-' + version
source = 'http://www.hepforge.org/archive/lhapdf/'
configure_options = []
sets = ['CT10nlo', 'CT10', 'MSTW2008lo68cl', 'MSTW2008nlo90cl']
#install(package, source, configure_options)
get_PDFs(version, source, sets)

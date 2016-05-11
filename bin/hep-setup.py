#!/usr/bin/env python

import wgetter
import tarfile
from bcn_tools import *
import sys
import os

# Monkey patch default SSL
# (https://github.com/mtschirs/quizduellapi/issues/://github.com/mtschirs/quizduellapi/issues/2)
import ssl
if hasattr(ssl, '_create_unverified_context'):
  ssl._create_default_https_context = ssl._create_unverified_context

local_path = os.getcwd()

hepmc_package = 'HepMC-2.06.09'
hepmc_source = 'http://lcgapp.cern.ch/project/simu/HepMC/download/'
hepmc_configure_options = ['--with-momentum=GEV', '--with-length=MM']

lhapdf_version = '6.1.6'
lhapdf_package = 'LHAPDF-' + lhapdf_version
lhapdf_source = 'http://www.hepforge.org/archive/lhapdf/'
lhapdf_configure_options = []
lhapdf_sets = ['CT10nlo', 'CT10', 'cteq6l1', 'MSTW2008lo68cl', 'MSTW2008nlo90cl']


def set_path(target):
  path = os.path.abspath(os.path.join(local_path, target))
  show_variable (target + "_path", path)
  mkdirs(path)
  return path


def install(package, source, configure_options):
  stamp = package + '.stamp'
  if not os.path.isfile(os.path.join(build_path, stamp)):
    tfile = package + '.tar.gz'
    url = source + tfile
    show_variable('url', url)
    filename = wgetter.download(url, outdir=build_path)
    tar = tarfile.open(name=os.path.join(build_path, tfile), mode='r:gz')
    tar.extractall(path=build_path)
    os.chdir(os.path.join(build_path, package))
    prefix = '--prefix=' + os.path.join(install_path)
    call_verbose(['./configure', prefix] + configure_options)
    call_verbose(['make'])
    call_verbose(['make', '-j'])
    call_verbose(['make', '-j', 'install'])
    call_verbose(['make', '-j', 'check'])
    os.chdir(build_path)
    with open(stamp, 'a'):
      os.utime(stamp, None)


def get_PDFs(version, source, pdfsets):
  pdf_source = source + 'pdfsets/' + version + '/'
  for pdfset in pdfsets:
    stamp = pdfset + '.stamp'
    if not os.path.isfile(os.path.join(build_path, stamp)):
      tfile = pdfset + '.tar.gz'
      print 'Getting ' + pdfset
      filename = wgetter.download(pdf_source + tfile, outdir=build_path)
      tar = tarfile.open(name=os.path.join(build_path, tfile), mode='r:gz')
      tar.extractall(path=os.path.join(install_path, 'share', 'LHAPDF'))
      os.chdir(build_path)
      with open(stamp, 'a'):
        os.utime(stamp, None)


paths = map(set_path, ['build', 'install'])
build_path = paths[0]
install_path = paths[1]

install(hepmc_package, hepmc_source, hepmc_configure_options)
install(lhapdf_package, lhapdf_source, lhapdf_configure_options)
get_PDFs(lhapdf_version, lhapdf_source, lhapdf_sets)

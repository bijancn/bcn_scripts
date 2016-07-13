#!/usr/bin/env python

import wgetter
import tarfile
import bcn_tools as bt
import os
import urllib2

# Monkey patch default SSL
# (https://github.com/mtschirs/quizduellapi/issues/://github.com/mtschirs/quizduellapi/issues/2)
import ssl
if hasattr(ssl, '_create_unverified_context'):
  ssl._create_default_https_context = ssl._create_unverified_context

local_path = os.getcwd()


def set_path(target):
  path = os.path.abspath(os.path.join(local_path, target))
  bt.show_variable(target + "_path", path)
  bt.mkdirs(path)
  return path


def install(package):
  package_name = package['package'] + '-' + package['version']
  stamp = package_name + '.stamp'
  if not os.path.isfile(os.path.join(build_path, stamp)):
    tfile = package_name + '.tar.gz'
    url = package['source'] + tfile
    bt.show_variable('url', url)
    try:
      wgetter.download(url, outdir=build_path)
    except urllib2.HTTPError:
      print 'Got blocked. Trying manual wget'
      os.chdir(os.path.join(build_path))
      bt.call_verbose(['wget', url])
    tar = tarfile.open(name=os.path.join(build_path, tfile), mode='r:gz')
    tar.extractall(path=build_path)
    os.chdir(os.path.join(build_path, package_name))
    prefix = '--prefix=' + os.path.join(install_path)
    bt.call_verbose(['./configure', prefix] + package['configure_options'])
    bt.call_verbose(['make', '-j', jobs])
    bt.call_verbose(['make', 'install'])
    bt.call_verbose(['make', '-j', jobs, 'check'])
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
      wgetter.download(pdf_source + tfile, outdir=build_path)
      tar = tarfile.open(name=os.path.join(build_path, tfile), mode='r:gz')
      tar.extractall(path=os.path.join(install_path, 'share', 'LHAPDF'))
      os.chdir(build_path)
      with open(stamp, 'a'):
        os.utime(stamp, None)


build_path, install_path = map(set_path, ['build', 'install'])
jobs = '10'

hepmc = {
    'package': 'HepMC',
    'version': '2.06.09',
    'source': 'http://lcgapp.cern.ch/project/simu/HepMC/download/',
    'configure_options': ['--with-momentum=GEV', '--with-length=MM', 'CXXFLAGS=-std=c++11']
}

lhapdf = {
    'package': 'LHAPDF',
    'version': '6.1.6',
    'source': 'http://www.hepforge.org/archive/lhapdf/',
    'configure_options': ['CXXFLAGS=-std=c++11'],
    'sets': ['CT10nlo', 'CT10', 'cteq6l1', 'MSTW2008lo68cl', 'MSTW2008nlo90cl']
}

fastjet = {
    'package': 'fastjet',
    'version': '3.2.0',
    'source': 'http://fastjet.fr/repo/',
    'configure_options': []
}

install(hepmc)
install(lhapdf)
install(fastjet)
get_PDFs(lhapdf['version'], lhapdf['source'], lhapdf['sets'])

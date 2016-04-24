#! /usr/bin/env python2
from subprocess import check_output

# see https://wiki.archlinux.org/index.php/OfflineIMAP#Using_GPG
# TODO: (bcn 2016-04-24) use keepassx for this
def get_pass(mail):
  return check_output("gpg -dq ~/cloud/keys/offlineimappass-" +
      mail + ".gpg", shell=True).strip("\n")

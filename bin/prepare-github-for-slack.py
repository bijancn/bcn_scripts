#!/usr/bin/env python
import subprocess
import urllib2
from BeautifulSoup import BeautifulSoup
#  import pyperclip

url = subprocess.check_output(['xclip', '-o'])
component = url.split('/')[-3]
soup = BeautifulSoup(urllib2.urlopen(url))
title = soup.title.string
topic = title.split(' by ')[0]
text = "PR to `" + topic + "` in *["+ component + "]*\n" + url
print(text)
#  cmd = 'echo "' + text + '" | xclip'
#  print(cmd)
#  pyperclip.copy(text)
#  subprocess.call(cmd)

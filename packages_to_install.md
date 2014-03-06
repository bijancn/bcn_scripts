# Main packages
### libavcodec-extra-53 is needed for youtube-dl mp3 conversion
apache2
autoconf
autotools-dev
biblatex
chromium
cmus
curlftpfs
dict
diffpdf
encfs
feynmf
finch
fuse
gfortran
gimp
git
gparted
guake
htop
inkscape
ipython
keepassx
latexmk
latex-mk
libavcodec-extra-53
meld
mercurial
nemo-dropbox
node-less
noweb
openssh-server
pandoc
pdftk
php5
python-matplotlib
python-numpy
python-pip
python-scipy
python-unidecode
skype
subversion
terminator
texlive 
texlive-fonts-extra
texlive-lang-german 
texlive-latex-extra 
texlive-science
unetbootin
vim-gtk
xournal
youtube-dl
wine

# Bumblebee Setup
sudo add-apt-repository ppa:bumblebee/stable
sudo apt-get update
sudo apt-get install bumblebee virtualgl linux-headers-generic primus primus-libs-ia32

# Printer Setup
sudo apt-get install cups csh lib32stdc++6
sudo mkdir /var/spool/lpd
sudo mkdir /usr/share/cups/model
sudo dpkg -i ~/Dropbox/scripts/Treiber/dcp195clpr-1.1.3-1.i386.deb
sudo dpkg -i /home/bijancn/Dropbox/scripts/Treiber/dcp195ccupswrapper-1.1.3-1.i386.deb
go http://localhost:631
# -> Adding Printer and Classes -> Add Printer -> AppSocket/HP JetDirect ->
# socket://192.168.2.111

# OCaml Setup
wget http://caml.inria.fr/pub/distrib/ocaml-4.00/ocaml-4.00.1.tar.gz
tar -xzf *.tar.gz
cd ocaml-4.00
./configure 
make world.opt
sudo make install

# Not in apt
# http://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
# http://www.hepforge.org/archive/whizard/omega-2.1.1.tar.gz
# http://www.hepforge.org/archive/whizard/whizard-2.1.1.tar.gz

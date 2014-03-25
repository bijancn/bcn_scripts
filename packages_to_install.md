# main
### libavcodec-extra-53 is needed for youtube-dl mp3 conversion
autoconf autotools-dev biber biblatex chromium cmus curl curlftpfs diffpdf encfs feynmf flashplugin-nonfree fuse gfortran gfortran-doc gimp git gparted htop inkscape ipython keepassx latexmk latex-mk libavcodec-extra-53 meld mercurial nemo-dropbox node-less noweb ocaml openssh-server pandoc pdftk python-matplotlib python-numpy python-pip python-scipy python-unidecode skype subversion terminator texlive texlive-fonts-extra texlive-lang-german texlive-latex-extra texlive-metapost texlive-science vim-gtk xournal youtube-dl wine

# optional
apache2 dict php5 

# git
`curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git` 

# skype
http://www.skype.com/en/download-skype/skype-for-linux/

# Bumblebee Setup
add-apt-repository ppa:bumblebee/stable
apt-get update
apt-get install bumblebee virtualgl linux-headers-generic primus primus-libs-ia32

# OCaml by hand
`
tar -xzf *.tar.gz
cd ocaml-4.XX
./configure 
make world.opt
sudo make install
`

# Mendeley
http://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest

# For Debian
## encfs
To use encfs for decryption
sudo gpasswd -a bijancn fuse
## cinnamon
`
/etc/apt/sources.list >> 
deb http://packages.linuxmint.com/ debian main import backport upstream romeo
`
## skype (4.2)
Enable multi arch: `dpkg --add-architecture i386`, `apt-get update`
Install the deb package: `dpkg -i skype-install.deb`, `apt-get -f install`


## For ATI 
firmware-linux-nonfree libgl1-mesa-dri xserver-xorg-video-ati

## DHCP Printer Setup
sudo apt-get install cups csh lib32stdc++6
sudo mkdir /var/spool/lpd
sudo mkdir /usr/share/cups/model
sudo dpkg -i ~/Dropbox/scripts/Treiber/dcp195clpr-1.1.3-1.i386.deb
sudo dpkg -i /home/bijancn/Dropbox/scripts/Treiber/dcp195ccupswrapper-1.1.3-1.i386.deb
go http://localhost:631
-> Adding Printer and Classes -> Add Printer -> AppSocket/HP JetDirect ->
socket://192.168.2.111

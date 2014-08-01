main packages
================================================================================

work basic
--------------------------------------------------------------------------------
`dict` is needed for `colorit`
`build-essential`, `python-dev` is for `VIM YCM`
480 MB disc space
```
autoconf automake autotools-dev build-essential cmake curl dict diffpdf g++ gfortran git htop inkscape ipython keepassx libtool meld mercurial noweb libfindlib-ocaml-dev ocaml pandoc pdftk python-dev python-matplotlib python-numpy python-pip python-scipy python-unidecode subversion terminator vim-gtk
```

latex
--------------------------------------------------------------------------------
1920 MB disc space
```
biber ocamlweb texlive texlive-fonts-extra texlive-humanities texlive-lang-german texlive-latex-extra texlive-metapost texlive-publishers texlive-science feynmf latexmk latex-mk latex-xcolor
```

nice to have
--------------------------------------------------------------------------------
`libavcodec-extra`, `libav-tools` is needed for `youtube-dl` mp3 conversion
```
apache2 chromium-browser curlftpfs gimp gparted krb5-user libav-tools libavcodec-extra nemo-dropbox node-less openssh-server php5 trash-cli youtube-dl wine
```

manual installations
================================================================================

default terminal
--------------------------------------------------------------------------------
```
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/terminator
```

swapiness settings
--------------------------------------------------------------------------------
`sysctl.conf`

mendeley
--------------------------------------------------------------------------------
http://www.mendeley.com/download-mendeley-desktop/ubuntu/instructions/

SpiderOak
--------------------------------------------------------------------------------
https://spideroak.com/opendownload/

skype
--------------------------------------------------------------------------------
http://www.skype.com/en/download-skype/skype-for-linux/
The one in the repositories is even more broken

git
--------------------------------------------------------------------------------
See `setup_git.sh`

vim
--------------------------------------------------------------------------------
See `.vimrc`

## Bumblebee Setup
```
add-apt-repository ppa:bumblebee/stable
apt-get update
apt-get install bumblebee virtualgl linux-headers-generic primus primus-libs-ia32
```

## OCaml by hand
```
tar -xzf *.tar.gz
cd ocaml-4.XX
./configure
make world.opt
sudo make install
````

Debian specfics
================================================================================
encfs
--------------------------------------------------------------------------------
To use encfs for decryption `sudo gpasswd -a bijancn fuse`

cinnamon
--------------------------------------------------------------------------------
` /etc/apt/sources.list >>
deb http://packages.linuxmint.com/ debian main import backport upstream romeo `

skype (4.2)
--------------------------------------------------------------------------------
Enable multi arch: `dpkg --add-architecture i386`, `apt-get update`
Install the deb package: `dpkg -i skype-install.deb`, `apt-get -f install`

ati
--------------------------------------------------------------------------------
Packages: `firmware-linux-nonfree libgl1-mesa-dri xserver-xorg-video-ati`

DHCP Printer Setup
================================================================================
```
sudo apt-get install cups csh lib32stdc++6
sudo mkdir /var/spool/lpd
sudo mkdir /usr/share/cups/model
sudo dpkg -i ~/Dropbox/scripts/Treiber/dcp195clpr-1.1.3-1.i386.deb
sudo dpkg -i /home/bijancn/Dropbox/scripts/Treiber/dcp195ccupswrapper-1.1.3-1.i386.deb
go http://localhost:631
-> Adding Printer and Classes -> Add Printer -> AppSocket/HP JetDirect ->
socket://192.168.2.111
```

Reminders
================================================================================
- Edit `/etc/default/grub`. Here you can set the default OS via `GRUB_DEFAULT`
  and the time until boot via `GRUB_TIMEOUT`.
  Then run `sudo grub-mkconfig; sudo update-grub`

- Change Fonts -> Window title font size

- Activate compose key for umlaute

ssh
--------------------------------------------------------------------------------
If you can't connect to this machine `sudo ufw allow 22` to open ssh port. Maybe
you need to install `ssh`.

# main packages
`libavcodec-extra` is needed for `youtube-dl` mp3 conversion
`dict` is needed for `colorit`
`build-essential`, `python-dev` is for `VIM YCM`.

~866 MB disc space
```
autoconf automake autotools-dev biber build-essential chromium-browser cmake curl curlftpfs dict diffpdf g++ gfortran gfortran-doc gimp git gparted htop inkscape ipython keepassx libavcodec-extra libtool meld mercurial nemo-dropbox node-less noweb ocaml openssh-server pandoc pdftk python-dev python-matplotlib python-numpy python-pip python-scipy python-unidecode subversion terminator trash-cli vim-gtk youtube-dl wine
```

725 MB disc space
```
texlive texlive-fonts-extra texlive-humanities texlive-lang-german texlive-latex-extra texlive-metapost texlive-publishers texlive-science feynmf latexmk latex-mk latex-xcolor
```

# optional packages
apache2 php5 krb5-user

# manual installations
## git
```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
```

## vim
```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Then `vim` and `:BundleInstall`

## default terminal
```
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/terminator
```

## swapiness settings
sysctl.conf

## mendeley
http://www.mendeley.com/download-mendeley-desktop/ubuntu/instructions/

## SpiderOak
https://spideroak.com/opendownload/

## skype
http://www.skype.com/en/download-skype/skype-for-linux/
The one in the repositories is even more broken

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

# For Debian
## encfs
To use encfs for decryption `sudo gpasswd -a bijancn fuse`

## cinnamon
` /etc/apt/sources.list >>
deb http://packages.linuxmint.com/ debian main import backport upstream romeo `

## skype (4.2)
Enable multi arch: `dpkg --add-architecture i386`, `apt-get update`
Install the deb package: `dpkg -i skype-install.deb`, `apt-get -f install`

## For ATI
Packages: `firmware-linux-nonfree libgl1-mesa-dri xserver-xorg-video-ati`

# DHCP Printer Setup
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

# settings
- Edit `/etc/default/grub`. Here you can set the default OS via `GRUB_DEFAULT`
  and the time until boot via `GRUB_TIMEOUT`. Then run `sudo grub-mkconfig; sudo
  update-grub`

- Change Fonts -> Window title font size

- Activate compose key for umlaute

#!/bin/bash
# procmail is to get formail which can reformat mails used to add labels in mutt
# libxapian-dev libgmime-2.6-dev libtalloc-dev zlib1g-dev # notmuch dependencies
# notmuch
sudo apt-get install \
  autoconf automake autotools-dev build-essential \
  cmake curl dict diffpdf g++ \
  goobook git graphviz htop inkscape \
  keepassx libtool mercurial msmtp mutt mutt-patched \
  noweb offlineimap pandoc \
  pdftk procmail \
  ipython python-dev python-matplotlib python-numpy python-pip python-scipy \
  python-unidecode scons subversion tmux \
  xsel zsh
mkdir -p ~/install/bin
mkdir -p ~/.mutt/temp
mkdir -p ~/.cache/mutt/
vim -c 'PlugInstall' -c qa
echo "Do you want to build YouCompleteMe?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) cd ~/.vim/plugged/YouCompleteMe && ./install.py \
      ; break;;
    No ) break;;
  esac
done

vim -c 'PromptlineSnapshot ~/.shell_prompt.sh airline' -c quit
# TODO: (bcn 2014-11-16) Keyboard shortcuts, Compose key for umlaute
# TODO: (bcn 2016-05-13) tmux-mem-cpu-load
~/bcn_scripts/relink_bcn.sh
source ~/.bashrc
fc-cache -vf ~/.fonts/

# biber # currently broken in ubuntus manager:
# https://bugs.launchpad.net/ubuntu/+source/biber/+bug/1565842
echo "Do you want to install Latex?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo apt-get install \
            ocamlweb texlive texlive-bibtex-extra \
            texlive-fonts-extra texlive-humanities \
            texlive-lang-german texlive-latex-extra \
            texlive-metapost texlive-pstricks \
            texlive-publishers texlive-science \
            feynmf latexmk latex-beamer \
            latex-mk latex-xcolor context \
      ; break;;
    No ) break;;
  esac
done
echo "Do you want to install extra packages?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo apt-get install \
            apache2 curlftpfs gimp gparted gsl-bin imagemagick krb5-user libav-tools \
            libavcodec-extra libboost-all-dev libgsl0-dev nemo-dropbox node-less \
            openssh-server php5 skype trash-cli youtube-dl wine \
      ; break;;
    No ) break;;
  esac
done

echo "Do you want to modify grub?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo vim /etc/default/grub ; \
          sudo grub-mkconfig         ; \
          sudo update-grub             \
      ; break;;
    No ) break;;
  esac
done

echo "Do you intent to build vim from source?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
      libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
      libcairo2-dev libx11-dev libxpm-dev libxt-dev \
      python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev \
    ; break;;
    No ) break;;
  esac
done

pip install wgetter # used in hep-setup.py
pip install unidecode # used in Ultisnips

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim

mkdir -p ~/.mail/desy
mkdir -p ~/.mail/gmail

# XMODMAP
# colors for mutt?

cd && \
  git clone https://github.com/powerline/fonts.git && \
  cd fonts && \
  ./install.sh

mkdir -p .mutt/temp
if type goobook &> /dev/null ; then
  goobook authenticate
fi

cd ~/cloud/keys/PGP/ && gpg2 --allow-secret-key-import --import *.key && gpg2 --import *.pub

echo "Changing shell! Enter '/usr/bin/zsh'" && chsh

www-browser http://www.mendeley.com/download-mendeley-desktop/ubuntu/instructions/
www-browser https://owncloud.org/install/#install-clients
www-browser https://www.google.de/chrome/browser/desktop/
www-browser https://www.spotify.com/de/download/linux/
www-browser https://github.com/mkropat/jumpapp
www-browser https://launchpad.net/~nathan-renniewaldock/+archive/ubuntu/flux

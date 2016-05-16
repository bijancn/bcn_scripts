#!/bin/bash
# procmail is to get formail which can reformat mails used to add labels in mutt
# libxapian-dev libgmime-2.6-dev libtalloc-dev zlib1g-dev # notmuch dependencies
# notmuch
sudo apt-get install \
  autoconf automake autotools-dev build-essential \
  cmake curl dict diffpdf g++ \
  gfortran git graphviz htop inkscape ipython \
  keepassx libtool lynx meld mercurial msmtp mutt \
  noweb libfindlib-ocaml-dev ocaml pandoc \
  pdftk procmail python-dev python-matplotlib \
  python-numpy python-scipy \
  python-unidecode scons subversion \
  vim-gtk xsel
mkdir -p ~/install/bin
mkdir -p ~/.mutt/temp
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

pip install wgetter # used in hep-setup.py
pip install unidecode # used in Ultisnips

sudo apt-get install libqwt5-qt4 libqtwebkit4
firefox \
  -new-tab http://www.mendeley.com/download-mendeley-desktop/ubuntu/instructions/

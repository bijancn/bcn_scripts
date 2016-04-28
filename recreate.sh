sudo apt-get install \
  autoconf automake autotools-dev build-essential \
  cmake curl dict diffpdf g++ \
  gfortran git graphviz htop inkscape ipython \
  keepassx libtool meld mercurial msmtp mutt \
  noweb libfindlib-ocaml-dev ocaml pandoc \
  pdftk python-dev python-matplotlib \
  python-numpy python-scipy \
  python-unidecode scons subversion \
  vim-gtk xsel
mkdir -p ~/install
vim -c 'PlugInstall' -c qa
echo "Do you want to build YouCompleteMe?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) cd ~/.vim/plugged/YouCompleteMe && ./install.sh \
      ; break;;
    No ) break;;
  esac
done

# TODO: (bcn 2014-11-16) Powerline Symbol font is installed but symbols dont work
vim -c 'PromptlineSnapshot ~/.shell_prompt.sh airline' -c quit
# TODO: (bcn 2014-11-16) Keyboard shortcuts, Compose key for umlaute
~/bcn_scripts/relink_bcn.sh
source ~/.bashrc
fc-cache -vf ~/.fonts/

echo "Do you want to install Latex?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo apt-get install \
            biber ocamlweb texlive texlive-bibtex-extra \
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

firefox \
  -new-tab http://www.mendeley.com/download-mendeley-desktop/ubuntu/instructions/

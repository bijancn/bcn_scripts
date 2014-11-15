sudo apt-get install \
  autoconf automake autotools-dev build-essential cmake curl dict diffpdf g++ \
  gfortran git graphviz htop inkscape ipython keepassx libtool meld mercurial \
  noweb libfindlib-ocaml-dev ocaml pandoc pdftk python-dev python-matplotlib  \
  python-numpy python-pip python-scipy python-unidecode subversion terminator \
  vim-gtk
mkdir ~/.vim/swap
git clone https://github.com/bijancn/bcn_scripts.git ~/bcn_scripts
git clone https://github.com/gmarik/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
vim -c 'PluginInstall'
cd ~/.vim/bundle/YouCompleteMe && ./install.sh
vim -c 'PromptlineSnapshot ~/.shell_prompt.sh airline'

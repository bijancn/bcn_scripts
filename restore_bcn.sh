#/bin/bash

if [ "$USER" = "bijancn" ]
then
  app=""
  mighty=true
else
  app="_simple"
  mighty=false
fi

bcn=~/bcn_scripts
mkdir ~/.vim/ftplugin -p
mkdir ~/.vim/colors -p
mkdir ~/.vim/spell -p
mkdir ~/.vim/syntax -p
mkdir ~/.ssh -p
mkdir ~/.matplotlib -p
mkdir ~/.config/terminator -p
mkdir ~/texmf/tex/latex -p
ln -sf $bcn/.vimrc                      ~/.vimrc
ln -sf $bcn/gitconf/.gitconfig$app      ~/.gitconfig
ln -sf $bcn/.bashrc                     ~/.bashrc
ln -sf $bcn/.coloritrc                  ~/.coloritrc
ln -sf $bcn/.dir_colorsrc               ~/.dir_colorsrc
ln -sf $bcn/.gntrc                      ~/.gntrc
ln -sf $bcn/.vim/*                      ~/.vim/
ln -sf $bcn/.vim/colors/*               ~/.vim/colors/
ln -sf $bcn/.vim/ftplugin/*             ~/.vim/ftplugin/
ln -sf $bcn/.vim/spell/*                ~/.vim/spell/
ln -sf $bcn/.vim/syntax/*               ~/.vim/syntax/
ln -sf $bcn/.config/terminator/*        ~/.config/terminator/
ln -sf $bcn/latex/*                     ~/texmf/tex/latex/
ln -sf $bcn/.ssh/config                 ~/.ssh/config
ln -sf $bcn/.matplotlib/matplotlibrc    ~/.matplotlib/matplotlibrc

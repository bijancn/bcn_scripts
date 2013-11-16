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
DIRS=".matplotlib .ssh texmf/tex/latex "
DIRS+=".vim .vim/syntax .vim/spell .vim/colors .vim/ftplugin "
DIRS+=".config/keepassx .config/terminator .config/inkscape .config/evince "
DIRS+=".config/dwb .config/dwb/adblock_lists .config/dwb/default "
for d in $DIRS
do
  mkdir ~/$d -p
  ln -sf $bcn/$d/*                      ~/$d/
done

files=".vimrc .bashrc .coloritrc .dir_colorsrc .muttrc .gitignore_global"
for f in $files
do
  ln -sf $bcn/$f                      ~/$f
done
ln -sf $bcn/gitconf/.gitconfig$app      ~/.gitconfig
if $mighty 
then
  sudo ln -sf $bcn/metacity-theme-1.xml /usr/share/themes/Mint-X/metacity-1/metacity-theme-1.xml
fi

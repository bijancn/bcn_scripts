#/bin/bash
# Move all directory-based to file based linkage

if [ "$USER" = "bijancn" ]
then
  app=""
  mighty=true
else
  app="_simple"
  mighty=false
fi

bcn=~/bcn_scripts
safe=~/safe/keys
DIRS=".matplotlib texmf/tex/latex "
DIRS+=".vim .vim/syntax .vim/spell .vim/colors .vim/ftplugin "
DIRS+=".config/keepassx .config/terminator .config/inkscape .config/evince "
DIRS+=".config/dwb .config/dwb/adblock_lists .config/dwb/default "
DIRS+=""
for d in $DIRS
do
  #mkdir ~/$d -p
  #ln -sf $bcn/$d/*                      ~/$d/
done

files=".vimrc .bashrc .coloritrc .dir_colorsrc .gitignore_global "
files+=".ssh/config .ssh/known_hosts "
files+=".local/share/applications/mimeapps.list "

for f in $files; do
  mkdir ~/$(dirname $f) -p
  if [ -f $bcn/$f ] ; then
    ln -sf $bcn/$f                      ~/$f
  elif [ -f $safe/$f ] ; then
    ln -sf $safe/$f                     ~/$f
  fi
done
ln -sf $bcn/gitconf/.gitconfig$app      ~/.gitconfig
if $mighty; then
  sudo easy_install trash-cli
  #sudo ln -sf $bcn/metacity-theme-1.xml /usr/share/themes/Mint-X/metacity-1/metacity-theme-1.xml
fi

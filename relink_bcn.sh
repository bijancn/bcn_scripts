#/bin/bash
# Move all directory-based to file based linkage
shopt -s extglob

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
DIRS+=".config/keepassx .config/terminator .config/inkscape .config/evince "
DIRS+=".config/dwb .config/dwb/adblock_lists .config/dwb/default "
DIRS+=""

files=".@(vim|bash|colorit|dir_colors)rc .gitignore_global "
files+=".vim/@(bcn_color_demo|filetype).vim "
files+=".vim/colors/@(bcn_dark|bcn_light|print_bw).vim "
files+=".vim/ftplugin/@(c|markdown|noweb|ocaml|python).vim "
files+=".vim/spell/en.utf-8.add?(.spl) "
files+=".vim/syntax/@(markdown|noweb|sindarin).vim "
files+=".vim/UltiSnips/@(all|fortran|pandoc|noweb|tex).snippets "
files+=".ssh/config .ssh/known_hosts "
files+=".local/share/applications/mimeapps.list "

for f in $files; do
  mkdir ~/$(dirname $f) -p
  echo $f
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

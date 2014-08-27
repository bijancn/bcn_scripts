#/bin/bash
shopt -s extglob

files=".@(vim|bash|colorit|dir_colors)rc .gitignore_global "
files+=".config/evince/@(accels|print-settings) "
files+=".config/keepassx/config.ini "
files+=".config/matplotlib/matplotlibrc "
files+=".config/terminator/config "
files+=".local/share/applications/mimeapps.list "
files+=".profile "
files+=".ssh/config .ssh/known_hosts "
# Pattern matching only works when the files are locally present
s=".sylpheed-2.0"
files+="$s/accountrc $s/colorlabelrc $s/menurc $s/sylpheedrc "
files+=".vim/@(bcn_color_demo|filetype).vim "
files+=".vim/colors/@(bcn_dark|bcn_light|print_bw).vim "
files+=".vim/after/ftplugin/@(c|markdown|noweb|ocaml|python|tex).vim "
files+=".vim/spell/en.utf-8.add?(.spl) "
files+=".vim/syntax/@(fortran|markdown|noweb|sindarin).vim "
files+=".vim/UltiSnips/@(all|fortran|noweb|pandoc|sh|tex).snippets "
l="texmf/tex/latex"
files+="$l/bcn_beamer@(.sty|_example.pdf|_example.tex) "
files+="$l/bcn_@(color|commands|koma).sty "
files+="$l/bcn_letter@(.lco|_example.pdf|_example.tex) "

bcn=~/bcn_scripts
safe="~/SpiderOak Hive/keys"

for f in $files; do
  mkdir ~/$(dirname $f) -p
  if [ -f ~/$f ]; then
    echo "--- $f already exists, doing nothing"
  else
    echo "+++ Linking $f"
    # Try to use public file. If not there use private.
    ls -al "$safe/$f"
    if [ -f $bcn/$f ] ; then
      ln -sf $bcn/$f                      ~/$f
    elif [ -e "$safe/$f" ] ; then
      ln -sf $safe/$f                     ~/$f
    else
      echo "000 FILE $f NOT FOUND in $bcn or $safe"
    fi
  fi
done

gitversion=`git --version | awk '{print $3}'`
bigger=`version_compare.py $gitversion 1.7.11`
if [ $bigger == 'first' ] || \
   [ $bigger == 'equal' ]; then
  app=""
  echo "Found git version ($giversion) more recent or equal to 1.7.11"
else
  app="_simple"
  echo "Found old git version ($gitversion)."
fi
rm ~/.gitconfig
ln -sf $bcn/gitconf/.gitconfig$app      ~/.gitconfig
#sudo ln -sf $bcn/metacity-theme-1.xml /usr/share/themes/Mint-X/metacity-1/metacity-theme-1.xml

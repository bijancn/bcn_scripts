#/bin/bash
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
l="texmf/tex/latex"

files=".@(vim|bash|colorit|dir_colors)rc .gitignore_global "
files+=".config/evince/@(accels|print-settings) "
files+=".config/keepassx/config.ini "
files+=".config/terminator/config "
files+=".local/share/applications/mimeapps.list "
files+=".matplotlib/matplotlibrc "
files+=".ssh/config .ssh/known_hosts "
files+=".vim/@(bcn_color_demo|filetype).vim "
files+=".vim/colors/@(bcn_dark|bcn_light|print_bw).vim "
files+=".vim/ftplugin/@(c|markdown|noweb|ocaml|python).vim "
files+=".vim/spell/en.utf-8.add?(.spl) "
files+=".vim/syntax/@(markdown|noweb|sindarin).vim "
files+=".vim/UltiSnips/@(all|fortran|pandoc|noweb|tex).snippets "
files+="bin/@(connect_free_server|gen_dirs_from_sins|handbreak_kill).sh "
files+="bin/@(ping_scan.sh|ppdflatex|server_status.sh|show_my_jobs.sh) "
files+="bin/@(svn-diff.sh|time.py) "
files+="$l/bcn_beamer@(.sty|_example.pdf|_example.tex) "
files+="$l/bcn_@(color|commands|koma).sty "
files+="$l/bcn_letter@(.lco|_example.pdf|_example.tex) "

for f in $files; do
  mkdir ~/$(dirname $f) -p
  echo $f
  # Try to use public file. If not there use private.
  if [ -f $bcn/$f ] ; then
    ln -sf $bcn/$f                      ~/$f
  elif [ -f $safe/$f ] ; then
    ln -sf $safe/$f                     ~/$f
  else
    echo 'FILE NOT FOUND'
  fi
done

ln -sf $bcn/gitconf/.gitconfig$app      ~/.gitconfig
if $mighty; then
  sudo easy_install trash-cli
  #sudo ln -sf $bcn/metacity-theme-1.xml /usr/share/themes/Mint-X/metacity-1/metacity-theme-1.xml
fi

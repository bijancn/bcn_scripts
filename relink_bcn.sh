#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# relink_bcn.sh - Create soft links from this repo to the home folder
#
# Copyright ©          Bijan Chokoufe Nejad          <bijan@chokoufe.com>
#
# This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
# can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
# http://www.gnu.org/licenses/gpl-2.0-standalone.html
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

shopt -s extglob
mpwd=`pwd`
bcn=~/repos/bcn_scripts
safe=${HOME}/ownCloud/keys
cd $bcn
force="false"
if [ $# -eq 1 ]; then
  if test "$1" = "-f"; then
    force="true"
  fi
fi

files=".@(bash|colorit|common|dir_colors|msmtp|mutt|offlineimap|xinit)rc "
files+=".@(pylint|screen|vim|vimperator|zim|zsh)rc "
files+=".bash_profile "
files+=".config/autostart/@(export-dbus.sh|fluxgui|ownCloud).desktop "
files+=".config/awesome/rc.lua "
files+=".config/dwb/default/@(bookmarks|quickmarks) "
files+=".config/dwb/@(keys|mimetypes|searchengines|settings) "
files+=".config/dwb/userscripts/@(autostart_player.js|extension_loader.js|start_streamer) "
files+=".config/fontconfig/conf.d/10-powerline-symbols.conf "
files+=".config/evince/@(accels|print-settings) "
files+=".config/karabiner/karabiner.json "
files+=".config/keepassx/config.ini "
files+=".config/matplotlib/matplotlibrc "
files+=".config/nvim/init.vim "
files+=".config/terminator/config "
files+=".fonts/AvantGarde_LT_Medium.ttf .fonts/GE_Inspira.ttf "
files+=".fonts/PowerlineSymbols.otf .fonts/Ubuntu.ttf "
files+=".gitignore_global "
files+=".hammerspoon/init.lua "
files+=".local/share/applications/@(mimeapps.list|spotify.desktop|gnome-terminal.desktop) "
files+=".mutt.desy .mutt.gmail .mutt.mailcap "
files+=".notmuch-config "
files+=".profile scalastyle_config.xml "
files+=".spacemacs "
files+="Library/KeyBindings/DefaultKeyBinding.dict "
l="texmf/tex/latex"
files+="$l/bcn_beamer@(.sty|_example.pdf|_example.tex) "
files+="$l/bcn_@(color|commands|koma).sty "
files+="$l/bcn_letter@(.lco|_example.pdf|_example.tex) "
files+="theoc.yaml "
files+=".tmux.conf "
files+=".vim/@(bcn_color_demo|filetype).vim "
files+=".vim/colors/@(bcn_dark|bcn_light|print_bw).vim "
files+=".vim/after/ftplugin/@(c|markdown|noweb|ocaml|python|sindarin|tex|vimwiki).vim "
files+=".vim/spell/en.utf-8.add "
files+=".vim/syntax/noweb.vim "
files+=".vim/UltiSnips/@(all|fortran|javascript|noweb|ocaml|markdown|python|sh|tex).snippets "
files+=".Xmodmap .Xdefaults "

for f in $files; do
  mkdir -p ~/$(dirname $f)
  if test -f ~/$f -a $force = "false"; then
    echo "--- $f   already exists, doing nothing"
  else
    # Try to use public file. If not there use private.
    if [ -f $bcn/$f ] ; then
      echo "+++ Linking $f"
      ln -sf $bcn/$f                      ~/$f
    elif [ -e "$safe/$f" ] ; then
      echo "+++ Linking $f"
      ln -sf $safe/$f                     ~/$f
    else
      echo "000 FILE $f NOT FOUND in $bcn or $safe"
    fi
  fi
done
chmod 600 ~/.msmtprc

mkdir ~/.ssh
for f in config id_rsa id_rsa.pub known_hosts; do
  if test -f ~/.ssh/$f -a $force = "false"; then
    echo "--- $f   already exists, doing nothing"
  else
    if [ -e "$safe/ssh/$f" ] ; then
      echo "+++ Linking ssh/$f"
      ln -sf $safe/ssh/$f                     ~/.ssh/$f
    else
      echo "000 FILE $f NOT FOUND in $bcn or $safe"
    fi
  fi
done

gitversion=`git --version | awk '{print $3}'`
bigger=`./bin/version-compare.py $gitversion 1.7.11`
if [ $bigger == 'first' ] || [ $bigger == 'equal' ]; then
  app=""
  echo "Found git version ($giversion) more recent or equal to 1.7.11"
else
  app="_simple"
  echo "Found old git version ($gitversion)."
fi
rm ~/.gitconfig
ln -sf $bcn/gitconf/.gitconfig$app      ~/.gitconfig
cd $mpwd

ln -sf ~/.vim ~/.nvim
ln -sf ~/.vimrc ~/.nvimrc
ln -sf ~/mutt-notmuch-py/mutt-notmuch-py ~/install/bin/mutt-notmuch-py

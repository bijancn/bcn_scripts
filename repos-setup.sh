#!/bin/bash

function github {
  git clone git@github.com:$1/$2.git
}

function bitbucket {
  git clone ssh://git@bitbucket.org/$1/$2.git
}

function bitbucket_hg {
  hg clone ssh://hg@bitbucket.org/$1/$2
}

if [ ! -f ~/.git-prompt.sh ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
else
  echo '~/.git-prompt.sh already exists!'
fi
if [ ! -f ~/.git-completion.sh ]; then
  curl http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-completion.bash > ~/.git-completion.sh
else
  echo '~/.git-completion.sh already exists!'
fi

cd $HOME
#github gsec eZchat
#github gsec glowing-mustache
#github JNicL Durak
#github oblique63 Python-GoogleCalendarParser
#github sickill git-dude
github MikePearce Git-Status
github gfxmonk termstyle # is needed by pydflatex
github olivierverdier pydflatex
github philchristensen svn-color
github sickill bitpocket
github bijancn bcn_scripts
github altercation mutt-colors-solarized
github honza mutt-notmuch-py
github Anthony25 gnome-terminal-colors-solarized
github seebi dircolors-solarized
github morgwai tpbat-utils-acpi

./gnome-terminal-colors-solarized/install.sh -s dark -p Default

# function get_logilab {
#   mkdir logilab && touch logilab/__init__.py
#   hg clone http://hg.logilab.org/logilab/common logilab/common
# }
#if [ hg 2> /dev/null ]; then
  #bitbucket_hg logilab pylint
  #bitbucket_hg logilab astroid
  #get_logilab
#fi

mkdir -p ~/install/bin
ln -sf $HOME/dircolors-solarized/dircolors.ansi-universal $HOME/.dircolors
ln -sf $HOME/pydflatex/bin/pydflatex           $HOME/install/bin/
ln -sf $HOME/bitpocket/bin/bitpocket           $HOME/install/bin/
ln -sf $HOME/svn-color/svn-color.py            $HOME/install/bin/
ln -sf $HOME/Git-Status/show_status            $HOME/install/bin/
ln -sf $HOME/mutt-notmuch-py/mutt-notmuch-py   $HOME/install/bin/
ln -sf $HOME/tpbat-utils-acpi/battery-*        $HOME/install/bin/

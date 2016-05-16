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

function get_logilab {
  mkdir logilab && touch logilab/__init__.py
  hg clone http://hg.logilab.org/logilab/common logilab/common
}

cd $HOME
github gfxmonk termstyle # is needed by pydflatex
#github gsec eZchat
#github gsec glowing-mustache
#github JNicL Durak
github MikePearce Git-Status
#github oblique63 Python-GoogleCalendarParser
github olivierverdier pydflatex
github philchristensen svn-color
#github sickill git-dude
github sickill bitpocket
github bijancn bcn_scripts
github altercation mutt-colors-solarized
github honza mutt-notmuch-py
github Anthony25 gnome-terminal-colors-solarized
github seebi dircolors-solarized

./gnome-terminal-colors-solarized/install.sh -s dark -p Default
ln -s $HOME/dircolors-solarized/dircolors.ansi-universal $HOME/.dircolors

#if [ hg 2> /dev/null ]; then
  #bitbucket_hg logilab pylint
  #bitbucket_hg logilab astroid
  #get_logilab
#fi

mkdir -p ~/install/bin
ln -s $HOME/pydflatex/bin/pydflatex $HOME/install/bin/pydflatex
ln -s $HOME/bitpocket/bin/bitpocket $HOME/install/bin/bitpocket
ln -s $HOME/svn-color/svn-color.py $HOME/install/bin/svn-color
ln -s $HOME/Git-Status/show_status $HOME/install/bin/show_status
ln -s $HOME/mutt-notmuch-py/mutt-notmuch-py $HOME/install/bin/mutt-notmuch-py

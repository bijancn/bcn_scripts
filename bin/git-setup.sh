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
function github {
  git clone git@github.com:$1/$2.git
}
function bitbucket {
  git clone ssh://git@bitbucket.org/$1/$2.git
}

github bijancn bcn_scripts
github gfxmonk termstyle # is needed by pydflatex
github gsec eZchat
github gsec glowing-mustache
github oblique63 Python-GoogleCalendarParser
github olivierverdier pydflatex
github sickill git-dude

bitbucket bijancn vm_paper

ln -s $HOME/pydflatex/bin/pydflatex $HOME/install/bin/pydflatex

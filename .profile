if [ -z ${TMUX} ]; then
  if [ -f /data/bcho/install/bin/tmux ] ; then
    source $HOME/.commonrc
    if command-exists tmux ; then
      echo Starting tmux
      exec tmux attach
    fi
  fi
fi
# Use self build zsh
if [ -f ${HOME}/install/bin/zsh ] ; then
  source $HOME/.commonrc
  if zsh --version ; then
    exec ${HOME}/install/bin/zsh
  fi
fi

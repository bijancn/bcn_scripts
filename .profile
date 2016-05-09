if [ -z ${TMUX} ]; then
  if [ -f /data/bcho/install/bin/tmux ] ; then
    source $HOME/.commonrc
    echo Starting tmux
    exec tmux attach
  fi
fi
# Use self build zsh
if [ -f ${HOME}/install/bin/zsh ] ; then
  source $HOME/.commonrc
  exec ${HOME}/install/bin/zsh
fi

if [ -z ${TMUX} ]; then
  if [ -f /data/bcho/install/bin/tmux ] ; then
    source $HOME/.commonrc
    echo Starting tmux
    #exec tmux new -A -s mysession
    exec tmux attach
    #tmux has-session && exec tmux attach || exec tmux
  fi
fi
if [ -f ${HOME}/install/bin/zsh ] ; then
  source $HOME/.commonrc
  exec ${HOME}/install/bin/zsh
fi


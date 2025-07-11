if [ "$PS1" ]; then
  if test -z ${TMUX} ; then
    source ${HOME}/.commonrc
    if command-exists tmux ; then
      echo Starting tmux
      exec tmux attach
    fi
  fi
  # Use self build zsh if there and given zsh is old
  if test -f ${HOME}/install/bin/zsh ; then
    source ${HOME}/.commonrc
    if test -f /bin/zsh && /bin/zsh --version; then
      if ! version-bigger /bin/zsh 5.0.0; then
        if $HOME/install/bin/zsh --version; then
          exec ${HOME}/install/bin/zsh
        fi
      fi
    fi
  fi
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/bcn/.lmstudio/bin"
# End of LM Studio CLI section


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# .bashrc - bash configuration file. Maintained since 2012.
#
# Copyright ©          Bijan Chokoufe Nejad          <bijan@chokoufe.com>
#
# This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
# can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
# http://www.gnu.org/licenses/gpl-2.0-standalone.html
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# It is important that we don't overwrite screen-256color which is set by tmux
case "$TERM" in
screen*)
  ;;
*)
  export TERM=xterm-256color
  ;;
esac


source $HOME/.commonrc
alias so='source ~/.bashrc'

#===================#
#  bash completion  #
#===================#
if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
fi

#==============================================================================#
#                                    COLORS                                    #
#==============================================================================#
# Colored man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# Enable some bash options
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.
set -o notify
set -o noclobber
set -o ignoreeof

# Allow to use backspace when connected via ssh to certain systems
stty erase ^?

#==============================================================================#
#                                    PROMPT                                    #
#==============================================================================#
# Set up prompt
if [ -f ~/.shell_prompt.sh ] ; then
  source ~/.shell_prompt.sh
else
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
fi

#==============================================================================#
#                                 LAST COMMAND                                 #
#==============================================================================#
bind '"\e."':yank-last-arg

# added by Miniconda2 installer
export PATH="/home/bijancn/miniconda2/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/bcn/.lmstudio/bin"
# End of LM Studio CLI section

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# .zshrc - zsh configuration file. Maintained since 2016.
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

################################################################################
#                                     ZIM                                      #
################################################################################
if [ ! -d ~/.zim ]; then
  git clone --recursive https://github.com/Eriner/zim.git ${ZDOTDIR:-${HOME}}/.zim
fi

if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

################################################################################
#                               AUTOSUGGESTIONS                                #
################################################################################
# we get it by hand as long as it is not part of zim
if [[ ! -d ~/zsh-autosuggestions ]]; then
  git clone git://github.com/zsh-users/zsh-autosuggestions ~/zsh-autosuggestions
fi
source ~/zsh-autosuggestions/zsh-autosuggestions.zsh

################################################################################
#                                   MY STUFF                                   #
################################################################################
source ${HOME}/.commonrc
alias so='source ~/.commonrc'

#==============================================================================#
#                                GLOBAL ALIASES                                #
#==============================================================================#
alias -g ...=../..
alias -g .2=../..
alias -g ....=../../../
alias -g .3=../../../
alias -g .....=../../../../
alias -g .4=../../../../
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail'

#==============================================================================#
#                                SUFFIX ALIASES                                #
#==============================================================================#
alias -s tex=vim
alias -s pdf=gnome-open

#==============================================================================#
#                                  COMPLETION                                  #
#==============================================================================#
# Don't try to prepend commands with underscore
zstyle ':completion:*:*:-command-:*:*' ignored-patterns '_*'

#==============================================================================#
#                                   AUTO-LS                                    #
#==============================================================================#
# Allows to use enter on empty line for ls
auto-ls () {
  if [[ $#BUFFER -eq 0 ]]; then
    echo ""
    ls
    zle redisplay
  else
    zle .$WIDGET
  fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls

#==============================================================================#
#                                SUDO ON ALT-S                                 #
#==============================================================================#
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

#==============================================================================#
#                                  EMPTY TAB                                   #
#==============================================================================#
# Allows to use tab on empty line to list files
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls "
        CURSOR=3
        zle list-choices
        zle backward-kill-word
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-list-files
# bind to tab
bindkey '^I' expand-or-complete-or-list-files

#==============================================================================#
#                                   SETTINGS                                   #
#==============================================================================#
# 10 second wait if you do something that will delete everything
# setopt RM_STAR_WAIT
# 10 seconds are just too long

setopt VI

setopt EXTENDED_GLOB

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

#==============================================================================#
#                                   BINDINGS                                   #
#==============================================================================#
# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..^M'

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

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
bindkey '\e.' insert-last-word

# Override the -i set by prezto/init
alias cp="nocorrect cp"

################################################################################
#                       DONT OVERSHADOW SYSTEM COMMANDS                        #
################################################################################
unalias gs

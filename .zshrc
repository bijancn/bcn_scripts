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

alias so='source ~/.zshrc'

if [ ! -f ${HOME}/.zgen/zgen.zsh ] ; then
  git clone https://github.com/tarjoilija/zgen.git .zgen
fi
source ${HOME}/.zgen/zgen.zsh

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/extract
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/node
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/tmuxinator
  zgen oh-my-zsh plugins/z
  #python
  #pip

  # generate the init script from plugins above
  zgen save
fi

source ${HOME}/.commonrc
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
#                                 ZSH SETTINGS                                 #
#==============================================================================#
# 10 second wait if you do something that will delete everything
setopt RM_STAR_WAIT

setopt VI

setopt EXTENDED_GLOB

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

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

source ${HOME}/.zgen/zgen.zsh

# if the init scipt doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/extract
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/node
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found
  #zgen jdavis/zsh-files themes/jdavis
  #zgen oh-my-zsh themes/frisk
  #zgen oh-my-zsh themes/sunrise
  #zgen oh-my-zsh themes/agnoster
  zgen oh-my-zsh plugins/tmuxinator
  zgen oh-my-zsh plugins/z
  #python
  #pip

  # generate the init script from plugins above
  zgen save
fi

source ${HOME}/.commonrc

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

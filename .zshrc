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

# Is it faster without?
# setopt VI

setopt EXTENDED_GLOB

setopt AUTO_CD

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

#==============================================================================#
#                                   BINDINGS                                   #
#==============================================================================#
# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..^M'

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

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
# unalias gs

################################################################################
#                                   KUBECTL                                    #
################################################################################
plugins=(git zsh-completions kubectl)
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi



## Kuberentes (kubectl) functions --------------

# Finds pods using a search term
# Run using `podname <namespace> <search-term>
podname() {
  kubectl -n $1 get pods | grep -i "$2" | awk '{print $1;}'
}

# Find the namespace that matches a string
# Run using `findns <search-term>`
findns() {
  kubectl get namespaces | grep -i "$@" | awk '{print $1;}'
}

# Deletes all pods matching a given search term
# Run using `deletepod <namespace> <search-term>`
deletepod() {
  kubectl -n $1 delete pod `podname "$1" "$2"`
}

# Describes all pods matching a given search term
# Run using `descpod <namespace> <search-term>`
descpod() {
  kubectl -n $1 describe pod `podname "$1" "$2"`
}

# Watches pods for changes in a given namespace
# Run using `watchnspods <namespace>`
watchpods() {
  kubectl -n $1 get pods -w
}

# Gets a resource from kubernetes by `kubectl get <resource list>`
# Run using `kget <resource-list>`
# To use a namespace, run using `kget -n <namespace> <resource-list>`
kget() {
  kubectl get "$@"
}

# Finds a type of resources for a given searchable namespace
# Run using `knget <namespace-search-term> <resource>`
knget() {
  kubectl -n `findns $1` get $2
}

# Starts tailing the logs of a pod defined in a namespace after
# looking up the name of the pod
# Run using `klogs <namespace> <podname>`
klogs() {
  export ns=$(findns $1)
  export pod=$(podname $ns $2)
  kubectl logs -f -n $ns $pod
}

# Forwards porsts frmo a given pod by searching for a namespace
# and pod name from other functions
# Run using `kfwd <namespace-search-term> <podname-search-term> <port-to-forward>`
kfwd() {
  export ns=$(findns $1)
  export pod=$(podname $ns $2)
  kubectl -n $ns port-forward $pod $3:$3
}

## End Kubernetes (kubectl) functions ---------

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


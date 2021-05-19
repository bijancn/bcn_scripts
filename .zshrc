# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------
#
#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=10'

# ------------------
# Initialize modules
# ------------------

export ZIM_HOME=${HOME}/.zim
if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

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
eval "$(starship init zsh)"

#==============================================================================#
#                                 LAST COMMAND                                 #
#==============================================================================#
bindkey '\e.' insert-last-word

# Override the -i set by prezto/init
alias cp="nocorrect cp"

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

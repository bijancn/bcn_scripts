# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

export ZIM_HOME=${HOME}/.zim
#
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# It is important that we don't overwrite screen-256color which is set by tmux
case "$TERM" in
screen*)
  ;;
*)
  # export TERM=xterm-256color
  ;;
esac

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

bindkey '\e.' insert-last-word

# Override the -i set by prezto/init
alias cp="nocorrect cp"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export PATH="$HOME/.cargo/bin:$PATH"

export SDKMAN_DIR="/Users/bijan/.sdkman"
[[ -s "/Users/bijan/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bijan/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2023-06-20 11:52:34
export PATH="$PATH:/Users/bcn/Library/Python/3.9/bin"

# Created by `pipx` on 2023-06-20 11:52:38
export PATH="$PATH:/Users/bcn/.local/bin"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# bun completions
[ -s "/Users/bcn/.bun/_bun" ] && source "/Users/bcn/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

export SSH_AUTH_SOCK=$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

export PATH="$PATH:/opt/nvim/"

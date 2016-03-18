# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# bcn .bashrc - bash configuration file. Maintained since 2012.
#
# Copyright (C) 2014         Bijan Chokoufe Nejad         <bijan@chokoufe.com>
# Recent versions:  https://github.com/bijancn/bcn_scripts
#
# This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
# can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
# http://www.gnu.org/licenses/gpl-2.0-standalone.html
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source $HOME/.commonrc

#===================#
#  bash completion  #
#===================#
if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
fi

#==============================================================================#
#                                    PROMPT                                    #
#==============================================================================#
## Print nickname for git/hg/bzr/svn version control in CWD
## Optional $1 of format string for printf, default "(%s) "
function get-branch {
  local dir="$PWD"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git) __git_ps1 "${1:-(%s) }"; return;;
          hg) nick=$(hg branch 2>/dev/null);;
          svn) nick=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && nick=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$nick" ]] && [[ -f "$conf" ]] && nick="$(basename "$(< $conf)")"
            [[ -z "$nick" ]] && nick="$(basename "$(readlink -f "$dir")")";;
        esac
        [[ -n "$nick" ]] && printf "${1:-(%s) }" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}

## Add branch to PS1 (based on $PS1 or $1), formatted as $2
export GIT_PS1_SHOWDIRTYSTATE=yes

# Set up prompt
if [ -f ~/.shell_prompt.sh ] ; then
  source ~/.shell_prompt.sh
elif [ -f ~/.git-prompt.sh ] ; then
  source ~/.git-prompt.sh
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
  export PS1="\$(get-branch "$2")${PS1}";
else
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
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

# Customize colors for ls
if version-bigger dircolors 8; then
  eval `dircolors $HOME/.dir_colorsrc`
fi


export TERM='xterm-256color'
export BASHRC_SET='set'

# Notify
if [ -x /usr/bin/notify-send ]; then
  alias alert='notify-send -t 0 -i gnome-terminal "[$?] $(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/;\s*alert$//'\'')"'
fi

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
bind '"\e."':yank-last-arg

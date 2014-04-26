# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# bcn .bashrc - bash configuration file. Maintained since 2012.
#
# Copyright (C)     2014-04-02    Bijan Chokoufe Nejad    <bijan@chokoufe.com>
# Recent versions:  https://github.com/bijanc/bcn_scripts
#
# This source code is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License Version 2:
# http://www.gnu.org/licenses/gpl-2.0-standalone.html
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Put me in:
#   for Linux:     ~/.bashrc
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Checking for own machine with superuser rights and updated programs
if [ "$USER" = "bijancn" ]; then
  mighty=true
else
  mighty=false
fi

if [ -x /usr/games/fortune ]; then
  /usr/games/fortune -s     # Makes our day a bit more fun.... :-)
fi

#============#
#  settings  #
#============#
# Customize colors for ls
eval `dircolors $HOME/.dir_colorsrc`

# VI mode for bash
set -o vi
bind '"\e."':yank-last-arg

# Avoid overflows
ulimit -c unlimited

set -o notify
set -o noclobber
set -o ignoreeof

# Narrowing greps search realms
export GREP_OPTIONS='--exclude-dir=.svn --exclude-dir=.git --exclude=*.swo '
export GREP_OPTIONS='--exclude=*.swp --exclude=Makefile.in'

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

#===========#
#  folders  #
#===========#
wingames='/data/win_games'
lingames='/data/lnx_games'
syncd=$HOME/safe
hepsoft=$syncd/hep_software
honeypot=/afs/desy.de/group/theorie/software/ELF64

#=========#
#  paths  #
#=========#
export PATH=$HOME/bin/lhapdf-5.9.1/bin:$HOME/bin:$PATH
export PATH=$honeypot/bin:$PATH
# libs
export LD_LIBRARY_PATH=$honeypot/lib:$honeypot/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/trunk-install/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/include/python2.7/
# python
#export PYTHONPATH=$HOME/bin/lhapdf-5.9.1:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:$HOME/codes/python
export PYTHONPATH=$PYTHONPATH:$HOME/Dropbox/gcal_print/Python-GoogleCalendarParser
# java
java_path=$HOME/Dropbox/Codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*
# ifort
# source /opt/intel/composer_xe_2013.3.163/bin/compilervars.sh intel64

#==================#
#  compiler flags  #
#==================#
export DEBUG="-O0 -Wall -fbounds-check -fbacktrace -finit-real=nan -g "
export DEBUG="$DEBUG -fcheck=all -fmax-errors=1 -ffpe-trap=invalid,zero,overflow"
alias debugconf='../ovm/configure FCFLAGS="$DEBUG"'
export FCFLAGS="-fmax-errors=1 -O2"
export CUBACORES=1

#=======#
#  IPs  #
#=======#
if $mighty; then
  if [ -f $syncd/keys/IPs.sh ]; then
    source $syncd/keys/IPs.sh
  fi
fi

#==========#
#  custom  #
#==========#
export today=`date -I`

# Enabling backtracing in OCaml
export OCAMLRUNPARAM=b

alias whiz_conf='$HOME/trunk/configure --disable-static --prefix=$HOME/trunk-install'
alias conn_jenkins='ssh -L 8080:localhost:8080 jenkins@141.99.211.121'
#source $hepsoft/rivet/rivet211/rivetenv.sh
export USER_ACR=bcn

# Set the title of terminal
echo -en "\e]0;$USER_ACR - terminal\a"

alias nhr='nohup ./run_all.sh 2>&1 &'

#==============================================================================#
#                                    COLORS                                    #
#==============================================================================#
# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

#==============================================================================#
#                                  SHORTHANDS                                  #
#==============================================================================#
if $mighty ; then
  alias m='cit make'
  alias mj='cit "make -j"'
  alias mi='cit "make install"'
  alias mc='cit "make clean"'
  alias mp='cit "make pdf"'
  alias mf='cit "make force_pdf"'
  alias rm='trash-put -v'
else
  alias m='make'
  alias mi='make install'
  alias mi='make install'
  alias mc='make clean'
  alias mp='make pdf'
  alias mf='make force_pdf'
fi
alias k='kill -9'
alias x='exit'
alias p='python'
alias t='/usr/bin/time'
alias c='./configure'
alias cd-='cd -'
alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ac='autoreconf'
alias so='source ~/.bashrc'
alias ll='ls -lh'
alias la='ls -lah'
alias lk='ls -lSrh'         #  Sort by size, biggest last.
alias le='less'
alias mv='mv -v'
alias sd='sudo shutdown now -P'
alias rb='sudo reboot'
alias rs='rem_show'
alias md='mkdir'
alias mdc='mkdircd'
alias mt='t --format "Realtime \t%E , Mean Memory Size: \t%K , Max Memory Size: \t%M"'
alias gf='gfortran -fopenmp '
alias ca='cit ant'
alias ud='./omega_QCD.opt -scatter "u d -> u d" '
alias brc='vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
# apt-get
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update'
alias agg='sudo apt-get upgrade'
alias agd='sudo apt-get dist-upgrade'
alias AGU='agu; agg; agd'
alias svnu='svn update'
alias svnd='svn diff'
alias twhizard='~/trunk-install/bin/whizard'
alias wsrc='go ~/trunk-distribution-install/share/doc/whizard/whizard.pdf'
alias vsrc='go ~/trunk-distribution-install/share/doc/vamp/vamp.pdf'
alias osrc='go ~/trunk-distribution-install/share/doc/omega/omega.pdf'
alias csrc='go ~/trunk-distribution-install/share/doc/circe2/circe2.pdf'
alias wman='go ~/trunk-distribution-install/share/doc/whizard/manual.pdf'
alias gman='go ~/trunk-distribution-install/share/doc/whizard/gamelan_manual.pdf'

#==============================================================================#
#                                    UTILS                                     #
#==============================================================================#

alias cd..='cd ..'
alias rgrep='grep -r'
alias hgrep='history | grep '
alias du_dirs='du {*,.git} -sh | sort -h'
alias du_subdirs='du -h | sort -h'
alias briss='java -jar ~/Dropbox/scripts/briss-0.9/briss-0.9.jar'
alias primrun='vblank_mode=0 primusrun'
alias todo='rgrep --binary-files=without-match -n todo: *'
alias yt_mp3='youtube-dl -t --extract-audio --audio-format=mp3'
alias all_cpu_info='lscpu; grep -i "model name" /proc/cpuinfo | uniq'
# dubious
alias ddiff='diff -x *.swp -q' #?
alias mount_wue='sshfs $int_quad_core1: /home/bijancn/Dropbox/uniwue/'
alias mount_out='sshfs $int_quad_core1:output_ovm/ /home/bijancn/Dropbox/master_thesis/output_ovm/'
alias get_thesis='git clone $nick:~/bcn_git/thesis.git'
alias reset_file_perms='find . -type f -exec chmod 644 {} +'
alias reset_dir_perms='find . -type d -exec chmod 755 {} +'
# games
alias sc='cd '$lingames'/Stronghold; wine Stronghold\ Crusader.exe'
alias ut='wine '$wingames'/UnrealTournament/System/UnrealTournament.exe'
alias wc3='wine '$wingames'/Warcraft\ III/Frozen\ Throne.exe'
alias dk2='wine '$wingames'/DungeonKeeper2/DKII.exe'

#==============================================================================#
#                                  FUNCTIONS                                   #
#==============================================================================#
function swap()
{ # Swap 2 files, if they exist
    local TMPFILE=tmp.$$
    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function bisect () {
  lines=$(wc -l "$1")
  filelength=`expr length $1`
  lines=${lines:0:-$filelength}
  lines=$(expr $lines / 2)
  echo "Bisecting $1 in two files with $lines lines each."
  split -dl $lines "$1" "$1."
}

function rem_print_1s () {
  scp "$1" $ip:~/temp.pdf
  ssh $ip "lp -d lp-tp2 -o media=a4 -o sides=one-sided temp.pdf"
}

function rem_show () {
  scp "$1" $ip:~/temp.pdf
  ssh -X $ip "evince ~/temp.pdf"
}

function vim_print () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ./"$1".pdf
  rm ~/output.ps
}

function shrink_pdf () {
  fname=$(basename $1)
  fbname=${fname%.*}
  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/ebook -sOutputFile=$fbname-small.pdf $1
}

function backup_settings () {
  if $mighty
  then
    cp /etc/fstab ~/decrypted/scripts/backup/
    cp ~/.local/share/keyrings ~/decrypted/scripts/backup/ -r
  fi
}

function kill_tty () {
  pid=$(ps -t $1 | grep 'bash' | head -c 6)
  kill -9 $pid
}

function nr__of_own_threads () {
  ps -eLF | grep ^$USER | wc -l
}

function mkdircd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

function ft_renamer () {
  for file in *.$1; do mv "$file" "${file%.$1}.$2"; done
}

function changer () {
  for file in *$1*; do mv $file ${file/$1/$2}; done
}

function wtz () {
  wget "$1" -O - | tar -xvz
}

# See BCN COLORITRC for customizing colors in output
function cit () {
  $1 2>&1 | colorit
}

function most_used_words () {
  echo 'solve this'
#alias find_most_used='tr ' ' '\ ' | tr '[:upper:]' '[:lower:]' |  tr -d '[:punct:]' | grep -v '[^a-z]' | sort | uniq -c | sort -rn |head -n 20'
}

#==============================================================================#
#                             SHORTHAND FUNCTIONS                              #
#==============================================================================#
function mm () {
  meld $1/$3 $2/$3
}

function ev () {
  evince "$1" &> /dev/null &
}

function za () {
  zathura "$1" &> /dev/null &
}

function go () {
  gnome-open "$1" &> /dev/null &
}

function ff () {
  find -iname "$1"
}

function sff () {
  sudo find -iname "$1"
}

function fa () {
  find -iname "*$1*"
}

function sfa () {
 sudo find -iname "*$1*"
}

#==============================================================================#
#                                     GIT                                      #
#==============================================================================#

function gitA () {
  git status
  echo "Are you really sure you want to commit EVERYTHING?? Have u pulled before?"
  echo "Does it fit the commit message '$1'?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) git add -A; git commit -m "$1"; break;;
      No ) break;;
    esac
  done
}

function gitf () {
  git add "$1"; git commit -m "$2"
}

function gitc () {
  git commit -m "$1"
}

function giti () {
  git interactive
}

function gits () {
  git status
}

function gitl () {
  git pull
}

function gitp () {
  git push
}

#==============================================================================#
#                                  GIT PROMPT                                  #
#==============================================================================#
## Print nickname for git/hg/bzr/svn version control in CWD
## Optional $1 of format string for printf, default "(%s) "
function be_get_branch {
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

setup_prompt(){
  c_black=`tput setaf 0`
  c_red=`tput setaf 1`
  c_green=`tput setaf 2`
  c_yellow=`tput setaf 3`
  c_blue=`tput setaf 4`
  c_pink=`tput setaf 5`
  c_cyan=`tput setaf 6`
  c_gray=`tput setaf 7`
  c_white=`tput setaf 9`
  PS1long='[\[$(branch_color)\]$(parse_git_branch)\[${c_white}\]] [${debian_chroot:+($debian_chroot)}\[\033[01m\]\u\[\033[01;32m\]@\h\[\033[00m\]] \[\033[01;34m\]\w\[\033[00m\] '
  #PS1='\[$(branch_color)\]$(parse_git_branch)\[\033[00m\] ${debian_chroot:+($debian_chroot)}\[\033[01m\]\u\[\033[01;32m\]@\h\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\] '
  if $mighty
  then
    source ~/.bash_git
    PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n   '
export PS1="\$(be_get_branch "$2")${PS1}";
  fi
  if [ "$USER" = "bcho" ]; then
    PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n   '
  fi
}

# Only set prompt if interactive! Otherwise noninteractive commands like ssh
# throw warnings
case "$-" in
  *i*) setup_prompt;;
  *)	interactive=false ;;
esac

#==============================================================================#
#                                 DEPRECEATED                                  #
#==============================================================================#

# DO NOT USE THIS! IT BREAKS YOUR PROMPT! Don't know why though
parse_git_branch () {
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
    return 0
  fi
  echo -e ${gitver::2}
}

# DO NOT USE THIS! IT BREAKS YOUR PROMPT! Don't know why though
branch_color () {
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git status | grep "nothing to commit" >/dev/null 2>&1
    then
      color="${c_green}"
    else
      color=${c_red}
    fi
  else
    color="(-)"
  fi
  echo -ne $color
}

function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; df -h / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

#=========================================================================
#  PROGRAMMABLE COMPLETION SECTION
#  Most are taken from the bash 2.05 documentation and from Ian McDonald's
# 'Bash completion' package (http://www.caliban.org/bash/#completion)
#  You will in fact need bash more recent then 3.0 for some features.
#
#  Note that most linux distributions now provide many completions
# 'out of the box' - however, you might need to make your own one day,
#  so I kept those here as examples.
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "3.0" ]; then
    echo "You will need to upgrade to version 3.0 for full \
          programmable completion features"
    return
fi

shopt -s extglob        # Necessary.

complete -A hostname   rsh rcp telnet rlogin ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # Currently same as builtins.
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract


# Documents - Postscript,pdf,dvi.....
complete -f -o default -X '!*.+(ps|PS)'  gs ghostview ps2pdf ps2ascii
complete -f -o default -X \
'!*.+(dvi|DVI)' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.+(pdf|PDF)' acroread pdf2ps
complete -f -o default -X '!*.@(@(?(e)ps|?(E)PS|pdf|PDF)?\
(.gz|.GZ|.bz2|.BZ2|.Z))' gv ggv
complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
complete -f -o default -X '!*.tex' tex latex slitex
complete -f -o default -X '!*.lyx' lyx
complete -f -o default -X '!*.+(htm*|HTM*)' lynx html2ps
complete -f -o default -X \
'!*.+(doc|DOC|xls|XLS|ppt|PPT|sx?|SX?|csv|CSV|od?|OD?|ott|OTT)' soffice

# Multimedia
complete -f -o default -X \
'!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' xv gimp ee gqview
complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
complete -f -o default -X '!*.+(ogg|OGG)' ogg123
complete -f -o default -X \
'!*.@(mp[23]|MP[23]|ogg|OGG|wav|WAV|pls|\
m3u|xm|mod|s[3t]m|it|mtm|ult|flac)' xmms
complete -f -o default -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|\
asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|\
QT|wmv|mp3|MP3|ogg|OGG|ogm|OGM|mp4|MP4|wav|WAV|asx|ASX)' xine



complete -f -o default -X '!*.pl'  perl perl5


#  This is a 'universal' completion function - it works when commands have
#+ a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
#  Needs the '-o' option of grep
#+ (try the commented-out version if not available).

#  First, remove '=' from completion word separators
#+ (this will allow completions like 'ls --color=auto' to work correctly).

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}


_get_longopts()
{
  #$1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
  #grep ^"$2" |sort -u ;
    $1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" |sort -u
}

_longopts()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}

    case "${cur:-*}" in
       -*)      ;;
        *)      return ;;
    esac

    case "$1" in
       \~*)     eval cmd="$1" ;;
         *)     cmd="$1" ;;
    esac
    COMPREPLY=( $(_get_longopts ${1} ${cur} ) )
}
complete  -o default -F _longopts configure bash
complete  -o default -F _longopts wget id info a2ps ls recode

_tar()
{
    local cur ext regex tar untar

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    # If we want an option, return the possible long options.
    case "$cur" in
        -*)     COMPREPLY=( $(_get_longopts $1 $cur ) ); return 0;;
    esac

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $( compgen -W 'c t x u r d A' -- $cur ) )
        return 0
    fi

    case "${COMP_WORDS[1]}" in
        ?(-)c*f)
            COMPREPLY=( $( compgen -f $cur ) )
            return 0
            ;;
        +([^Izjy])f)
            ext='tar'
            regex=$ext
            ;;
        *z*f)
            ext='tar.gz'
            regex='t\(ar\.\)\(gz\|Z\)'
            ;;
        *[Ijy]*f)
            ext='t?(ar.)bz?(2)'
            regex='t\(ar\.\)bz2\?'
            ;;
        *)
            COMPREPLY=( $( compgen -f $cur ) )
            return 0
            ;;

    esac

    if [[ "$COMP_LINE" == tar*.$ext' '* ]]; then
        # Complete on files in tar file.
        #
        # Get name of tar file from command line.
        tar=$( echo "$COMP_LINE" | \
                        sed -e 's|^.* \([^ ]*'$regex'\) .*$|\1|' )
        # Devise how to untar and list it.
        untar=t${COMP_WORDS[1]//[^Izjyf]/}

        COMPREPLY=( $( compgen -W "$( echo $( tar $untar $tar \
                                2>/dev/null ) )" -- "$cur" ) )
        return 0

    else
        # File completion on relevant files.
        COMPREPLY=( $( compgen -G $cur\*.$ext ) )

    fi

    return 0

}

complete -F _tar -o default tar

_make()
{
    local mdef makef makef_dir="." makef_inc gcmd cur prev i;
    COMPREPLY=();
    cur=${COMP_WORDS[COMP_CWORD]};
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case "$prev" in
        -*f)
            COMPREPLY=($(compgen -f $cur ));
            return 0
            ;;
    esac;
    case "$cur" in
        -*)
            COMPREPLY=($(_get_longopts $1 $cur ));
            return 0
            ;;
    esac;

    # ... make reads
    #          GNUmakefile,
    #     then makefile
    #     then Makefile ...
    if [ -f ${makef_dir}/GNUmakefile ]; then
        makef=${makef_dir}/GNUmakefile
    elif [ -f ${makef_dir}/makefile ]; then
        makef=${makef_dir}/makefile
    elif [ -f ${makef_dir}/Makefile ]; then
        makef=${makef_dir}/Makefile
    else
       makef=${makef_dir}/*.mk         # Local convention.
    fi


    #  Before we scan for targets, see if a Makefile name was
    #+ specified with -f.
    for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
        if [[ ${COMP_WORDS[i]} == -f ]]; then
            # eval for tilde expansion
            eval makef=${COMP_WORDS[i+1]}
            break
        fi
    done
    [ ! -f $makef ] && return 0

    # Deal with included Makefiles.
    makef_inc=$( grep -E '^-?include' $makef |
                 sed -e "s,^.* ,"$makef_dir"/," )
    for file in $makef_inc; do
        [ -f $file ] && makef="$makef $file"
    done


    #  If we have a partial word to complete, restrict completions
    #+ to matches of that word.
    if [ -n "$cur" ]; then gcmd='grep "^$cur"' ; else gcmd=cat ; fi

    COMPREPLY=( $( awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ \
                               {split($1,A,/ /);for(i in A)print A[i]}' \
                                $makef 2>/dev/null | eval $gcmd  ))

}

complete -F _make -X '+($*|*.[cho])' make gmake pmake




_killall()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    #  Get a list of processes
    #+ (the first sed evaluation
    #+ takes care of swapped out processes, the second
    #+ takes care of getting the basename of the process).
    COMPREPLY=( $( ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}

complete -F _killall killall killps

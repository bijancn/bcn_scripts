# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
#
# bcn .bashrc - bash configuration file. Maintained since 2012.
#
# Copyright (C)     2013-11-13    Bijan Chokoufe Nejad    <bijan@chokoufe.com>
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

# Checking for own machine with superuser rights and updated programs
if [ "$USER" = "bijancn" ]; then
  app=""
  mighty=true
else
  app="_simple"
  mighty=false
fi

# Customize colors for ls
eval `dircolors $HOME/.dir_colorsrc`

# Sourcing ifort
# source /opt/intel/composer_xe_2013.3.163/bin/compilervars.sh intel64

# paths
export PATH=$PATH:$HOME/ocaml/bin
export PATH=$PATH:$HOME/usr/bin
export PYTHONPATH=$PYTHONPATH:$HOME/codes/python
export PYTHONPATH=$PYTHONPATH:$HOME/Dropbox/gcal_print/Python-GoogleCalendarParser
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/OMega-2.1.1Build/src/.libs/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/gcc4.6.1/lib64/:$HOME/gcc4.6.1/lib32
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Dropbox/master_thesis/OMega-2.1.1Build/src/.libs/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/bin
# java
java_path=$HOME/Dropbox/Codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*

if $mighty; then
  export FC=gfortran
else
  export FC=$HOME/gcc4.6.1/bin/gfortran
fi

export GFC='yes'
export DEBUG="-O2 -Wall -fbounds-check -fbacktrace -finit-real=nan "
export DEBUG="$DEBUG -fcheck=all -fmax-errors=2 -ffpe-trap=invalid,zero,overflow"
alias debugconf='../ovm/configure FCFLAGS="$DEBUG"'
export FCFLAGS="-O2"
export CUBACORES=1
git=git@github.com
wingames='/data/win_games'
lingames='/data/lnx_games'
bcn=~/bcn_scripts

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ IP's ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
std_usr=bchokoufe
wue=$std_usr@132.187.196
#ip=$std_usr@wtpp121.physik.uni-wuerzburg.de
ip=$wue.121
ohl=$std_usr@wtpp125.physik.uni-wuerzburg.de
denner=$wue.133
nick=$wue.121                  # int_quad_core, free
otter=$wue.113                 # rechnet
fabian=$wue.172                # rechnet
pbaerwald=$wue.139             # rechnet
fnstaub=$wue.112               # rechnet
scharf=$wue.183                # rechnet
scharf_workers2=$wue.184       # rechnet
scharf_workers3=$wue.182       # rechnet
scharf_workers4=$wue.113       # rechnet
scharf_workers5=$wue.111       # rechnet
scharf_workers6=$wue.110       # rechnet
csturm=$wue.127                # rechnet
ddas=$wue.120                  # rechnet
amd_dual_core=$wue.141         # free
int_quad_core1=$wue.138        # free             2.83 GHz
int_quad_core2=$wue.143        # aschenkel, free  2.83 GHz needs python
int_quad_core3=$wue.134        # free             2.83 GHz
int_quad_core4=$wue.125        # free             2.33 GHz
int_i7=$wue.171                # mauricio, free
public=$std_usr@wtpp004.physik.uni-wuerzburg.de
clustr=$std_usr@wtpp020.physik.uni-wuerzburg.de
hepforge=$std_usr@login.hepforge.org
home_ip=192.168.2.152

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ SHORTHANDS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
if $mighty ; then
  alias mc='cit "make clean"'
  alias m='cit make'
else
  alias mc='make clean'
  alias m='make'
fi
alias x='exit'
alias p='python'
alias t='/usr/bin/time'
alias c='./configure'
alias so='source ~/.bashrc'
alias ll='ls -lh'
alias la='ls -lah'
alias le='less'
alias rm='rm -v'
alias mv='mv -v'
alias md='mkdir'
alias rg='ranger'
alias ca='cit ant'
alias gp='git pull'
alias gt='gitm ".."'
alias gm='gitm'
alias mu='mutt'
alias mt='t --format "Realtime \t%E , Mean Memory Size: \t%K , Max Memory Size: \t%M"'
alias rs='rem_show'
alias ac='autoreconf'
alias gf='gfortran -fopenmp ' 
alias ud='./omega_QCD.opt -scatter "u d -> u d" '
alias sc='cd '$lingames'/Stronghold; wine Stronghold\ Crusader.exe'
alias ut='wine '$wingames'/UnrealTournament/System/UnrealTournament.exe'
alias wc3='wine '$wingames'/Warcraft\ III/Frozen\ Throne.exe'
alias dk2='wine '$wingames'/DungeonKeeper2/DKII.exe'
alias briss='java -jar ~/Dropbox/scripts/briss-0.9/briss-0.9.jar'
alias primrun='vblank_mode=0 primusrun'
alias brc='vim ~/.bashrc'
alias mrc='vim ~/.muttrc'
alias vrc='vim ~/.vimrc'
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update'
alias agg='sudo apt-get upgrade'
alias agd='sudo apt-get dist-upgrade'
alias sd='sudo shutdown now -P'
alias rb='sudo reboot'
alias rgrep='grep -r'
alias hgrep='history | grep '
alias todo='rgrep --binary-files=without-match -n todo: *'
alias ddiff='diff -x *.swp -q'
alias cd..='cd ..'
alias du_dirs='du {*,.git} -sh | sort -h'
alias du_subdirs='du -h | sort -h'
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get dist-upgrade'
alias all_cpu_info='lscpu; grep -i "model name" /proc/cpuinfo | uniq'
#alias find_most_used='tr ' ' '\ ' | tr '[:upper:]' '[:lower:]' |  tr -d '[:punct:]' | grep -v '[^a-z]' | sort | uniq -c | sort -rn |head -n 20'
alias get_thesis='git clone $nick:~/bcn_git/thesis.git'
alias reset_file_perms='find . -type f -exec chmod 644 {} +'
alias reset_dir_perms='find . -type d -exec chmod 755 {} +'
alias mount_wue='sshfs $int_quad_core1: /home/bijancn/Dropbox/uniwue/'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 

function renamer () {
for files in *.$1; do
  mv "$files" "${files%.$1}.$2"
done
}

function git_resurrect () {
  git checkout $(git rev-list -n 1 HEAD -- "$1")^ -- "$1"
}

function kill_tty () {
  pid=$(ps -t $1 | grep 'bash' | head -c 6)
  kill -9 $pid
}

function running_threads () {
  ps -eLF | grep ^$USER | wc -l
}

function bisect () {
  lines=$(wc -l "$1")
  filelength=`expr length $1`
  lines=${lines:0:-$filelength}
  lines=$(expr $lines / 2)
  echo "Bisecting $1 in two files with $lines lines each."
  split -dl $lines "$1" "$1."
}

function wtz () {
  wget "$1" -o 'temp.tar.gz'
  tar -xvzf 'temp.tar.gz'
  rm 'temp.tar.gz'
}

function gitm () {
  git status
  echo "Are you really sure you want to commit everything?"
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

# See BCN COLORITRC for customizing colors in output
function cit () {
  $1 2>&1 | colorit
}

function mm () {
  meld $1/$3 $2/$3
}

function rem_print_1s () {
  scp "$1" $ip:~/temp.pdf
  ssh $ip "lp -d lp-tp2 -o media=a4 -o sides=one-sided temp.pdf"
}

function rem_show () {
  scp "$1" $ip:~/temp.pdf
  ssh -X $ip "evince ~/temp.pdf"
}

function ev () {
  evince "$1" &> /dev/null &
}

function go () {
  gnome-open "$1" &> /dev/null &
}

function print_vim () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ./"$1".pdf
  rm ~/output.ps
}

function ff () {
  find -iname "$1"
}

function fa () {
  find -iname "*$1*"
}

function backup_bcn () {
  if $mighty
  then
    sudo cp /etc/fstab ~/Dropbox/scripts/
  fi
}

function most_used_words () {
  echo 'solve this'
}

function shrink_pdf () {
  fname=$(basename $1)
  fbname=${fname%.*}
  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/ebook -sOutputFile=$fbname-small.pdf $1
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ GIT PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~ 

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
    PS1='$( __git_ps1 "(%s)\[\e[00m\]"
			) \[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;37m\]\h\[\e[01;37m\]:\[\e[01;34m\] \w\[\e[00;37m\] \[\e[00m\]'
  fi
  #python ~/Dropbox/days_left.py
}
 
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

# Only set prompt if interactive! Otherwise noninteractive commands like ssh
# throw warnings
case "$-" in
  *i*) setup_prompt;;
  *)	interactive=false ;;
esac

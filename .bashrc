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

#==========#
#  prelim  #
#==========#
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Airline as prompt
source ~/.shell_prompt.sh

#============#
#  settings  #
#============#
# Allow to use backspace when connected via ssh to certain systems
stty erase ^?

# Customize colors for ls
eval `dircolors $HOME/.dir_colorsrc`

# VI mode for bash
set -o vi
bind '"\e."':yank-last-arg

# Enable custom vim
if [ -f $HOME/install/bin/vim ]; then
  export VIMRUNTIME=$HOME/install/share/vim/vim74/
  export EDITOR=$HOME/install/bin/vim
  export VISUAL=$HOME/install/bin/vim
else
  export VIMRUNTIME=/usr/share/vim/vim74/
  export EDITOR=/usr/bin/vim
  export VISUAL=/usr/bin/vim
fi

# Use vim for my diffing functions
export difftool='vim -d'

# Narrowing greps search realms
a='--exclude-dir=.svn --exclude-dir=.git --exclude=*.swo '
export GREP_OPTIONS=$a'--exclude=*.swp --exclude=Makefile.in'

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

# Enabling backtracing in OCaml
export OCAMLRUNPARAM=b

#============#
#  hardware  #
#============#
# These should be in a local file

# Max out machine limits
ulimit -t unlimited              # cputime
ulimit -f unlimited              # filesize
ulimit -d unlimited              # datasize
ulimit -c unlimited              # coredumpsize
ulimit -m unlimited              # memoryuse
ulimit -v unlimited              # vmemoryuse
# These are usually not permitted
#ulimit -s unlimited              # stacksize
#ulimit -n unlimited              # descriptors
#ulimit -l unlimited              # memorylocked
#ulimit -u unlimited              # maxproc

# Number of cores for the CUBA library
export CUBACORES=1

# This is for processes spawned by CPUs within !OMP PARALLEL DO
export KMP_STACKSIZE=500000000
export KMP_AFFINITY='compact'

# Number of cores for the OpenMP library
export OMP_NUM_THREADS=12
export GOMP_CPU_AFFINITY="0 2 4 6 8 10 1 3 5 7 9 11"

#===========#
#  folders  #
#===========#
export wingames=/data/win_games
export lingames=/data/lnx_games
export syncd=$HOME/safe
export hive=$HOME/hive
export desy_soft=/afs/desy.de/group/theorie/software/ELF64
export install=$HOME/install
whiz_dir1=$HOME/trunk/install
whiz_dir2=/data/bcho/trunk/install
if [ -d $whiz_dir1 ]; then
  export whiz_soft=$whiz_dir1
elif [ -d $whiz_dir2 ]; then
  export whiz_soft=$whiz_dir2
fi

#=========#
#  paths  #
#=========#
prepend_path () {
  export PATH=$1/bin:$PATH
}
prepend_libpath () {
  export LD_LIBRARY_PATH=$1/lib64:$1/lib:$LD_LIBRARY_PATH
}
prepend_all_paths () {
  prepend_path $1
  prepend_libpath $1
}
add_pythonpath () {
  export PYTHONPATH=$PYTHONPATH:$HOME/$1
}

prepend_all_paths $install
prepend_all_paths $desy_soft
prepend_all_paths $whiz_soft/def

prepend_path $HOME/bcn_scripts

# python
add_pythonpath bcn_scripts/include
add_pythonpath Python-GoogleCalendarParser
add_pythonpath eZchat
add_pythonpath termstyle
add_pythonpath pydflatex
export PYTHONUSERBASE=$HOME/install

export CPATH=$desy_soft/include:$CPATH

# hep
export HEPMC_DIR=$install
export LHAPDF_DIR=$install

# perl
export PERL5LIB=$install/lib/perl5/

# spideroak
spider_dir=/scratch/bcho/SpiderOak/tmp/
if [ -d $spider_dir ]; then
  export SPIDEROAKDATADIR=$spider_dir
fi

command_exists () {
      type "$1" &> /dev/null ;
}
# opam
if command_exists opam; then
  eval `opam config env`
fi

# pydflatex
if command_exists pydflatex; then
  export pdftool=pydflatex
fi

# java
java_path=$syncd/codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*

# ifort
intel_dir=/opt/intel
if [ -f $intel_dir/bin/compilervars.sh ]; then
  source $intel_dir/bin/compilervars.sh intel64
fi
if [ -f $intel_dir/2013/bin/compilervars.sh ]; then
  source $intel_dir/2013/bin/compilervars.sh intel64
  #source $intel_dir/2011/vtune_amplifier_xe/amplxe-vars.sh
fi

# rivet
#source $install/rivet/rivet211/rivetenv.sh

#==================#
#  compiler flags  #
#==================#
export DEBUG="-O0 -Wall -fbounds-check -fbacktrace -finit-real=nan -g"
export DEBUG="$DEBUG -fcheck=all -fmax-errors=1 -ffpe-trap=invalid,zero,overflow,underflow,denormal"
export FCFLAGS="-fmax-errors=1 -O2 -fbounds-check"
# Simply append this this to your configure command with a space in front
export DEBUG_FCFLAGS="FCFLAGS=\"$DEBUG\""
export CFLAGS="-fPIC"

#====================#
#  printing at DESY  #
#====================#
export CUPS_SERVER=cups-hep.desy.de
alias prnt='lp -d t00ps1 -o sides=two-sided-long-edge'
alias prnt_2p='lp -d t00ps1 -o sides=two-sided-long-edge -o number-up=2'
function prnt_rng() {
  lp -d t00ps1 -o sides=two-sided-long-edge -o page-ranges=$1-$2 $3
}
alias prnt_1s='lp -d t00ps1 -o sides=one-sided'

#=======#
#  IPs  #
#=======#
if [ -f $hive/keys/IPs.sh ]; then
  source $hive/keys/IPs.sh
fi

function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

#=============#
#  nosetests  #
#=============#
nosetests_cover_cmd="nosetests --with-coverage --cover-erase --cover-tests --cover-package=\$(ls *.py | sed -r 's/[.]py$//' | fgrep -v '.' | paste -s -d ',') "
alias nosetests_cover=$nosetests_cover_cmd
alias nosetests_cover_sort="$nosetests_cover_cmd 2>&1 | fgrep '%' | sort -nr -k 4"

#=========#
#  cmake  #
#=========#
function cmake_recreate() {
  rm *
  cmake -D CMAKE_Fortran_COMPILER="$1" -D CMAKE_Fortran_FLAGS="$2" ../..
}

#==========#
#  custom  #
#==========#
# Current date in ISO norm
export today=`date -I`

# Acronym usable for UltiSnips and other
export USER_ACR=bcn

# Set the title of terminal
echo -en "\e]0;$USER_ACR - terminal\a"

#==============================================================================#
#                                    COLORS                                    #
#==============================================================================#
#==========#
#  normal  #
#==========#
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

#========#
#  bold  #
#========#
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

#==============#
#  background  #
#==============#
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
#                                  FUNCTIONS                                   #
#==============================================================================#
# Swap 2 files, if they exist
function swap() {
    local TMPFILE=tmp.$$
    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract() {
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

function shrink_pdf () {
  fname=$(basename $1)
  fbname=${fname%.*}
  gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
     -dCompatibilityLevel=1.5 -dPDFSETTINGS=/ebook \
     -sOutputFile=$fbname-small.pdf $1
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

function use_as_ref () {
  cp err-output/$1.out ~/trunk/share/tests/ref-output/$1.ref
}

function make_dot () {
  dot -Tpdf -o ${1%.dot}.pdf $1
}

function vim_print () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ./"$1".pdf
  rm ~/output.ps
}

function backup_settings () {
  sudo cp /etc/fstab ~/decrypted/scripts/backup/
  sudo cp ~/.local/share/keyrings ~/decrypted/scripts/backup/ -r
}

#function backup_root () {
  ##sudo rsync -avz /!(data|home|proc|sys|win_fs) /data/root_backup/
#}

function backup_home () {
  sudo rsync -avz $HOME /data/home_backup/
}

function kill_tty () {
  pid=$(ps -t $1 | grep 'bash' | head -c 6)
  kill -9 $pid
}

function mkdircd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

function ft_renamer () {
  for file in *.$1; do mv "$file" "${file%.$1}.$2"; done
}

function replace_by () {
  for file in *$1*; do mv $file ${file/$1/$2}; done
}

function wtz () {
  wget "$1" -O - | tar -xvz
}

# See BCN COLORITRC for customizing colors in output
function cit () {
  $1 2>&1 | colorit
}

function mm () {
  $difftool $1/$3 $2/$3
}

#============================#
#  Show certain information  #
#============================#
function show-wlan-channels () {
  sudo iwlist wlan0 scan | grep Frequency | sort | uniq -c | sort -n
}

function show-diff () {
  $difftool err-output/$1.out ~/trunk/share/tests/ref-output/$1.ref
}

function show-path () {
  tr ':' '\n' <<< "$PATH"
}

function show-lib-path () {
  tr ':' '\n' <<< "$LD_LIBRARY_PATH"
}

function show-failed-tests () {
  find -name 'test-suite.log' | xargs grep -v 'XFAIL' | grep -v ' 0' | grep 'FAIL'
}

function show-nr-of-own-threads () {
  ps -eLF | grep ^$USER | wc -l
}

function show-process () {
  ps -ef | grep $1
}

function kill-all () {
  pkill -f $1
}

function show-how-often-used-here () {
  rgrep $1 * | wc -l
}

# Get current host related info.
function show-host-information () {
  echo -e "\nYou are logged on ${BRed}$HOST"
  echo -e "\n${BRed}Additional information:$NC " ; uname -a
  echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
           cut -d " " -f1 | sort | uniq
  echo -e "\n${BRed}Current date :$NC " ; date
  echo -e "\n${BRed}Machine stats :$NC " ; uptime
  echo -e "\n${BRed}Memory stats (in MB):$NC " ; free -m
  echo -e "\n${BRed}Diskspace :$NC " ; df -h / $HOME
  echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
  #echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
  echo
}

alias show-cpu-info='lscpu; grep -i "model name" /proc/cpuinfo | uniq'

function show-disk-speed () {
  dd if=/dev/zero of=$1/output conv=fdatasync bs=100k count=1k; rm -f $1/output
}

function show-big-files () {
  find . -type f -size +20000k -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
}

function show-pylint-scores () {
  for i in ./*.py; do
  score=`pylint $i | grep "rated at" | awk '{print $7}'`
  echo "$i : $score"
done
}
#======================#
#  surpressing output  #
#======================#
function ev () {
  evince "$1" &> /dev/null &
}

function go () {
  gnome-open "$1" &> /dev/null &
}

function start () {
  $1 &> /dev/null &
}

function apv () {
  start "apvlv $1"
}

function mu () {
  start "mupdf-x11 $1"
}

#===========#
#  finding  #
#===========#
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

#========#
#  htop  #
#========#
if ! command_exists htop ; then
  alias htop=top
fi

#==============================================================================#
#                                  SHORTHANDS                                  #
#==============================================================================#
#============#
#  shortest  #
#============#
alias k='kill -9'
alias x='exit'
alias p='python'
alias t='/usr/bin/time'
alias c='./configure'

#========#
#  make  #
#========#
if command_exists cit; then
  alias n='cit nosetests'
  alias nv='cit "nosetests -v"'
  alias nt='cit "nosetests --with-timer"'
  alias ns='cit "nosetests -s"'
  alias no='nosetests_cover'
  alias m='cit "make -j"'
  alias mi='cit "make install -j"'
  alias mc='cit "make check -j"'
  alias mcl='cit "make clean -j"'
else
  alias n='nosetests'
  alias nv='nosetests -v'
  alias nt='nosetests --with-timer'
  alias ns='nosetests -s'
  alias no='nosetests_cover'
  alias m='make'
  alias mj='make -j'
  alias mi='make install'
  alias mc='make check'
  alias mcl='make clean'
fi
alias s='scons'
alias ac='autoreconf'

#===========#
#  configs  #
#===========#
alias so='source ~/.bashrc'
alias brc='vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias gitrc='vim ~/.gitconfig'

#====================#
#  change directory  #
#====================#
alias cd-='cd -'
alias cd..='cd ..'
alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

#=========#
#  lists  #
#=========#
alias ls='ls --color'
alias ll='ls --color -lh'
alias la='ls --color -lah'
alias lk='ls --color -lSrh'         #  Sort by size, biggest last.

#===========#
#  apt-get  #
#===========#
alias agi='sudo apt-get install'
alias agr='sudo apt-get remove'
alias agu='sudo apt-get update'
alias agg='sudo apt-get upgrade'
alias agd='sudo apt-get dist-upgrade'
alias AGU='agu; agg; agd'

#===========#
#  whizard  #
#===========#
alias wsrc='go '$whiz_soft/dist/share/doc/whizard/whizard.pdf
alias vsrc='go '$whiz_soft/dist/share/doc/vamp/vamp.pdf
alias osrc='go '$whiz_soft/dist/share/doc/omega/omega.pdf
alias csrc='go '$whiz_soft/dist/share/doc/circe2/circe2.pdf
alias wman='go '$whiz_soft/dist/share/doc/whizard/manual.pdf
alias gman='go '$whiz_soft/dist/share/doc/whizard/gamelan_manual.pdf

#=========#
#  games  #
#=========#
alias sc='cd '$lingames'/Stronghold; wine Stronghold\ Crusader.exe'
alias ut='wine '$wingames'/UnrealTournament/System/UnrealTournament.exe'
alias wc3='wine '$wingames'/Warcraft\ III/Frozen\ Throne.exe'
alias dk2='wine '$wingames'/DungeonKeeper2/DKII.exe'

#=========#
#  other  #
#=========#
alias py='ipython notebook --pylab inline &'
alias le='less'
if command_exists trash-put; then
  alias rm='trash-put -v'
  alias rmm='/bin/rm'
else
  alias rm='rm -vI'
fi
alias mv='mv -v'
alias md='mkdir'
alias mdc='mkdircd'
alias mt='t --format "Realtime \t%E , Mean Memory Size: \t%K , Max Memory Size: \t%M"'
alias sd='sudo shutdown now -P'
alias rb='sudo reboot'
alias rs='rem_show'
alias ca='cit ant'
alias re='export DISPLAY=:0; cinnamon &'
alias nhr='nohup ./run_all.sh 2>&1 &'
alias rgrep='grep -r'
alias hgrep='history | grep '
alias du_dirs='du * -sh | sort -h'
alias du_subdirs='du -h | sort -h'
alias briss="java -jar $syncd/scripts/briss-0.9/briss-0.9.jar"
alias primrun='vblank_mode=0 primusrun'
alias todo='rgrep --binary-files=without-match -n todo: *'
alias yt_mp3='youtube-dl -t --extract-audio --audio-format=mp3'
# dubious
alias ddiff='diff -x *.swp -q' #?
alias mount_wue='sshfs $int_quad_core1: /home/bijancn/Dropbox/uniwue/'
alias mount_out='sshfs $int_quad_core1:output_ovm/ /home/bijancn/Dropbox/master_thesis/output_ovm/'
alias get_thesis='git clone $nick:~/bcn_git/thesis.git'
alias reset_file_perms='find . -type f -exec chmod 644 {} +'
alias reset_dir_perms='find . -type d -exec chmod 755 {} +'

#==============================================================================#
#                                     GIT                                      #
#==============================================================================#
# Ignore changes to local file in status,
# useful for machine-specifc configs (followed by file)
alias gituiu='git update-index --assume-unchanged'

# Remove the above flag again to be able to commit changes of that file
alias gituinu='git update-index --no-assume-unchanged'

#==================#
#  initialization  #
#==================#
# Adding everything. Useful for initialisation but not much more.
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

# Create bare repo on the server (followed by reponame.git)
alias gitin='git init --bare'

# Push your complete local repo to the server
# (followed by ssh://user@yourserver/~/reponame.git)
alias gitpm='git push --mirror'

#==========#
#  basics  #
#==========#
# Add a single file or directory
alias gita='git add'

# Add and commit a single file or directory
function gitf () {
  gita "$1"; git commit -m "$2"
}

# Move a file with meta information
alias gitmv='git mv'

# Move a file with meta information
alias gitrm='git rm'

# Commit the staged changes to the HEAD
alias gitc='git commit -m'

# Clean the current directory of all build products and other non-tracked files
alias gitcl='git clean -x -i'

# Interactively add chunks and see what u have done (CUSTOM ALIAS)
alias giti='git interactive'

# See the current status
alias gits='git status'

# Pull from the remote
alias gitl='git pull'

# Pull from the remote and overwrite all local changes (CUSTOM ALIAS)
alias gitlh='git pullhard'

# Push to the remote
alias gitp='git push'

# Push all tags and branches to the remote
alias gitpa='git push --all origin'

# See the latest commits? (CUSTOM ALIAS)
alias gitn='git new'

#===============#
#  differences  #
#===============#
# Show the diff between unstaged changes (working dir) against the index
# If followed by master..branch it shows complete diff between branches
alias gitd='git diff'

# Show the diff between staged changes (index) against the current HEAD
alias gitdc='git diff --cached'

# Show all the changes since the last commit, staged or not
alias gitdh='git diff HEAD'

# Show which files have changed between branches (followed by: master..branch)
alias gitdb='git diff --stat --color'

#============#
#  branches  #
#============#
# Checkout another branch or file from it 'gite BRANCH -- FILE'
alias gite='git checkout'

# Cherry pick a commit from another branch
alias gitcp='git cherry-pick'

# Create a new branch (followed by branchname)
alias gitb='git branch'

# Rename your current branch (followed by newbranchname)
alias gitbm='git branch -m'

# Switch to master and get updates from svn
alias gsu='gite master ; svnu ; gits'

#=================#
#  VISUALIZATION  #
#=================#
# Creates a dot file. TODO: Add the pipe through dot and show the pdf
alias gitm='git makedot'
alias gitml='git mylog'
alias gitml2='git morelog'
alias gitml3='git shortlog'

#===================#
#  bash completion  #
#===================#
if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
fi

#==========#
#  github  #
#==========#
function github {
  git clone git@github.com:$1/$2.git
}

function bitbucket {
  git clone ssh://git@bitbucket.org/$1/$2.git
}

function bitbucket_hg {
  hg clone ssh://hg@bitbucket.org/$1/$2
}

#==============================================================================#
#                                     SVN                                      #
#==============================================================================#
if [ svn-color 2> /dev/null ]; then
  alias svn=svn-color
fi
alias svna='svn add'
alias svnu='svn update'
alias svns='svn status'
alias svnd='svn diff'
alias svnc='svn commit'

#==============================================================================#
#                                    PROMPT                                    #
#==============================================================================#
## Print nickname for git/hg/bzr/svn version control in CWD
## Optional $1 of format string for printf, default "(%s) "
function get_branch {
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
if [ -f ~/.git-prompt.sh ] ; then
  source ~/.git-prompt.sh
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
  export PS1="\$(get_branch "$2")${PS1}";
else
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
fi

#==============================================================================#
#                              Colored Man Pages                               #
#==============================================================================#
man() {
	env \
		LESS_TERMCAP_mb=$(printf "$BGreen") \
		LESS_TERMCAP_md=$(printf "$BRed") \
		LESS_TERMCAP_me=$(printf "$Black") \
		LESS_TERMCAP_se=$(printf "$Blue") \
		LESS_TERMCAP_so=$(printf "$Black") \
		LESS_TERMCAP_ue=$(printf "$Black") \
		LESS_TERMCAP_us=$(printf "$BBlue") \
			man "$@"
}

#==============================================================================#
#                       PROGRAMMABLE COMPLETION SECTION                        #
#==============================================================================#
# Most are taken from the bash 2.05 documentation and from Ian McDonald's
# 'Bash completion' package (http://www.caliban.org/bash/#completion)
# You will in fact need bash more recent then 3.0 for some features.
#
# Note that most linux distributions now provide many completions
# 'out of the box' - however, you might need to make your own one day.
#==============================================================================#
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

# This is a 'universal' completion function - it works when commands have
# a so-called 'long options' mode , i.e., 'ls --all' instead of 'ls -a'

# First, remove '=' from completion word separators
# (this will allow completions like 'ls --color=auto' to work correctly).

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}

_get_longopts() {
  #$1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
  #grep ^"$2" |sort -u ;
    $1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" |sort -u
}

_longopts() {
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

_make() {
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

_killall() {
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    # Get a list of processes
    # (the first sed evaluation
    # takes care of swapped out processes, the second
    # takes care of getting the basename of the process).
    COMPREPLY=( $( ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}

complete -F _killall killall killps

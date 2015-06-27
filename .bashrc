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

export arch=`getconf LONG_BIT`

#============#
#  settings  #
#============#
# Allow to use backspace when connected via ssh to certain systems
stty erase ^?

# VI mode for bash
set -o vi
bind '"\e."':yank-last-arg

# Use vim for my diffing functions
export difftool='vim -d'

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
export install=$HOME/install
export install2=/scratch/bcho/install

whiz_dir1=/scratch/bcho/trunk/_install
whiz_dir2=$HOME/trunk/_install
if [ -d $whiz_dir1 ]; then
  export whiz_soft=$whiz_dir1
elif [ -d $whiz_dir2 ]; then
  export whiz_soft=$whiz_dir2
fi
trnk() { cd $whiz_soft/.. ; }
bui() { cd $whiz_soft/../_build/develop ; }

tmp1=$HOME/hep/GoSam/local
tmp2=/data/bcho/gosam/local
if [ -d $tmp1 ]; then
  export gosam_soft=$tmp1
elif [ -d $tmp2 ]; then
  export gosam_soft=$tmp2
fi

tmp1=$HOME/hep/OpenLoops
tmp2=/data/bcho/OpenLoops
if [ -d $tmp1 ]; then
  export openloops_soft=$tmp1
elif [ -d $tmp2 ]; then
  export openloops_soft=$tmp2
fi
#=========#
#  paths  #
#=========#
prepend-path () {
  export PATH=$1/bin:$PATH
}
prepend-pure-path () {
  export PATH=$1:$PATH
}
prepend-libpath () {
  export LD_LIBRARY_PATH=$1/lib64:$1/lib:$LD_LIBRARY_PATH
}
prepend-all-paths () {
  prepend-path $1
  prepend-libpath $1
}
add-pythonpath () {
  export PYTHONPATH=$PYTHONPATH:$HOME/$1
}

tmp1=/data/bcho/install
tmp2=/afs/desy.de/group/theorie/software/ELF64
tmp3=/afs/desy.de/group/theorie/software/ELF32
if [ -d $tmp1 ]; then
  export desy_soft=$tmp1
elif test $arch = 64; then
  export desy_soft=$tmp2
else
  export desy_soft=$tmp3
fi

if test $arch = 64; then
  export desy_tex=/afs/desy.de/products/texlive/2012/bin/x86_64-linux
  prepend-all-paths $install
else
  export desy_tex=/afs/desy.de/products/texlive/2012/bin/i386-linux
fi

prepend-pure-path $desy_tex
prepend-all-paths $desy_soft
prepend-all-paths $whiz_soft/develop

if [ -d $install2 ]; then
  prepend-all-paths $install2
fi

prepend-path $HOME/bcn_scripts

prepend-pure-path $HOME/jrfonseca.gprof2dot

# python
add-pythonpath bcn_scripts/include
add-pythonpath Python-GoogleCalendarParser
add-pythonpath eZchat
add-pythonpath termstyle
add-pythonpath pydflatex
export C_INCLUDE_PATH=$install/include
export CPLUS_INCLUDE_PATH=$install/include
export PYTHONUSERBASE=$HOME/install
export CPATH=$desy_soft/include:$CPATH
export CC=gcc

# hep
#if test -f $install/rivetenv.sh -a $arch = 64; then
  #source $install/rivetenv.sh
#fi
prepend-all-paths $gosam_soft
export HEPMC_DIR=$install
export LHAPDF_DIR=$install
export LATEXINPUTS=${HOME}/texmf:${LATEXINPUTS}
export TEXINPUTS=${HOME}/texmf:${TEXINPUTS}
export TEXMFCNF=${HOME}/texmf:${TEXMFCNF}
export HOMETEXMF=${HOME}/texmf:${HOMETEXMF}
export TEXMFHOME=${HOME}/texmf:${TEXMFHOME}
pythia-configure(){
  packages='--with-hepmc2=$install --with-lhapdf6=$install --with-fastjet3=$install'
  ./configure --prefix=$install $packages
}
pythia-configure-desy(){
  packages='--with-hepmc2=$desy_soft --with-lhapdf6=$desy_soft --with-fastjet3=$desy_soft'
  ./configure --prefix=$install $packages
}
checkout-openloops(){
  #svn checkout http://openloops.hepforge.org/svn/OpenLoops/branches/public_beta ./OpenLoops
  svn checkout http://openloops.hepforge.org/svn/OpenLoops/branches/public ./OpenLoops
  printf '[OpenLoops]\nprocess_repositories=public, whizard' >> OpenLoops/openloops.cfg
  cd OpenLoops
  ./scons
  ./openloops libinstall ppzj ppzjj
  cd examples
  scons
  ./OL_fortran
}
openloops-getlibs(){
  ./openloops libinstall ppll eevvjj eett
}

export OpenLoopsPath=$openloops_soft
prepend-libpath $openloops_soft

# perl
export PERL5LIB=$install/lib/perl5

# spideroak
spider_dir=/scratch/bcho/SpiderOak/tmp
if [ -d $spider_dir ]; then
  export SPIDEROAKDATADIR=$spider_dir
fi

command-exists () {
      type "$1" &> /dev/null ;
}
# opam
if command-exists opam; then
  eval `opam config env`
fi

# pydflatex
if command-exists pydflatex; then
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
if test -f $intel_dir/bin/compilervars.sh -a $arch = 64; then
  source $intel_dir/bin/compilervars.sh intel64
fi
if test -f $intel_dir/2013/bin/compilervars.sh -a $arch = 64; then
  source $intel_dir/2013/bin/compilervars.sh intel64
  #source $intel_dir/2011/vtune_amplifier_xe/amplxe-vars.sh
fi

# vim
if [ -f /usr/local/bin/nvim ]; then
  export VIMRUNTIME=/usr/local/share/nvim/runtime/
  export EDITOR=/usr/local/bin/nvim
  export VISUAL=/usr/local/bin/nvim
elif test -n "`$install/bin/vim --version 2> /dev/null`"; then
  export VIMRUNTIME=$install/share/vim/vim74/
  export EDITOR=$install/bin/vim
  export VISUAL=$install/bin/vim
else
  export VIMRUNTIME=/usr/share/vim/vim74/
  export EDITOR=/usr/bin/vim
  export VISUAL=/usr/bin/vim
fi

#==================#
#  compiler flags  #
#==================#
export DEBUG="-O0 -Wall -fbounds-check -fbacktrace -finit-real=nan -g"
export DEBUG="$DEBUG -fcheck=all -fmax-errors=1 -ffpe-trap=invalid,zero,overflow,underflow,denormal"
export FCFLAGS="-fmax-errors=1 -O2"
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

function my-ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

#=============#
#  nosetests  #
#=============#
nosetests_cover_cmd="nosetests --with-coverage --cover-erase --cover-tests --cover-package=\$(ls *.py | sed -r 's/[.]py$//' | fgrep -v '.' | paste -s -d ',') "
alias -- nosetests-cover="$nosetests_cover_cmd"
alias -- nosetests-cover-sort="$nosetests_cover_cmd 2>&1 | fgrep '%' | sort -nr -k 4"

#=========#
#  cmake  #
#=========#
function cmake-recreate() {
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
function set-title() {
  echo -en "\e]0;$1\a"
}

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
# Check if a command has a version larger or equal than demanded
version-bigger () {
  version=`$1 --version | head -n1 | sed 's/[^0-9.]*\([0-9.]*\).*/\1/'`
  bigger=`version_compare.py $version $2`
  [ $bigger == 'first' ] || [ $bigger == 'equal' ]
}

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

function shrink-pdf () {
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

function rem-print-1s () {
  scp "$1" $ip:~/temp.pdf
  ssh $ip "lp -d lp-tp2 -o media=a4 -o sides=one-sided temp.pdf"
}

function rem-show () {
  scp "$1" $ip:~/temp.pdf
  ssh -X $ip "evince ~/temp.pdf"
}

function find-type () {
  rgrep "public :: ${1}_t\$" -B1
}

function make-dot () {
  dot -Tpdf -o ${1%.dot}.pdf $1
}

function vim-print () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ./"$1".pdf
  rm ~/output.ps
}

function backup-settings () {
  sudo cp /etc/fstab ~/decrypted/scripts/backup/
  sudo cp ~/.local/share/keyrings ~/decrypted/scripts/backup/ -r
}

#function backup-root () {
  #sudo rsync -avz /!(data|home|proc|sys) /data/root-backup/
#}

function backup-home () {
  rsync -avz $HOME /data/home-backup/
}

function kill-tty () {
  pid=$(ps -t $1 | grep 'bash' | head -c 6)
  kill -9 $pid
}

function mkdircd () {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

function ft-renamer () {
  for file in *.$1; do mv "$file" "${file%.$1}.$2"; done
}

function replace-by () {
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

parallel_jobs=
if test -r /proc/cpuinfo; then
  n=`grep -c '^processor' /proc/cpuinfo`
  #if test $n -gt 1; then
  #  parallel_jobs="-j `expr \( 1 \* $n \) / 3`"
  #fi
  parallel_jobs="-j $n"
fi

function show-parallel-jobs () {
  echo $parallel_jobs
}

function show-diff () {
  $difftool err-output/$1.out ../../../../share/tests/ref-output/$1.ref
}

function show-diff-double () {
  $difftool err-output/$1.out ../../../../share/tests/ref-output-double/$1.ref
}

function show-diff-ext () {
  $difftool err-output/$1.out ../../../../share/tests/ref-output-ext/$1.ref
}

function use-as-ref () {
  cp err-output/$1.out ../../../share/tests/ref-output/$1.ref
}

function show-this-diff () {
  $difftool $1.log ../../../../share/tests/ref-output/$1.ref
}

function use-this-as-ref () {
  cp $1.log ../../../../share/tests/ref-output/$1.ref
}

function show-this-diff-double () {
  $difftool $1.log ../../../../share/tests/ref-output-double/$1.ref
}

function use-this-as-ref-double () {
  cp $1.log ../../../../share/tests/ref-output-double/$1.ref
}

function show-this-diff-ext () {
  $difftool $1.log ../../../../share/tests/ref-output-ext/$1.ref
}

function use-this-as-ref-ext () {
  cp $1.log ../../../../share/tests/ref-output-ext/$1.ref
}

function update-variable-refs () {
  use-this-as-ref show_4
  cp process_log_1_p1.log ../../../../share/tests/ref-output/process_log.ref
  use-this-as-ref vars
  use-as-ref rt_data_1
  use-as-ref rt_data_2
  use-as-ref rt_data_3
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

function show-our-lines-of-code () {
  wc -l */*.nw | sort -n
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
  rgrep "$1" * | wc -l
}

function fmo () {
  rgrep "module $1" --exclude-dir=_build -- *
}

function fsu () {
  rgrep "subroutine $1" --exclude-dir=_build -- *
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
  echo -e "\n${BRed}Local IP Address :$NC" ; my-ip
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
if ! command-exists htop ; then
  alias htop=top
fi

#=============#
#  callgrind  #
#=============#
function callgrind-graph () {
  gprof2dot.py -f callgrind $1 | dot -Tpdf -o ${1}.pdf
}

function callgrind () {
  valgrind --tool=callgrind $1
}

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
alias b="cd $HOME/trunk/_build"

#========#
#  make  #
#========#
if command-exists colorit; then
  alias n='cit nosetests'
  alias nV='cit "nosetests -v"'
  alias nt='cit "nosetests --with-timer"'
  alias ns='cit "nosetests -s"'
  alias no='nosetests-cover'
  alias m='cit "make V=0 $parallel_jobs"'
  alias mV='cit "make V=1 $parallel_jobs"'
  alias mi='cit "make V=0 install $parallel_jobs"'
  alias miV='cit "make V=1 install $parallel_jobs"'
  alias mc='cit "make check $parallel_jobs V=0"'
  alias mcl='cit "make clean $parallel_jobs V=0"'
else
  alias n='nosetests'
  alias nv='nosetests -v'
  alias nt='nosetests --with-timer'
  alias ns='nosetests -s'
  alias no='nosetests-cover'
  alias m='make $parallel_jobs V=0'
  alias mi='make install $parallel_jobs V=0'
  alias mc='make check $parallel_jobs V=0'
  alias mcl='make clean $parallel_jobs V=0'
fi
alias s='scons'
alias scl='scons --clean'
alias ac='autoreconf'
alias bp='bitpocket'

#===========#
#  configs  #
#===========#
alias so='source ~/.bashrc'
alias brc='vim ~/.bashrc'
alias src='vim ~/.ssh/config'
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
alias lsd='ls --color -d */'
alias ll='ls --color -lh'
alias la='ls --color -lah'
alias lad='ls --color -lah -d */'
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
alias wh='whizard test.sin'
alias wsrc='go '$whiz_soft/dist/share/doc/whizard/whizard.pdf
alias vsrc='go '$whiz_soft/dist/share/doc/vamp/vamp.pdf
alias osrc='go '$whiz_soft/dist/share/doc/omega/omega.pdf
alias csrc='go '$whiz_soft/dist/share/doc/circe2/circe2.pdf
alias wman='go '$whiz_soft/dist/share/doc/whizard/manual.pdf
alias gman='go '$whiz_soft/dist/share/doc/whizard/gamelan_manual.pdf
export WHIZARD_BIN=$whiz_soft/develop/bin/whizard
function make-test () {
  make check TESTS=$1.run
}
function enable-debug () {
  sed -i "s/DEBUG_$1 = \.false\./DEBUG_$1 = .true./" -- src/*/*.nw
}
function disable-debug () {
  sed -i "s/DEBUG_$1 = \.true\./DEBUG_$1 = .false./" -- src/*/*.nw
}
alias mt=make-test

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
alias regain_afs='kinit && aklog'
alias py='ipython notebook --pylab inline &'
alias le='less'
if command-exists trash-put; then
  alias rm='trash-put -v'
  alias rmm='/bin/rm'
else
  if version-bigger rm 8.4; then
    alias rm='rm -vI'
  fi
fi
alias mv='mv -v'
alias md='mkdir'
alias mdc='mkdircd'
alias mti='t --format "Realtime \t%E , Mean Memory Size: \t%K , Max Memory Size: \t%M"'
alias sd='sudo shutdown now -P'
alias rb='sudo reboot'
alias rs='rem-show'
alias ca='cit ant'
alias re='export DISPLAY=:0; cinnamon &'
alias nhr='nohup ./run_all.sh 2>&1 &'
alias rgrep='grep -r'
alias hgrep='history | grep '
alias du-dirs='du -sh -- * | sort -h'
alias du-subdirs='du -h | sort -h'
alias briss="java -jar $syncd/scripts/briss-0.9/briss-0.9.jar"
alias primrun='vblank_mode=0 primusrun'
alias todo='rgrep --binary-files=without-match -n todo: *'
alias yt-mp3='youtube-dl -t --extract-audio --audio-format=mp3'
# dubious
alias ddiff='diff -x *.swp -q' #?
alias reset-file-perms='find . -type f -exec chmod 644 {} +'
alias reset-dir-perms='find . -type d -exec chmod 755 {} +'

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

function bitbucket-hg {
  hg clone ssh://hg@bitbucket.org/$1/$2
}

#==============================================================================#
#                                     SVN                                      #
#==============================================================================#
if test -n "`svn-color --version 2> /dev/null`"; then
  alias svn=svn-color
fi
alias svna='svn add'
alias svnu='svn update'
alias svns='svn status'
alias svnc='svn commit'

# Show the changes that will be commited
alias svnd='svn diff'

# Edit which files are ignored in the current directory
alias svnp='svn propedit svn:ignore .'

# Revert all changes made recursively
alias svnR='svn revert -R .'

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
if [ -f ~/.git-prompt.sh ] ; then
  source ~/.git-prompt.sh
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
  export PS1="\$(get-branch "$2")${PS1}";
else
  PS1='\[\e[00;34m\]\u\[\e[02;37m\]@\[\e[01;31m\]\h:\[\e[01;34m\] \w \[\e[00m\]\n $ '
fi

#==============================================================================#
#                                More Settings                                 #
#==============================================================================#
# Narrowing greps search realms
if version-bigger grep 2.6.3; then
  a='--exclude-dir=.svn --exclude-dir=.git --exclude=*.swo --exclude-dir=_build '
  export GREP_OPTIONS=$a'--exclude=*.swp --exclude=Makefile.in --exclude-dir=_install'
fi

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

#================#
#  screen title  #
#================#
if [[ "$TERM" == screen* ]]; then
  screen_set_window_title () {
  local HPWD="$PWD"
  # replace $HOME with ~
  case $HPWD in
    $HOME) HPWD="~";;
    $HOME/*) HPWD="~${HPWD#$HOME}";;
  esac
  # Only use current directory name (without path)
  HPWD=${HPWD##*/}
  printf '\ek%s\e\\' "$HPWD"
  }
  PROMPT_COMMAND="screen_set_window_title;
  $PROMPT_COMMAND"
fi
export TERM='xterm-256color'

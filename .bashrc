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
export arch=`getconf LONG_BIT`

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export ez_host='95.143.172.252'
export ez_port=64835

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
#export OCAMLRUNPARAM=b

#============#
#  hardware  #
#============#
# These should be in a local file

# Max out machine limits
ulimit -t unlimited              # cputime
ulimit -d unlimited              # datasize
ulimit -m unlimited              # memoryuse

# These are usually not permitted
#ulimit -f unlimited              # filesize
#ulimit -c unlimited              # coredumpsize
#ulimit -v unlimited              # vmemoryuse

#ulimit -s unlimited              # stacksize
#ulimit -n unlimited              # descriptors
#ulimit -l unlimited              # memorylocked
#ulimit -u unlimited              # maxproc

# Number of cores for the CUBA library
#export CUBACORES=1

# This is for processes spawned by CPUs within !OMP PARALLEL DO
export KMP_STACKSIZE=500000000
export KMP_AFFINITY='compact'

# Number of cores for the OpenMP library
export OMP_NUM_THREADS=12
export GOMP_CPU_AFFINITY="0 2 4 6 8 10 1 3 5 7 9 11"

parallel_jobs=
if test -r /proc/cpuinfo; then
  n=`grep -c '^processor' /proc/cpuinfo`
  if test $n -gt 1; then
    parallel_jobs="-j `expr \( 1 \* $n \) / 3`"
  else
    parallel_jobs="-j $n"
  fi 
fi

# Path for FORM temp files
export FORMTMP=/tmp

#===========#
#  folders  #
#===========#
export wingames=/data/win_games
export lingames=/data/lnx_games
export syncd=$HOME/safe
export hive=$HOME/hive
export install=$HOME/install

# ifort
intel_dir=/opt/intel
if test -f $intel_dir/bin/compilervars.sh -a $arch = 64; then
  source $intel_dir/bin/compilervars.sh intel64
elif test -f $intel_dir/2016/bin/compilervars.sh -a $arch = 64; then
  source $intel_dir/2016/bin/compilervars.sh intel64
  #source $intel_dir/2011/vtune_amplifier_xe/amplxe-vars.sh
fi

whiz_dir1=/scratch/bcho/trunk/_install/develop
whiz_dir2=$HOME/trunk/_install/develop
whiz_dir3=
if [ -d $whiz_dir1 ]; then
  export whiz_soft=$whiz_dir1
elif [ -d $whiz_dir2 ]; then
  export whiz_soft=$whiz_dir2
elif [ -d $whiz_dir3 ]; then
  export whiz_soft=$whiz_dir3
fi
trnk() { cd $whiz_soft/../.. ; }
bui() { cd $whiz_soft/../../_build/develop ; }

tmp1=$HOME/hep
tmp2=/nfs/theoc/data/bcho/bird
tmp3=/data/bcho
if [ -d $tmp1 ]; then
  export hep=$tmp1
elif [ -d $tmp2 ]; then
  export hep=$tmp2
elif [ -d $tmp3 ]; then
  export hep=$tmp3
fi

if [ -n "$hep" ]; then
  export openloops_soft=$hep/OpenLoops
  export gosam_soft=$hep/gosam/local
  export std_install=$hep/install
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
  export PYTHONPATH=$PYTHONPATH:$1
}

if [[ $arch == *64* ]]; then
  export desy_tex=/afs/desy.de/products/texlive/2012/bin/x86_64-linux
  prepend-all-paths $install
else
  export desy_tex=/afs/desy.de/products/texlive/2012/bin/i386-linux
fi

prepend-pure-path $desy_tex
prepend-path $HOME/.gem/ruby/1.9.1
prepend-all-paths $std_install
if [ -n "$whiz_soft" ]; then
  prepend-all-paths $whiz_soft
fi

prepend-path $HOME/bcn_scripts

prepend-pure-path $HOME/jrfonseca.gprof2dot

# python
add-pythonpath $HOME/bcn_scripts/include
add-pythonpath $HOME/Python-GoogleCalendarParser
add-pythonpath $HOME/eZchat
add-pythonpath $HOME/.vim/plugged/vim-eZchat/autoload
add-pythonpath $HOME/termstyle
add-pythonpath $HOME/pydflatex
add-pythonpath $std_install/lib/python
export C_INCLUDE_PATH=$install/include
export CPLUS_INCLUDE_PATH=$install/include
export PYTHONUSERBASE=$HOME/install
export CPATH=$std_install/include:$CPATH
export CC=gcc

# hep
# DONT USE THIS! Check what is needed and do it your self
#source $std_install/rivetenv.sh
prepend-all-paths $gosam_soft
export LATEXINPUTS=${HOME}/texmf:$std_install/share/texmf/tex/latex/misc:$LATEXINPUTS
export TEXINPUTS=${HOME}/texmf:$std_install/share/texmf/tex/latex/misc:$TEXINPUTS
export TEXMFCNF=${HOME}/texmf:${TEXMFCNF}
export HOMETEXMF=${HOME}/texmf:${HOMETEXMF}
export TEXMFHOME=${HOME}/texmf:${TEXMFHOME}
pythia-configure(){
  packages='--with-hepmc2=$install --with-lhapdf6=$install --with-fastjet3=$install'
  ./configure --prefix=$install $packages
}
pythia-configure-desy(){
  packages='--with-hepmc2=$std_install --with-lhapdf6=$std_install --with-fastjet3=$std_install'
  ./configure --prefix=$install $packages
}
checkout-openloops(){
  #svn checkout http://openloops.hepforge.org/svn/OpenLoops/branches/public_beta ./OpenLoops
  svn checkout http://openloops.hepforge.org/svn/OpenLoops/branches/public ./OpenLoops
  printf '[OpenLoops]\nprocess_repositories=public, whizard\ncompile_extra=1' >> OpenLoops/openloops.cfg
  cd OpenLoops
  ./scons
  ./openloops libinstall ppzj ppzjj ppll ppllj eett eehtt eevvjj
  cd examples
  scons
  ./OL_fortran
}

export OpenLoopsPath=$openloops_soft
prepend-libpath $openloops_soft

# perl
export PERL5LIB=$install/lib/perl5

# spideroak
#spider_dir=/scratch/bcho/SpiderOak/tmp
#if [ -d $spider_dir ]; then
  #export SPIDEROAKDATADIR=$spider_dir
#fi

command-exists () {
      type "$1" &> /dev/null ;
}

# opam
#if command-exists opam; then
  #eval `opam config env`
#fi

# pydflatex
if command-exists pydflatex; then
  export pdftool=pydflatex
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
export FCFLAGS="-fmax-errors=1 -O2"
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

function all () {
  for i in *$2*; do $1 "$i" & done
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

function convert-pdf-to-jpg {
  for i in $1; do convert -quality 100 -density 300 $i ${i}_c.jpg; done
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

function sshow () {
  scp $1:$2 .
  go $(basename $2)
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

function kill-tty () {
  pid=$(ps -t $1 | grep 'bash' | head -c 6)
  kill -9 $pid
}

function kill-myjobs () {
  #echo `ps x | grep -v ssh`
  pids=`ps x | grep -v ssh | grep -v bash | tail -n +2 | awk '{print $1}'`
  echo "PIDS: $pids"
  for pid in $pids; do
    echo "Killing now `ps -p $pid -o comm -p 27598 -o comm=`"
    kill -9 $pid
  done
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

#======================#
#  surpressing output  #
#======================#
function go () {
  gnome-open "$1" &> /dev/null &
}

#===========#
#  finding  #
#===========#
function fa () {
  find -iname "*$1*"
}
alias rgrep='grep -r'
alias hgrep='history | grep '
# Narrowing greps search realms
if version-bigger grep 2.6.3; then
  a='--exclude-dir=.svn --exclude-dir=.git --exclude=*.swo --exclude-dir=_build '
  export GREP_OPTIONS="$a--exclude=*.swp --exclude=Makefile.in --exclude-dir=_install"
fi

#========#
#  htop  #
#========#
if ! command-exists htop ; then
  alias htop=top
fi

alias show-top-processes="top -b -n 1 | grep -v ' root ' | head -n 12  | tail -n 8"

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
alias wm='make $parallel_jobs && make -C src/ check $parallel_jobs'
alias s='scons $parallel_jobs'
alias scl='scons --clean $parallel_jobs'
alias ac='autoreconf'
alias bp='bitpocket'

#===========#
#  cluster  #
#===========#
alias qst='cit qstat'

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
alias resubmit-failed-jobs='for i in `cat /data/bcho/BitPocketMaster/jobs`; do file=TuningEEqqMSTJ11eq*/Professor*/mc/*-*/compile.o$i; cd `dirname $file`; qsub -V ~/bcn_scripts/submit; cd -; done'
alias wsrc='go '$whiz_soft/../dist/share/doc/whizard/whizard.pdf
alias vsrc='go '$whiz_soft/../dist/share/doc/vamp/vamp.pdf
alias osrc='go '$whiz_soft/../dist/share/doc/omega/omega.pdf
alias csrc='go '$whiz_soft/../dist/share/doc/circe2/circe2.pdf
alias wman='go '$whiz_soft/../dist/share/doc/whizard/manual.pdf
alias gman='go '$whiz_soft/../dist/share/doc/whizard/gamelan_manual.pdf
export WHIZARD_BIN=$whiz_soft/../develop/bin/whizard
function make-test () {
  make check TESTS=$1.run
}
alias mt=make-test
function get-RES () {
  grep RES $1-*/whizard.log | sed 's/^.*RES //'
}
function save-RES () {
  file=/data/bcho/whizard_ttbar_threshold_project/Data/validation/$(basename $1)$2.dat
  get-RES $1 > $file && echo "Saved to $file"
}

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
alias sd='sudo shutdown now -P'
alias rb='sudo reboot'
alias re='export DISPLAY=:0; cinnamon &'
alias du-dirs='du -sh -- * | sort -h'
alias du-subdirs='du -h | sort -h'
alias briss="java -jar $syncd/scripts/briss-0.9/briss-0.9.jar"
alias yt-mp3='youtube-dl -t --extract-audio --audio-format=mp3'
alias reset-file-perms='find . -type f -exec chmod 644 {} +'
alias reset-dir-perms='find . -type d -exec chmod 755 {} +'

#==============================================================================#
#                                SHOW-COMMANDS                                 #
#==============================================================================#
function show-wlan-channels () {
  sudo iwlist wlan0 scan | grep Frequency | sort | uniq -c | sort -n
}

alias show-distro="lsb_release -a"

alias show-parallel-jobs="echo $parallel_jobs"

function find-ref-dir () {
  pwd=`pwd`
  ref_dir=../../../../share/tests/$(basename $pwd)
  grep 'FC_EXT_OR_SINGLE = single' Makefile
  if test "$?" = "0" -a -f $ref_dir/ref-output-double/$1.ref; then
    echo "$ref_dir/ref-output-double"
  elif test "$?" = "1" -a -f $ref_dir/ref-output-ext/$1.ref; then
    echo "$ref_dir/ref-output-ext"
  elif test -f $ref_dir/ref-output/$1.ref; then
    echo "$ref_dir/ref-output"
  else
    echo "File not found in normal, double or extended!"
    echo "ref dir $ref_dir"
  fi
}

function show-this-diff () {
  $difftool $1.log `find-ref-dir $1`/$1.ref
}

function use-this-as-ref () {
  cp $1.log `find-ref-dir $1`/$1.ref
}

function show-diff () {
  $difftool err-output/$1.out `find-ref-dir $1`/$1.ref
}

function use-as-ref () {
  cp err-output/$1.out `find-ref-dir $1`/$1.ref
}

function show-diff-processlog {
  vimdiff process_log_1_p1.log ../../../../share/tests/functional_tests/ref-output/process_log.ref
}

function use-as-ref-processlog {
  cp process_log_1_p1.log ../../../../share/tests/functional_tests/ref-output/process_log.ref
}

function update-variable-refs () {
  cd tests/unit_tests
  use-as-ref rt_data_1
  use-as-ref rt_data_2
  use-as-ref rt_data_3
  cd ../functional_tests
  use-this-as-ref show_4
  use-as-ref-processlog
  use-this-as-ref vars
  cd ../..
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

function show-how-often-used-here () {
  rgrep "$1" * | wc -l
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
# Adding everything. Useful for initialisation and svn updates
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
alias gitl='git pull --rebase'

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

# Switch to svn and get updates from svn
alias gsu='gite svn ; svnu ; gits'

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
if command-exists svn-color; then
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

function get-link-svn {
  svn info $1 | sed -ne 's/^URL: //p' | sed 's/\/desy/\/public/'
}

#==============================================================================#
#                                     TCON                                     #
#==============================================================================#
alias tcstart='tcon start ~/theoc.yaml --session-name=theoc'
function tcsend {
  tcon send theoc "$1"
}
alias tcdel='tcon delete --all'

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

#==============================================================================#
#                                    SCREEN                                    #
#==============================================================================#
#if [[ "$TERM" == screen* ]]; then
  #screen_set_window_title () {
  #local HPWD="$PWD"
  ## replace $HOME with ~
  #case $HPWD in
    #$HOME) HPWD="~";;
    #$HOME/*) HPWD="~${HPWD#$HOME}";;
  #esac
  ## Only use current directory name (without path)
  #HPWD=${HPWD##*/}
  #printf '\ek%s\e\\' "$HPWD"
  #}
  #PROMPT_COMMAND="screen_set_window_title;
  #$PROMPT_COMMAND"
#fi

export TERM='xterm-256color'
export BASHRC_SET='set'

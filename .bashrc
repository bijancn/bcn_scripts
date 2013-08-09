# ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN BASHRC ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# bcn:              bijan@chokoufe.com
# Recent versions:  https://github.com/bijanc/bcn_scripts
# Last Change:      2013 Aug 09
#
# Put me in:
#             for Linux:     ~/.bashrc
# 
# bash configuration file. Maintained since 2012.

eval `dircolors $HOME/.dir_colorsrc`
#source /opt/intel/composer_xe_2013.3.163/bin/compilervars.sh intel64
export CUBACORES=1
export PATH=$PATH:$HOME/ocaml/bin
export PYTHONPATH=$PYTHONPATH:$HOME/codes/python
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Dropbox/master_thesis/OMega-2.1.1Build/src/.libs/
wingames='/data/Games'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ JAVA CLASSPATH ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
java_path=$HOME/Dropbox/Codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ IP's ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
std_usr=bchokoufe
wue=$std_usr@132.187.196
ip=$std_usr@wtpp121.physik.uni-wuerzburg.de
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
int_quad_core1=$wue.138        # free
int_quad_core2=$wue.143        # aschenkel, free
int_quad_core3=$wue.134        # free
int_quad_core3=$wue.125        # free
int_i7=$wue.171                # mauricio, free
public=$std_usr@wtpp004.physik.uni-wuerzburg.de
clustr=$std_usr@wtpp020.physik.uni-wuerzburg.de
hepforge=$std_usr@login.hepforge.org
home_ip=192.168.2.152

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ SHORTHANDS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
alias t='/usr/bin/time'
alias mt='t --format "Realtime \t%E , Mean Memory Size: \t%K , Max Memory Size: \t%M"'
alias c='./configure'
alias p='python' 
alias m='cit make'
alias x='exit'
alias rs='rem_show'
alias rg='ranger'
alias go='gnome-open'
alias ac='autoreconf'
alias gf='gfortran -fopenmp ' 
alias ud='./omega_QCD.opt -scatter "u d -> u d" '
alias ll='ls -lh'
alias la='ls -lah'
alias le='less'
alias so='source ~/.bashrc'
alias mc='cit "make clean"'
alias ca='cit ant'
alias md='mkdir'
alias rm='rm -v'
alias mv='mv -v'
alias wc3='wine '$wingames'/Warcraft\ III/Frozen\ Throne.exe'
alias dk2='wine '$wingames'/DungeonKeeper2/DKII.exe'
alias sc='cd '$wingames'/Stronghold\ Crusader/; wine Stronghold\ Crusader.exe'
alias ut='wine '$wingames'/UnrealTournament/System/UnrealTournament.exe'
alias briss='java -jar ~/Dropbox/Programs/briss-0.9/briss-0.9.jar'
alias primrun='vblank_mode=0 primusrun'
alias gitt='gitm ".."'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias rgrep='grep -r'
alias ddiff='diff -x *.swp -q'
alias du_dirs='du {*,.git} -sh | sort -h'
alias du_subdirs='du -h | sort -h'
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get dist-upgrade'
alias all_cpu_info='lscpu; grep -i "model name" /proc/cpuinfo | uniq'
#alias find_most_used='tr ' ' '\ ' | tr '[:upper:]' '[:lower:]' |  tr -d '[:punct:]' | grep -v '[^a-z]' | sort | uniq -c | sort -rn |head -n 20'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 

function running_threads () {
  ps -eLF | grep ^baduser | wc -l
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
  git add -A
  git commit -m "$1"
  git push
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
  evince "$1" > /dev/null &
}

function print_vim () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ~/"$1".pdf
}

function ff () {
  find -iname "$1"
}

function fa () {
  find -iname "*$1*"
}

function backup_bcn () {
  bcn=~/Dropbox/git_bcn_scripts
  cp ~/.*rc $bcn/
  cp ~/.gitconfig $bcn/.gitconfig
  cp ~/.vim/* $bcn/.vim/ -r
  # Other things to backup in config?
  cp ~/.config/terminator/* $bcn/.config/terminator/
  cp ~/texmf/tex/latex/bcn_* $bcn/latex/
  cp ~/.ssh/config $bcn/.ssh/config
  cp ~/.ssh/id_rsa.pub $bcn/.ssh/id_rsa.pub
  cp ~/.matplotlib/matplotlibrc $bcn/.matplotlib/matplotlibrc
  sudo cp /etc/fstab ~/Dropbox/scripts/
}

function restore_bcn () {
  bcn=.
  md ~/.vim
  md ~/.vim/ftplugin
  md ~/.vim/colors
  md ~/.ssh
  md ~/.matplotlib
  md ~/.config
  md ~/.config/terminator
  cp $bcn/.*rc                     ~/
  cp $bcn/.gitconfig               ~/.gitconfig
  cp $bcn/.vim/*                   ~/.vim/ -r
  cp $bcn/.config/terminator/*     ~/.config/terminator/ -r
  cp $bcn/texmf/tex/latex/*        ~/texmf/tex/latex/ -r
  cp $bcn/.ssh/*                   ~/.ssh/ -r
  cp $bcn/.matplotlib/matplotlibrc ~/.matplotlib/matplotlibrc
}

function most_used_words () {
  cat $1 | tr ' ' '\\ ' | tr '\[:upper:\]' '\[:lower:\]' |  tr -d
  '\[:punct:\]' | grep -v '\[^a-z\]' |  sort | uniq -c | sort -rn | head -n 20
}

function shrink_pdf () {
fname=$(basename $1)
fbname=${fname%.*}
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/ebook -sOutputFile=$fbname-small.pdf $1
}

c_black=`tput setaf 0`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_yellow=`tput setaf 3`
c_blue=`tput setaf 4`
c_pink=`tput setaf 5`
c_cyan=`tput setaf 6`
c_gray=`tput setaf 7`
c_white=`tput setaf 9`
 
parse_git_branch () {
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
    return 0
  fi
  echo -e ${gitver::2}
}

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
    color="--"
  fi
  echo -ne $color
}

PS1='[\[$(branch_color)\]$(parse_git_branch)\[${c_white}\]] [${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]] \[\033[01;34m\]\w\[\033[00m\] '

PS1_old='[\[$(branch_color)\]$(parse_git_branch)\[${c_white}\]] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\] \w \[\033[00m\]: '

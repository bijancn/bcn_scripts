# ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN BASHRC ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# bcn:              bijan@chokoufe.com
# Recent versions:  https://github.com/bijanc/bcn_scripts
# Last Change:      2013 May 10
#
# Put me in:
#             for Unix and OS/2:     ~/.bashrc
# 
# bash configuration file. Maintained since 2012.

export CUBACORES=1
export PATH=$PATH:$HOME/ocaml/bin
source /opt/intel/composer_xe_2013.3.163/bin/compilervars.sh intel64
ip=bchokoufe@wtpp121.physik.uni-wuerzburg.de
ohl_ip=bchokoufe@wtpp125.physik.uni-wuerzburg.de
nick_ip=bchokoufe@132.187.196.121
public_ip=bchokoufe@wtpp004.physik.uni-wuerzburg.de
clustr_ip=bchokoufe@wtpp020.physik.uni-wuerzburg.de
home_ip=192.168.2.152
ocaml_url=http://caml.inria.fr/pub/distrib/ocaml-4.00/ocaml-4.00.1.tar.gz
omega_url=http://www.hepforge.org/archive/whizard/omega-2.1.1.tar.gz
wingames='/media/bijan/1CD00B3ED00B1DA0/Documents\ and\ Settings/Bijan/Desktop'
bcn=$HOME/Dropbox/Programs/bcn_scripts

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ JAVA CLASSPATH ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
java_path=$HOME/Dropbox/Codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ SHORTHANDS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
alias t='/usr/bin/time'
alias m='cd .. ; cm; cd bin'
alias gf='gfortran -fopenmp ' 
alias ud='./omega_QCD.opt -scatter "u d -> u d" '
alias ll='ls -lh'
alias la='ls -lah'
alias so='source ~/.bashrc'
alias cm='cit make'
alias mc='cit "make clean"'
alias ca='cit ant'
alias md='mkdir'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias wc3='wine /media/bijan/1CD00B3ED00B1DA0/Documents\ and\ Settings/Bijan/Desktop/Warcraft\ III\ phil\ aktuell/Frozen\ Throne.exe'
alias briss='java -jar ~/Dropbox/Programs/briss-0.9/briss-0.9.jar'
alias gitt='gitm ".."'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias rgrep='grep -r'
alias ddiff='diff -x *.swp -q'
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get dist-upgrade'
alias du_dirs='du {*,.git} -sh | sort -h'
alias du_subdirs='du -h | sort -h'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 

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

function sshwue () {
  ssh -X $ip
}

function sshhome () {
  ssh -X home_ip
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
  bcn=~/Dropbox/Programs/bcn_scripts
  cp ~/.*rc $bcn
  cp ~/.vim/bcn_* $bcn/.vim/
  cp ~/.vim/ftplugin/* $bcn/.vim/ftplugin/
  cp ~/.vim/colors/bcn_* $bcn/.vim/colors/
  cp ~/.ssh/config $bcn/.ssh/config
  cp ~/Dropbox/Codes/LaTeX/localtex/bcn_* $bcn/latex/
}

function restore_bcn () {
  bcn=.
  md ~/.vim/ftplugin
  md ~/.vim/colors
  md ~/.ssh
  cp $bcn/.*rc             ~/
  cp $bcn/.vim/*           ~/.vim/
  cp $bcn/.vim/ftplugin/*  ~/.vim/ftplugin/
  cp $bcn/.vim/colors/*    ~/.vim/colors/
  cp $bcn/.ssh/config      ~/.ssh/config
}

#alias vim="vim --servername SERVER"
#alias java='java -cp ~/Ubuntu\ One/Codes/Java/mysql-connector-java-5.1.20-bin.jar:.'
#alias mountwin='sudo mount /dev/sda2 /media/win7/'
#alias wlanswitcher='sh ~/Dropbox/Programs/wlanscript.sh'

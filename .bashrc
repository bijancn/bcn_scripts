# ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN BASHRC ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# bcn:              bijan@chokoufe.com
# Recent versions:  https://github.com/bijanc/bcn_scripts
# Last Change:      2013 Jul 27
#
# Put me in:
#             for Linux:     ~/.bashrc
# 
# bash configuration file. Maintained since 2012.

eval `dircolors $HOME/.dir_colorsrc`
source /opt/intel/composer_xe_2013.3.163/bin/compilervars.sh intel64
export CUBACORES=1
export PATH=$PATH:$HOME/ocaml/bin
wingames='/data/Games'
bcn=$HOME/Dropbox/Programs/bcn_scripts

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ JAVA CLASSPATH ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
java_path=$HOME/Dropbox/Codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ IP's ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
std_usr=bchokoufe
ip=$std_usr@wtpp121.physik.uni-wuerzburg.de
ohl=$std_usr@wtpp125.physik.uni-wuerzburg.de
nick=$std_usr@132.187.196.121
otter=$std_usr@132.187.196.113
public=$std_usr@wtpp004.physik.uni-wuerzburg.de
clustr=$std_usr@wtpp020.physik.uni-wuerzburg.de
hepforge=$std_usr@login.hepforge.org
home_ip=192.168.2.152
url_ocaml=http://caml.inria.fr/pub/distrib/ocaml-4.00/ocaml-4.00.1.tar.gz
url_hep_omega=http://www.hepforge.org/archive/whizard/omega-2.1.1.tar.gz

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ SHORTHANDS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
alias t='/usr/bin/time'
alias c='./configure'
alias m='cm'
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
alias cm='cit make'
alias mc='cit "make clean"'
alias ca='cit ant'
alias md='mkdir'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias wc3='wine '$wingames'/Warcraft\ III/Frozen\ Throne.exe'
alias dk2='wine '$wingames'/DungeonKeeper2/DKII.exe'
alias sc='cd '$wingames'/Stronghold\ Crusader/; wine Stronghold\ Crusader.exe'
alias ut='wine '$wingames'/UnrealTournament/System/UnrealTournament.exe'
alias briss='java -jar ~/Dropbox/Programs/briss-0.9/briss-0.9.jar'
alias gitt='gitm ".."'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias rgrep='grep -r'
alias ddiff='diff -x *.swp -q'
alias du_dirs='du {*,.git} -sh | sort -h'
alias du_subdirs='du -h | sort -h'
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get dist-upgrade'
#alias find_most_used='tr ' ' '\ ' | tr '[:upper:]' '[:lower:]' |  tr -d '[:punct:]' | grep -v '[^a-z]' | sort | uniq -c | sort -rn |head -n 20'

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
  ssh -X $home_ip
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
  cp ~/.vim/* $bcn/.vim/ -r
  # Other things to backup in config?
  cp ~/.config/terminator/* $bcn/.config/terminator/
  cp ~/Dropbox/codes/LaTeX/localtex/bcn_* $bcn/latex/
  cp ~/.ssh/config $bcn/.ssh/config
  cp ~/.ssh/id_rsa.pub $bcn/.ssh/id_rsa.pub
  cp ~/.matplotlib/matplotlibrc $bcn/.matplotlib/matplotlibrc
  sudo cp /etc/fstab ~/Dropbox/scripts/
}

function restore_bcn () {
  bcn=.
  md ~/.vim/ftplugin
  md ~/.vim/colors
  md ~/.ssh
  md ~/.matplotlib
  md ~/.config/terminator
  cp $bcn/.*rc                     ~/
  cp $bcn/.vim/*                   ~/.vim/ -r
  cp $bcn/.config/terminator/*     ~/.config/terminator/
  cp $bcn/.ssh/*                    ~/.ssh/
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
#alias vim="vim --servername SERVER"
#alias java='java -cp ~/Ubuntu\ One/Codes/Java/mysql-connector-java-5.1.20-bin.jar:.'
#alias mountwin='sudo mount /dev/sda2 /media/win7/'
#alias wlanswitcher='sh ~/Dropbox/Programs/wlanscript.sh'

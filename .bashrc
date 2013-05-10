# ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN BASHRC ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# bcn:              bijan@chokoufe.com
# Recent versions:  https://github.com/bijanc/bcn_scripts
# Last Change:      2013 Mar 31
#
# Put me in:
#             for Unix and OS/2:     ~/.bashrc
# 
# bash configuration file. Maintained since 2012.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ JAVA CLASSPATH ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
java_path=/home/bijan/Dropbox/Codes/java
am_tp=$java_path/Amazon-MWS/third-party
am_bu=$java_path/Amazon-MWS/build/classes/com/amazonservices/mws
am_pro=$am_bu/products
export CLASSPATH=$CLASSPATH:$am_tp/*:$am_pro/*:$am_pro/samples/*
export CLASSPATH=$CLASSPATH:$am_pro/model:$am_pro/mock/*

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ SHORTHANDS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
alias gf='gfortran -fopenmp ' 
alias m='cd .. ; cm; cd bin'
alias ud='./omega_QCD.opt -scatter "u d -> u d" '
alias ll='ls -lh'
alias la='ls -lah'
alias so='source ~/.bashrc'
alias gitt='gitm ".."'
alias cm='cit make'
alias ca='cit ant'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias rgrep='grep -r'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias ddiff='diff -x *.swp -q'
alias t='/usr/bin/time'
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get dist-upgrade'
alias du_dirs='du {*,.git} -sh | sort -h'
alias du_subdirs='du -h | sort -h'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~ FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
function gitm () {
  git add -A
  git commit -m "$1"
  git push
}

# See BCN COLORITRC for customizing colors in output
function cit () {
  $1 2>&1 | colorit
}

function rem_print_1s () {
  scp "$1" bchokoufe@132.187.196.121:~/temp.pdf
  ssh bchokoufe@132.187.196.121 "lp -d lp-tp2 -o media=a4 -o sides=one-sided temp.pdf"
}

function rem_show () {
  scp "$1" bchokoufe@132.187.196.121:~/temp.pdf
  ssh -X bchokoufe@132.187.196.121 "evince ~/temp.pdf"
}

function print_vim () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ~/"$1".pdf
}

function backup_bcn () {
  bcn=~/Dropbox/Programs/bcn_scripts
  cp ~/.*rc $bcn
  cp ~/.vim/bcn_* $bcn/.vim/
  cp ~/.vim/ftplugin/* $bcn/.vim/ftplugin/
  cp ~/.vim/colors/bcn_* $bcn/.vim/colors/
  cp ~/Dropbox/Codes/LaTeX/localtex/bcn_* $bcn/latex/
}

function restore_this_bcn () {
  bcn=.
  mkdir ~/.vim/ftplugin/
  mkdir ~/.vim/colors/
  cp $bcn/.*rc             ~/
  cp $bcn/.vim/*           ~/.vim/
  cp $bcn/.vim/ftplugin/*  ~/.vim/ftplugin/
  cp $bcn/.vim/colors/*    ~/.vim/colors/
}

#alias vim="vim --servername SERVER"
#alias java='java -cp ~/Ubuntu\ One/Codes/Java/mysql-connector-java-5.1.20-bin.jar:.'
#alias mountwin='sudo mount /dev/sda2 /media/win7/'
#alias wlanswitcher='sh ~/Dropbox/Programs/wlanscript.sh'

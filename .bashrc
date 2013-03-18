# ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN BASHRC ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# bcn:              bijan@chokoufe.com
# Recent versions:  https://github.com/bijanc/bcn_scripts
# Last Change:      2013 Mar 18
#
# Put me in:
#             for Unix and OS/2:     ~/.bashrc
# 
# bash configuration file. Maintained since 2012.

alias wlanswitcher='sh ~/Dropbox/Programme/wlanscript.sh'

alias gf='gfortran -fopenmp ' 
alias m='cd .. ; make 2>&1 | colorit; cd bin'
alias ud='./omega_QCD.opt -scatter "u d -> u d" '
alias ll='ls -lh'
alias la='ls -lah'
alias so='source ~/.bashrc'
alias gitt='git add -A; git commit -m ".."; git push'
alias cm='cit make'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias rgrep='grep -r'
alias update='sudo apt-get update; sudo apt-get upgrade; sudo apt-get dist-upgrade'

function gitm () {
  git add . 
  git commit -m "$1"
  git push
}

# See BCN COLORITRC
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

function print_file () {
  vim -c 'hardcopy > ~/output.ps' -c quit "$1"
  ps2pdf ~/output.ps ~/"$1".pdf
}

function backup_bcn () {
  bcn=~/Dropbox/Programs/bcn_scripts
  cp ~/.*rc $bcn
  cp ~/.vim/bcn_* $bcn
  cp ~/.vim/colors/bcn_* $bcn/colors
}

#alias vim="vim --servername SERVER"
#alias java='java -cp ~/Ubuntu\ One/Codes/Java/mysql-connector-java-5.1.20-bin.jar:.'
#alias mountwin='sudo mount /dev/sda2 /media/win7/'

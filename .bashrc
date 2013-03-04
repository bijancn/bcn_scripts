alias vim="vim --servername SERVER"
alias java='java -cp ~/Ubuntu\ One/Codes/Java/mysql-connector-java-5.1.20-bin.jar:.'
alias mountwin='sudo mount /dev/sda2 /media/win7/'
alias wlanswitcher='sh ~/Dropbox/Programme/wlanscript.sh'

alias gf='gfortran -fopenmp ' 
alias m='cd .. ; make 2>&1 | colorit; cd bin'
alias ud='./omega_QCD.opt -scatter "u d -> u d" '

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

# Possibilities to colorize output: ~/bin/color (changeable script) or use
# colorit configurable over ~/.coloritrc . Usage:
# pdflatex file.tex | color red '^Package'
# ocamlopt file.ml 2>&1 | colorit

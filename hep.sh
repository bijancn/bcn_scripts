
function load-whizard-gfortran() {
  export whizard_install=/nfs/theoc/data2/bcho/sl6/whizard_install_gfortran
  if [ -d "$whizard_install" ]; then
     prepend-all-paths $whizard_install
  fi
}

function load-whizard-ifort() {
  export whizard_install=/nfs/theoc/data2/bcho/sl6/whizard_install_ifort
  if [ -d "$whizard_install" ]; then
     prepend-all-paths $whizard_install
  fi
}

pythia-configure(){
  packages='--with-hepmc2=$install --with-lhapdf6=$install --with-fastjet3=$install'
  ./configure --prefix=$install $packages
}
pythia-configure-desy(){
  packages='--with-hepmc2=$hep_install --with-lhapdf6=$hep_install --with-fastjet3=$hep_install'
  ./configure --prefix=$install $packages
}

checkout-openloops(){
  svn checkout http://openloops.hepforge.org/svn/OpenLoops/branches/public ./OpenLoops
  cd OpenLoops
  printf '[OpenLoops]\nprocess_repositories=public, whizard\ncompile_extra=1' > openloops.cfg
  ./scons
  ./openloops libinstall ppzj ppzjj ppll ppllj pplljj pplljjj eett eehtt eevvjj ee_tt_wwjj tbw
  cd examples
  ../scons
  ./OL_fortran
}

checkout-openloops-ifort(){
  svn checkout http://openloops.hepforge.org/svn/OpenLoops/branches/public ./OpenLoops_ifort
  cd OpenLoops_ifort
  printf '[OpenLoops]\nprocess_repositories=public, whizard\ncompile_extra=1\nfortran_compiler=ifort' > openloops.cfg
  ./scons
  ./openloops libinstall ppzj ppzjj ppll ppllj pplljj pplljjj eett eehtt eevvjj ee_tt_wwjj tbw
  cd examples
  ../scons
  ./OL_fortran
}

checkout-lcio(){
  svn co svn://svn.freehep.org/lcio/trunk lcio
  cd lcio
  mkidr build
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=../../install ..
  make -j10
  make install
}

  if [ -n "$hep" ]; then
    export hep_install=$hep/install
    prepend-libpath $hep/OpenLoops
    prepend-pure-libpath $hep/recola-collier-1.2/COLLIER-1.1
    prepend-pure-libpath $hep/recola-collier-1.2/recola-1.2
    prepend-all-paths $hep/gosam/local
    prepend-all-paths $hep_install
    add-pythonpath $hep_install/lib/python
    add-pythonpath $hep_install/lib/python2.7/site-packages
    export CPATH=$hep_install/include:$CPATH
    export LATEXINPUTS=${HOME}/texmf:$hep_install/share/texmf/tex/latex/misc:$LATEXINPUTS
    export TEXINPUTS=${HOME}/texmf:$hep_install/share/texmf/tex/latex/misc:$TEXINPUTS
    export LCIO=$hep_install
    export CXX=$hep_install/bin/c++
  fi

function get-inspire-bibtex () {
  curl -s "https://inspirehep.net/search?p=$1&of=hx&em=B&sf=year&so=d" | sed '/div>\|<div\|pre>/d'
}

function replace-inspire () {
  sed -i "s,$1,${2}," *.tex *.bib
}

function get-arxiv-number () {
  get-inspire-bibtex $1 | grep eprint | sed 's/.*= "//' | sed 's/",.*//'
}

function replace-inspire-extra () {
  result=`get-arxiv-number $1`
  if [ ${#result} -ge 1 ] ; then
    echo "Replacing $1"
    sed -i "s,$1,${result}," *.tex *.bib
  fi
}
alias rin=replace-inspire-extra

function get-articles-and-proceedings () {
  grep '@article\|@inproceedings' $1 | sed 's/@article{//' | sed 's/@inproceedings{//' | sed 's/,//'
}

function get-defined-acronyms () {
  grep '  \\acro' main.tex | sed 's/  \\acro{//' | sed 's/}{.*//'
}

function check-if-used () {
  if grep -q '\\ac{'$1 *.tex; then
    echo "used"
  else
    echo "not used: $1"
  fi
}

function check-if-defined-acronyms-are-used () {
  for i in `get-defined-acronyms` ; do check-if-used $i ; done
}

#===========#
#  whizard  #
#===========#
whiz_dir1=/scratch/bcho/trunk/
whiz_dir2=$HOME/trunk/
whiz_dir3=
if [ -d $whiz_dir1 ]; then
  export whiz_soft=$whiz_dir1
elif [ -d $whiz_dir2 ]; then
  export whiz_soft=$whiz_dir2
elif [ -d $whiz_dir3 ]; then
  export whiz_soft=$whiz_dir3
fi
trnk() { cd $whiz_soft/ ; }
bui() { cd $whiz_soft/_build ; }

alias wsrc='op '$whiz_soft/_install/gfortran-dist/share/doc/whizard/whizard.pdf
alias vsrc='op '$whiz_soft/_install/gfortran-dist/share/doc/vamp/vamp.pdf
alias osrc='op '$whiz_soft/_install/gfortran-dist/share/doc/omega/omega.pdf
alias csrc='op '$whiz_soft/_install/gfortran-dist/share/doc/circe2/circe2.pdf
alias wman='op '$whiz_soft/_install/gfortran-dist/share/doc/whizard/manual.pdf
alias gman='op '$whiz_soft/_install/gfortran-dist/share/doc/whizard/gamelan_manual.pdf
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
function update-from-Max () {
  cd ~/threshold
  svn up
  cd Data/ValidationForPaper
  cp MpoleFixed/* ~/run-scripts/threshold_validation/scan-results/
  cd ~/run-scripts/threshold_validation/scan-results/
  rm Max*.dat
  python ~/run-scripts/Mathematica-importer.py
  rm Max*.txt
  cd ~/threshold/Data/ValidationForPaper
  cp MpoleFromM1S/* ~/run-scripts/threshold_validation_mpoleUnfixed/scan-results/
  cd ~/run-scripts/threshold_validation_mpoleUnfixed/scan-results/
  rm Max*.dat
  python ~/run-scripts/Mathematica-importer.py
  rm Max*.txt
}

function gosam-helicities () {
  for i in $(eval echo "helicity{$1..$2}") ; do echo $i ; cd $i ; make ; cd .. ; done
}


#==============================================================================#
#                                SHOW-COMMANDS                                 #
#==============================================================================#
function show-wlan-channels () {
  sudo iwlist wlan0 scan | grep Frequency | sort | uniq -c | sort -n
  # doesn't work anymore?
}

alias show-distro="lsb_release -a"

alias show-kernel="uname -r"

alias show-parallel-jobs="echo $parallel_jobs"

alias show-computer-list="vim /afs/desy.de/group/theorie/theopcs/Ueberblick.txt"

function find-ref-dir () {
  pwd=`pwd`
  ref_dir=../../../../share/tests/$(basename $pwd)
  if test -f $ref_dir/ref-output/$1.ref; then
    echo "$ref_dir/ref-output"
    return
  fi
  grep --quiet 'FC_PRECISION = double' Makefile
  if test "$?" = "0" -a -f $ref_dir/ref-output-double/$1.ref; then
    echo "$ref_dir/ref-output-double"
    return
  fi
  grep --quiet 'FC_PRECISION = extended' Makefile
  if test "$?" = "0" -a -f $ref_dir/ref-output-ext/$1.ref; then
    echo "$ref_dir/ref-output-ext"
    return
  fi
  grep --quiet 'FC_PRECISION = quadruple' Makefile
  if test "$?" = "0" -a -f $ref_dir/ref-output-quad/$1.ref; then
    echo "$ref_dir/ref-output-quad"
    return
  elif test -f $ref_dir/ref-output-prec/$1.ref; then
    echo "$ref_dir/ref-output-prec"
    return
  fi
}

function show-this-diff () {
  $difftool $1.log `find-ref-dir $1`/$1.ref
}

function use-this-as-ref () {
  cp $1.log `find-ref-dir $1`/$1.ref
}

function use-all-this-as-ref () {
  for i in `grep "^FAIL: .*.run" test-suite.log | sed "s/FAIL: //" | sed "s/.run//"`; do
    use-this-as-ref $i
  done
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

function show-failed-tests () {
  find -name 'test-suite.log' | xargs grep -v 'XFAIL' | grep -v ' 0' | grep 'FAIL'
}

function show-test-results () {
  for i in */; do
    if test -f $i/src/whizard; then
      printf "$BGreen %40s%20s:\tCHECK$NC\n" "$i" "whizard main"
    else
      printf "$BPurple %40s%20s:\tMissing$NC\n" "$i" "whizard main"
    fi
    if test -f $i/src/whizard_ut; then
      printf "$BGreen %40s%20s:\tCHECK$NC\n" "$i" "whizard_ut main"
    else
      printf "$BPurple %40s%20s:\tMissing$NC\n" "$i" "whizard_ut main"
    fi
    for j in unit functional; do
      if test -f $i/tests/${j}_tests/test-suite.log; then
        grep --quiet 'FAIL:  0' $i/tests/${j}_tests/test-suite.log
        if test "$?" = "0"; then
          printf "$BGreen %40s%20s:\tCHECK$NC\n" "$i" "$j"
        else
          printf "$BRed %40s%20s:\tFAIL$NC\n" "$i" "$j"
        fi
      else
        printf "$BBlue %40s%20s:\tMissing$NC\n" "$i" "$j"
      fi
    done
    case "$i" in
    *dist*)
      if test -f $i/whizard-`cat $i/VERSION | awk '{print $2}'`.tar.gz; then
        printf "$BGreen %40s%20s:\tCHECK$NC\n" "$i" "tarball"
      else
        printf "$BPurple %40s%20s:\tMissing$NC\n" "$i" "tarball"
      fi ;;
    esac
  done
}

function show-our-lines-of-code () {
  wc -l */*.nw | sort -n
}

function show-nr-of-own-threads () {
  ps -eLF | grep ^$USER | wc -l
}

function show-nr-of-files () {
  for i in */ ; do echo "$i : `find $i  -type f | wc -l`" ; done
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


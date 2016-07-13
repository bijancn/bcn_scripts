#! /bin/sh
########################################################################

prefix=`pwd`

build_dir=$prefix/build
install_dir=$prefix/install
########################################################################

########################################################################
# The locations of the sofware packages
########################################################################

# professor
url_professor=http://professor.hepforge.org/svn/tags/professor-1.4.0

# Pip
url_pip=https://bootstrap.pypa.io/get-pip.py

# pyminuit
url_pyminuit=https://github.com/jpivarski/pyminuit.git
url_minuit=seal.web.cern.ch/seal/minuit/releases/Minuit-1_7_9.tar.gz

# python
url_python=https://www.python.org/ftp/python/2.7.12/Python-2.7.12rc1.tgz

########################################################################
# Heuristics for the optimal number of jobs
########################################################################
parallel_jobs=
if test -r /proc/cpuinfo; then
  n=`grep -c '^processor' /proc/cpuinfo`
  if test $n -gt 1; then
    parallel_jobs="-j `expr \( 3 \* $n \) / 2`"
  fi
fi

########################################################################

download () {
  url=$1
  name=`basename $1`
  test -r $name || wget $url
  test -r $name || curl $url -o $name
  test -r $name || exit 2
}

strip_tgz () {
  name=$1
  case $name in
    .tgz) basename $name .tgz;;
    *.tar.gz) basename $name .tar.gz;;
    *.tar.bz2) basename $name .tar.bz2;;
    *.zip) basename $name .zip;;
    *.git) basename $name .git;;
  esac
}

untar () {
  name=$1
  dirname=`strip_tgz $name`
  if test ! -d $dirname; then
    case $name in
      *.gz|*.tgz) zcat $name;;
      *.bz2) bzcat $name;;
    esac | tar xf -
  fi
}

build_python () {
  python_tar=`basename $url_python`
  download $url_python
  untar $python_tar
  cd $build_dir/$(strip_tgz $python_tar)
  ./configure --prefix=$install_dir
  make $parallel_jobs
  make install $parallel_jobs
  cd ..
}

build_pip () {
  pip_name=`basename $url_pip`
  download $url_pip
  # This works when you have installed python locally without su rights
  # or when you have python installed system-wide and have su rights when
  # executing this script
  # For system-wide installed python but no su rights, consider adding --user
  # and add export PATH=~/.local/bin:$PATH to the .bashrc
  python $pip_name
  pip install --upgrade pip
}

build_wx () {
  echo "dummy: could be added for interactive use"
}

build_python_packages () {
  echo '>> Installing cython, scipy, numpy and matplotlib if they are not found.'
  echo '>> This might take some time...'
  pip install cython --upgrade
  pip install numpy --upgrade
  pip install scipy --upgrade
  pip install matplotlib --upgrade
}

build_minuit () {
  minuit_tar=`basename $url_minuit`
  download $url_minuit
  untar $minuit_tar
  cd $build_dir/$(strip_tgz $minuit_tar)
  # Fixes a problem occuring on some platforms, see
  # https://github.com/jpivarski/pyminuit/issues/8
  # Shouldn't hurt to apply it everywhere
  sed -i 's/#include <algorithm>/#include <algorithm>\n#include <cstdio>/' \
    src/MnUserTransformation.cpp
  ./configure --prefix=$install_dir --enable-shared
  make $parallel_jobs
  make install $parallel_jobs
  cd ..
}

build_pyminuit () {
  pyminuit_git=`basename $url_pyminuit`
  pyminuit_dir=`strip_tgz $pyminuit_git`
  if ! test -d $pyminuit_dir; then
    git clone $url_pyminuit
  fi
  cd $build_dir/$pyminuit_dir
  python setup.py install \
    --with-minuit=$build_dir/$(strip_tgz `basename $url_minuit`) \
    --home=$install_dir
  cd ..
}

build_professor () {
  professor_dir=`basename $url_professor`
  svn checkout $url_professor
  svn export $professor_dir/professor $install_dir/lib/python/professor
  svn export $professor_dir/bin $professor_dir/scripts
  mv $professor_dir/scripts/* $install_dir/bin/
  rm -r $professor_dir/scripts
  svn export $professor_dir/contrib $professor_dir/scripts
  mv $professor_dir/scripts/* $install_dir/bin/
  rm -r $professor_dir/scripts
}

mkdir -p $build_dir
cd $build_dir || exit 2

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">> this is needed in .bashrc for future use"
trap 'echo ">> $BASH_COMMAND"' DEBUG
export PATH=$install_dir/bin:$PATH
export LD_LIBRARY_PATH=$install_dir/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$install_dir/lib/python:$PYTHONPATH
echo ">> with install_dir=$install_dir "

build_python
build_pip
#build_python_packages
#build_minuit
#build_pyminuit
#build_professor

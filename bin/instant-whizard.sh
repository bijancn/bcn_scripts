#! /bin/sh

prefix=`pwd`

########################################################################
build_dir=$prefix/build
install_dir=$prefix/install
bin_dir=$install_dir/bin
########################################################################

########################################################################
# Try to work around a problem in Debian 7.0 (Wheezy)
########################################################################
if test -d /usr/lib/x86_64-linux-gnu; then
  LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu
  export LD_LIBRARY_PATH
  LIBRARY_PATH=/usr/lib/x86_64-linux-gnu
  export LIBRARY_PATH
  C_INCLUDE_PATH=/usr/include/x86_64-linux-gnu
  export C_INCLUDE_PATH
  CPLUS_INCLUDE_PATH=/usr/include/x86_64-linux-gnu
  export CPLUS_INCLUDE_PATH
fi

########################################################################

PATH=$install_dir/bin:$PATH
export PATH
LD_LIBRARY_PATH=$install_dir/lib:$install_dir/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

########################################################################
# The locations of the sofware packages
########################################################################

# Autotools
url_make=http://ftp.gnu.org/gnu/make/make-4.0.tar.gz
url_m4=http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz
url_autoconf=http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
url_automake=http://ftp.gnu.org/gnu/automake/automake-1.14.1.tar.gz
url_libtool=http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz

# Noweb
url_noweb=ftp://www.eecs.harvard.edu/pub/nr/noweb.tgz

# GCC
url_gcc=ftp://ftp.mpi-sb.mpg.de/pub/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-4.7.4/gcc-4.7.4.tar.gz
#url_gcc=ftp://ftp.mpi-sb.mpg.de/pub/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-4.9.4/gcc-4.9.4.tar.gz
#url_gcc=ftp://ftp.mpi-sb.mpg.de/pub/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-6.1/gcc-6.1.tar.gz
#url_gcc=ftp://ftp.mpi-sb.mpg.de/pub/gnu/mirror/gcc.gnu.org/pub/gcc/releases/gcc-6.2.0/gcc-6.2.0.tar.gz

# O'Caml
url_ocaml=http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.2.tar.gz

# Whizard
url_whizard=http://www.hepforge.org/archive/whizard/whizard-2.2.2.tar.gz
url_hepmc=http://lcgapp.cern.ch/project/simu/HepMC/download/HepMC-2.06.09.tar.gz
url_lhapdf=http://www.hepforge.org/archive/lhapdf/lhapdf-6.1.4.tar.gz

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
parallel_jobs="-j1"

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
    *.tgz) basename $name .tgz;;
    *.tar.gz) basename $name .tar.gz;;
    *.tar.bz2) basename $name .tar.bz2;;
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

configure_make_install () {
  name=$1
  dirname=`strip_tgz $name`
  if test ! -r $dirname.stamp; then
    ( cd $dirname || exit 2
      ./configure --prefix=$install_dir  
      make $parallel_jobs
      make install )
  fi
  touch $dirname.stamp
}

########################################################################

build_generic () {
  url=$1
  name=`basename $url`
  download $url
  untar $name
  configure_make_install $name
}

build_gcc () {
  gcc_url=$1
  gcc_name=`basename $gcc_url`
  gcc_dirname=`strip_tgz $gcc_name`
  download $gcc_url
  untar $gcc_name
  ( cd $gcc_dirname || exit 2
    sh contrib/download_prerequisites )
  if test ! -r $gcc_dirname.stamp; then
    mkdir $gcc_dirname.build
    ( cd $gcc_dirname.build || exit 2
      # gcc does not like flags like -std=c++11
      CXXFLAGS='' \
        ../$gcc_dirname/configure --prefix=$install_dir \
        --enable-languages='c,c++,fortran' \
        --disable-multilib
      make bootstrap-lean $parallel_jobs
      make install )
  fi
  touch $gcc_dirname.stamp
}

build_ocaml () {
  url=$1
  name=`basename $url`
  dirname=`strip_tgz $name`
  download $url
  untar $name
  if test ! -r $dirname.stamp; then
    ( cd $dirname || exit 2
      ./configure -prefix $install_dir
### The OCaml Makefiles are not parallel-safe
      make world.opt
      make install )
  fi
  touch $dirname.stamp
}

build_noweb () {
  url=$1
  name=`basename $url`
  dirname=`strip_tgz $name`
  download $url
  untar $name
  if test ! -r $dirname.stamp; then
    ( cd $dirname-2.11b/src || exit 2
### Edit the Makefile and then
###   make install
      )
  fi
  touch $dirname.stamp
}

build_hepmc () {
  url=$1
  name=`basename $url`
  dirname=`strip_tgz $name`
  download $url
  untar $name
  if test ! -r $dirname.stamp; then
    ( cd $dirname || exit 2
      ./configure --prefix=$install_dir --with-momentum=GEV --with-length=MM
      make $parallel_jobs
      make check
      make install )
  fi
  touch $dirname.stamp
}

build_whizard () {
  url=$1
  name=`basename $url`
  dirname=`strip_tgz $name`
  cp ../$name .
  download $url
  untar $name
  if test ! -r $dirname.stamp; then
    mkdir $dirname.build
    ( cd $dirname.build || exit 2
      HEPMC_DIR=$install_dir
      export HEPMC_DIR
      LHAPDF_DIR=$install_dir
      export LHAPDF_DIR
      ../$dirname/configure FC=$bin_dir/gfortran F77=$bin_dir/gfortran  --enable-fc-openmp --prefix=$install_dir 
      make $parallel_jobs
      make check
      make install )
  fi
  touch $dirname.stamp
}

write_script () {
  name=$1
  date="`date`"
  myself="$0"
  rm -f $name
cat <<EOF >$name
#! /bin/sh
########################################################################
# WHIZARD startup script,
#    created on $date
#    by $myself
########################################################################
PATH=$PATH
export PATH
LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
LIBRARY_PATH=$LIBRARY_PATH
export LIBRARY_PATH
########################################################################
exec $install_dir/bin/whizard "\$@"
EOF
  chmod 555 $name
}

########################################################################

mkdir -p $build_dir
cd $build_dir || exit 2

#build_generic $url_make
#build_generic $url_m4
#build_generic $url_autoconf
#build_generic $url_automake
#build_generic $url_libtool
build_gcc $url_gcc
#build_noweb $url_noweb
#build_ocaml $url_ocaml
#build_hepmc $url_hepmc
#build_generic $url_lhapdf
#$bin_dir/lhapdf-getdata --dest=`$bin_dir/lhapdf-config --pdfsets-path` \
    #cteq61.LHpdf cteq6ll.LHpdf cteq5l.LHgrid GSG961.LHgrid
#build_whizard $url_whizard

#write_script $bin_dir/whizard.sh

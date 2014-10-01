if [ -d $HOME/trunk ]; then
  whiz="$HOME/trunk"
else
  whiz=`pwd`
fi
echo "Base dir is $whiz"

if [ $# -lt 3 ]; then
  echo 'Usage: build_tool.sh build n k l'
  echo '- build = a -> all builds = def doc debug ifort'
  echo '- build = def -> default compiler and flags'
  echo '- build = debug -> gfortran with DEBUG flags'
  echo '- build = doc -> default compiler, producing documentation '
  echo '- build = gfomegaXX -> gfortran (only omega)'
  echo '- build = ifomegaXX-> ifort (only omega)'
  echo '- XX = openmp -> with OpenMP support'
  echo '- XX = O[0-3] -> Optimization level'
  echo '- n = 0 -> Dont configure'
  echo '- n = 1 -> configure '
  echo '- n = 2 -> autoreconf, configure '
  echo '- k = 0 -> Dont make'
  echo '- k = 1 -> make'
  echo '- l = 0 -> dont test'
  echo '- l = 1 -> perform make check'
  exit
fi
if [ $1 == 'a'  ]; then
  builds='def debug doc'
else
  if [ $1 == 'allomegas' ]; then
    builds='ifomegaO0 gfomegaO0 ifomegaO1 gfomegaO1 ifomegaO2 gfomegaO2 ifomegaO3 gfomegaO3'
  else
    builds=$1
  fi
fi
conf=$2
make=$3
check=$4
echo "Building $builds, confing $conf, making $make and checking $check"

if [ -d $whiz ]; then
  cd $whiz
else
  echo "Source directory $whiz doesn't exist!"
  exit
fi
mkdir build
if [ $conf -eq 2 ]; then
  echo 'Autoreconfing...'
  autoreconf
  echo "========= AUTOCONFIGURE IS DONE ========="
fi
cd build
for b in $builds; do
  mkdir $b
  cd $b
  if (($conf > 0)); then
    echo "Configuring $b"
    case $b in
      doc)
        $whiz/configure --prefix=$whiz/install/$b \
          --enable-distribution > /dev/null &
        ;;

      debug)
        $whiz/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS="$DEBUG" > /dev/null &
        ;;

      def)
        $whiz/configure --prefix=$whiz/install/$b > /dev/null &
        ;;

      ifomegaO0)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O0 \
          > /dev/null &
        ;;

      gfomegaO0)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O0 > /dev/null &
        ;;

      ifomegaO1)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O1 \
          > /dev/null &
        ;;

      gfomegaO1)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O1 > /dev/null &
        ;;

      ifomegaO2)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O2 \
          > /dev/null &
        ;;

      gfomegaO2)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O2 > /dev/null &
        ;;

      ifomegaO3)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O3 \
          > /dev/null &
        ;;

      gfomegaO3)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O3 > /dev/null &
        ;;

      gfopenmp)
        $whiz/configure --prefix=$whiz/install/$b FC=gfortran FCFLAGS='-O2' \
          --enable-fc-openmp > /dev/null &
        ;;

      gfomegaopenmp)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran FCFLAGS='-O2' \
          --enable-fc-openmp > /dev/null &
        ;;

      ifomegaopenmp)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort \
          FCFLAGS='-O2 -openmp' --enable-fc-openmp > /dev/null &

    esac
  fi
  cd ..
done
wait
echo "========= CONFIGURE IS DONE ========="
for b in $builds; do
  cd $b
  echo "Building and installing $b"
  if [ $make -eq 1 ]; then
    (make -j 2 --silent; make install) &
  fi
  cd ..
done
wait
echo "========= MAKE IS DONE ========="
for b in $builds; do
  cd $b
  echo "Checking $b"
  if [ $check -eq 1 ]; then
    make check &
  fi
  cd ..
done
wait
echo "========= MAKECHECK IS DONE ========="

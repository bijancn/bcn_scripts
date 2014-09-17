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
  echo '- build = gfwhizopenmp -> gfortran with OpenMP support'
  echo '- build = ifomegaopenmp -> ifort with OpenMP support, only omega build'
  echo '- n = 0 -> '
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
echo "Building $builds, confing $conf and checking $check"

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
  echo 'Done! Going to configure.'
fi
cd build
for b in $builds; do
  mkdir $b
  cd $b
  if (($conf > 0)); then
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

      gfwhizopenmp)
        $whiz/configure --prefix=$whiz/install/$b FC=gfortran FCFLAGS='-O2' \
          --enable-fc-openmp > /dev/null &
        ;;

      ifomegaopenmp)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort \
          FCFLAGS='-O2' --enable-fc-openmp > /dev/null &

    esac
  fi
  echo "Building $b"
  if [ $make -eq 1 ]; then
    (make -j 2 --silent; make install) &
  fi
  if [ $check -eq 1 ]; then
    make check
  fi
  cd ..
done
wait
echo 'Done'

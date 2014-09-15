if [ -d $HOME/trunk ]; then
  whiz="$HOME/trunk"
else
  whiz=`pwd`
fi
echo "Base dir is $whiz"

if [ $# -lt 3 ]; then
  echo 'Usage: build_tool.sh build n k'
  echo '- build = a -> all builds = def doc debug ifort'
  echo '- build = def -> default compiler and flags'
  echo '- build = debug -> gfortran with DEBUG flags'
  echo '- build = doc -> default compiler, producing documentation '
  echo '- build = ifomegaO2warns -> ifort -O2, only omega build with more OCaml warnings'
  echo '- build = gfopenmp -> gfortran with OpenMP support'
  echo '- build = ifopenmp -> ifort with OpenMP support, only omega build'
  echo '- n = 0 -> only make'
  echo '- n = 1 -> configure and make'
  echo '- n = 2 -> autoreconf, configure and make'
  echo '- k = 0 -> dont test'
  echo '- k = 1 -> perform make check'
  exit
fi
if [ $1 == 'a'  ]; then
  builds='def debug doc ifort ifomegaO3 gfomegaO3 gfopenmp ifopenmp'
else
  builds=$1
fi
conf=$2
check=$3
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
          --enable-distribution > /dev/null
        ;;

      debug)
        $whiz/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS="$DEBUG" > /dev/null
        ;;

      def)
        $whiz/configure --prefix=$whiz/install/$b > /dev/null
        ;;

      ifomegaO2warns)
        $whiz/omega/configure --prefix=$whiz/install/$b OCAMLFLAGS='-w +a-4' \
          FC=ifort FCFLAGS=-O2 > /dev/null
        ;;

      ifomegaO0)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O0 \
          > /dev/null
        ;;

      gfomegaO0)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O0 > /dev/null
        ;;

      ifomegaO1)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O1 \
          > /dev/null
        ;;

      gfomegaO1)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O1 > /dev/null
        ;;

      ifomegaO2)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O2 \
          > /dev/null
        ;;

      gfomegaO2)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O2 > /dev/null
        ;;

      ifomegaO3)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort FCFLAGS=-O3 \
          > /dev/null
        ;;

      gfomegaO3)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS=-O3 > /dev/null
        ;;

      gfwhizopenmp)
        $whiz/configure --prefix=$whiz/install/$b FC=gfortran \
          --enable-fc-openmp > /dev/null
        ;;

      ifomegaopenmp)
        $whiz/omega/configure --prefix=$whiz/install/$b FC=ifort \
          FCFLAGS='-O2 -openmp' --enable-fc-openmp > /dev/null

    esac
  fi
  echo "Building $b"
  make -j 4 --silent
  make install
  if [ $check -eq 1 ]; then
    make check
  fi
  cd ..
done

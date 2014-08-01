if [ -d $HOME/trunk ]; then
  whiz="$HOME/trunk"
else
  whiz=`pwd`
fi
echo "Base dir is $whiz"

if [ $# -lt 3 ]; then
  echo 'Usage: build_tool.sh build n k'
  echo 'build = a -> all builds = def doc debug ifort'
  echo 'build = def -> default compiler and flags, no static '
  echo 'build = debug -> gfortran with DEBUG flags, no static '
  echo 'build = doc -> default compiler and flags, no static, with pdfs '
  echo 'build = ifort -> ifort -O2, only omega build '
  echo 'n = 0 -> only make'
  echo 'n = 1 -> configure and make'
  echo 'n = 2 -> autoreconf, configure and make'
  echo 'k = 0 -> dont test'
  echo 'k = 1 -> perform make check'
  exit
fi
if [ $1 == 'a'  ]; then
  builds='def doc debug ifort'
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
      ifort)
        $whiz/omega/configure --prefix=$whiz/install/$b OCAMLFLAGS='-w +a-4' FC=ifort FCFLAGS=-O2 > /dev/null
        ;;

      doc)
        $whiz/configure --prefix=$whiz/install/$b \
          --disable-static --enable-distribution > /dev/null
        ;;

      debug)
        $whiz/configure --prefix=$whiz/install/$b FC=gfortran \
          FCFLAGS="$DEBUG" > /dev/null
        ;;

      def)
        $whiz/configure --prefix=$whiz/install/$b > /dev/null

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

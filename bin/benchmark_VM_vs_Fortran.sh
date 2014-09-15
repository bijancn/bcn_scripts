RERUNS=3

if [ -d $HOME/trunk ]; then
  whiz="$HOME/trunk"
else
  whiz=`pwd`
fi
echo "Base dir is $whiz"

results=$whiz/results/$today

if [ $# -lt 0 ]; then
  echo 'Usage: benchmark_VM_vs_Fortran.sh '
  exit
fi
#builds='ifomegaO2warns gfomegaO3'
builds='gfomegaO0'
echo "Benchmarking $builds"

if [ -d $whiz ]; then
  cd $whiz
else
  echo "Source directory $whiz doesn't exist!"
  exit
fi
mkdir -p $results
cd build
for b in $builds; do
  cd $b
  echo "Checking $b"
  make check
  echo "# `./scripts/omega-config --fcversion`"  >> $results/${b}
  cd tests
  rm benchmark_VM_vs_Fortran
  make benchmark_VM_vs_Fortran
  for i in $(seq 1 $RERUNS); do
     ./benchmark_VM_vs_Fortran >> $results/${b}
  done
  cd ../..
done
cd ..

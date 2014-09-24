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
#builds='gfomegaO0'
#builds='gfomegaO0 ifomegaO0 gfomegaO1 ifomegaO1 gfomegaO2 ifomegaO2 gfomegaO3 ifomegaO3'
#builds='gfomegaO0 ifomegaO0 gfomegaO1 ifomegaO1'
#builds='gfomegaO0 ifomegaO0 ifomegaO1 ifomegaO2 ifomegaO3'
#builds='ifomegaO2warns'
#builds='ifomegaO3'
builds='gfomegaO2 ifomegaO2warns gfomegaO3 ifomegaO3'
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
  (
  cd $b;
  echo "Checking $b";
  make check;
  echo "# `./scripts/omega-config --fcversion`"  >> $results/${b};
  cd tests;
  rm benchmark_VM_vs_Fortran;
  make benchmark_VM_vs_Fortran;
  for i in $(seq 1 $RERUNS); do
     ./benchmark_VM_vs_Fortran >> $results/${b};
  done ;
  cd ../..;
  ) &
done
cd ..

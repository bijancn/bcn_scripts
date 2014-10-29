RERUNS=3

if [ -d $HOME/trunk ]; then
  whiz="$HOME/trunk"
else
  whiz=`pwd`
fi
echo "Base dir is $whiz"

if [ $# -lt 1 ]; then
  echo 'Usage: benchmark_VM_vs_Fortran.sh benchmark'
  echo 'Known shortcuts:'
  echo '- benchmark = VM -> benchmark_VM_vs_Fortran'
  echo '- benchmark = amp -> benchmark_amp_parallel'
  exit
fi
cmd=$1
case $cmd in
  VM)
    cmd_to_run='benchmark_VM_vs_Fortran'
    builds='gfomegaO2 ifomegaO2 gfomegaO3 ifomegaO3'
    ;;

  amp)
    cmd_to_run='benchmark_amp_parallel'
    builds='gfomegaopenmp'
    ;;

  *)
    echo "Unknown shortcut. Trying to benchmark $cmd"
    cmd_to_run=$cmd
esac
if [ $# -eq 2 ]; then
  tag='-'$2
else
  tag=''
fi

results=$whiz/results/$cmd_to_run/$today$tag

echo "Benchmarking $cmd_to_run with the builds $builds"
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
  if [ ! -d "$b$tag" ]; then
    echo "Build directory $b$tag doesn't exist!"
    exit
  fi
  cd $b$tag;
  echo "Checking $b$tag";
  # make check;
  echo "# `./scripts/omega-config --fcversion`"  >> $results/${b};
  cd tests;
  rm $cmd_to_run;
  make $cmd_to_run;
  echo "Running $b$tag";
  for i in $(seq 1 $RERUNS); do
     ./$cmd_to_run >> $results/${b};
  done ;
  cd ../..;
  ) &
done
wait
echo "========= ALL BENCHMARKS ARE DONE ========="
cd ..

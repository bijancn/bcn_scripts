DIRS="~/safe/phd/thesis ~/vimwiki/"
for dir in $DIRS; do
  git add .
  git commit -m "Automatic commit on `date +%F`"
  git push
done

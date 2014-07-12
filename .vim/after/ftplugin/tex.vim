" Spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

" Checks if makefile exist. If not we run ppdflatex and produce pdf.

if !filereadable(expand("%:p:h")."/Makefile")
  setlocal makeprg=ppdflatex\ %
endif

set foldmethod=indent
set foldlevel=0
set foldnestmax=1       " Create 3 levels of folds overall

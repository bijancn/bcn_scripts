" Spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

" Checks if makefile exist. If not we run gcc with all Warnings, 2011 standard,
" set the output file as <filename>.o and execute it.

if !filereadable(expand("%:p:h")."/Makefile")
  setlocal makeprg=ocamlc\ -annot\ -o\ %<.o\ %\ ;\ ./%<.o\ 
endif

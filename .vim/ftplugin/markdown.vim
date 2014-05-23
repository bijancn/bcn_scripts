" Spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

" Checks if makefile exist. If not we run pandoc and produce pdf.

if !filereadable(expand("%:p:h")."/Makefile")
  setlocal makeprg=pandoc\ -o\ %<.pdf\ -V\ geometry\:margin=3cm\ %
endif

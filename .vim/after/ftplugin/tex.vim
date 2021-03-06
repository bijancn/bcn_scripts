" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/after/ftplugin/tex.vim - TeX specifics
"
" Copyright (C) 2014         Bijan Chokoufe Nejad         <bijan@chokoufe.com>
" Recent versions:  https://github.com/bijancn/bcn_scripts
"
" This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
" can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
" http://www.gnu.org/licenses/gpl-2.0-standalone.html
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

" Checks if Makefile or SConstruct exists. If not we run pdflatex to produce pdf.
if !filereadable(expand("%:p:h")."/SConstruct")
  if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=pdflatex\ %\ 
  endif
else
  setlocal makeprg=scons\ .\ 
endif

set textwidth=72          " Where to brake text to new line

" set foldmethod=indent
" set foldlevel=0
" set foldnestmax=1

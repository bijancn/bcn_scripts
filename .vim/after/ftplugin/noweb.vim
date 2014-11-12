" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/after/ftplugin/noweb.vim - Noweb specifics
"
" Copyright (C) 2014         Bijan Chokoufe Nejad         <bijan@chokoufe.com>
" Recent versions:  https://github.com/bijancn/bcn_scripts
"
" This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
" can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
" http://www.gnu.org/licenses/gpl-2.0-standalone.html
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

setlocal commentstring=!\ %s

set textwidth=72

set foldmethod=indent

" Checks if Makefile or SConstruct exists. If not we run pdflatex to produce pdf.
if !filereadable(expand("%:p:h")."/SConstruct")
  if !filereadable(expand("%:p:h")."/Makefile")
    "setlocal makeprg=noweave\ %\ |\ pdflatex\ 
  endif
else
  setlocal makeprg=scons\ .\ 
endif

" Highlight consistent line
if exists('+colorcolumn')
  set colorcolumn=73
else
  " At least mark the awful content as Error
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>73v.\+', -1)
endif

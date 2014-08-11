" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/after/ftplugin/ocaml.vim - OCaml specifics
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

" Checks if Makefile exist. If not we run ocamlc, set the output file as
" <filename>.o and execute it.
if !filereadable(expand("%:p:h")."/Makefile")
  setlocal makeprg=ocamlc\ -annot\ -o\ %<.o\ %\ ;\ ./%<.o\ 
endif

" Matchwords for matchit
let b:mw='\<let\>:\<and\>:\(\<in\>\|;;\),'
let b:mw=b:mw . '\<if\>:\<then\>:\<else\>,'
let b:mw=b:mw . '\<\(for\|while\)\>:\<do\>:\<done\>,'
let b:mw=b:mw . '\<\(object\|sig\|struct\|begin\)\>:\<end\>,'
let b:mw=b:mw . '\<\(match\|try\)\>:\<with\>'
let b:match_words=b:mw

let g:merlin_ignore_warnings = 'true'

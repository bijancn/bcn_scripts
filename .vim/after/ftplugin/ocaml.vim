" Spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

" Checks if makefile exist. If not we run gcc with all Warnings, 2011 standard,
" set the output file as <filename>.o and execute it.

if !filereadable(expand("%:p:h")."/Makefile")
  setlocal makeprg=ocamlc\ -annot\ -o\ %<.o\ %\ ;\ ./%<.o\ 
endif

let b:mw='\<let\>:\<and\>:\(\<in\>\|;;\),'
let b:mw=b:mw . '\<if\>:\<then\>:\<else\>,'
let b:mw=b:mw . '\<\(for\|while\)\>:\<do\>:\<done\>,'
let b:mw=b:mw . '\<\(object\|sig\|struct\|begin\)\>:\<end\>,'
let b:mw=b:mw . '\<\(match\|try\)\>:\<with\>'
let b:match_words=b:mw

let g:merlin_ignore_warnings = 'true'

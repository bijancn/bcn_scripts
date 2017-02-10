" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/after/ftplugin/markdown.vim - Markdown specifics
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

" Checks if makefile exist. If not we run pandoc and produce pdf.
if !filereadable(expand("%:p:h")."/Makefile")
  setlocal makeprg=pandoc\ -o\ %<.pdf\ -V\ geometry\:margin=3cm\ %
endif

set textwidth=72

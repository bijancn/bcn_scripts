setlocal commentstring=!\ %s 

set textwidth=72

" Highlight consistent line
if exists('+colorcolumn')
  set colorcolumn=73
else
  " At least mark the awful content as Error
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>73v.\+', -1)
endif


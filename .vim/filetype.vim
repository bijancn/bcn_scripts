"
" my filetype file

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.nw     setfiletype noweb
  au! BufRead,BufNewFile *.md     setfiletype markdown
  au! BufRead,BufNewFile *.sin    setfiletype sindarin
augroup END

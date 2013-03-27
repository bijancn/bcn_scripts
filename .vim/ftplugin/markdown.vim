" Spaces must be escaped
" % expands to the name of the file
" %< expands to the name of the file without the extension

" Create html file from markdown and open it

setlocal makeprg=markdown\ %\ >%<.html

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN_COLOR_DEMO ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" bcn:              bijan@chokoufe.com
" Recent versions:  https://github.com/bijanc/bcn_scripts
" Last Change:      2012 Mar 15
"
" Put me in:
"             for Unix and OS/2:     ~/.vim/bcn_color_demo.vim
"
" To see all color codes, open a new buffer and :so ~/.vim/bcn_color_demo.vim

let num = 255
while num >= 0
    exec 'hi col_'.num.' ctermbg='.num.' ctermfg=white'
    exec 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
    call append(0, 'ctermbg='.num.':....')
    let num = num - 1
endwhile

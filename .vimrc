" ~~~~~~~~~~~~~~~~~~~~~~~~~~ VIMRC OF BCN ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
"  Put me in:
"             for Unix and OS/2:     ~/.vimrc
"             for MS-DOS and Win32:  $VIM\_vimrc

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ BASIC BEHAVIOR ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle can be invoked by :BundleInstall
filetype off                   " required for Vundle!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'jcf/vim-latex'
Bundle 'comments.vim'
Bundle 'YankRing.vim'
Bundle 'taglist.vim'

" This allows backspacing over everything in insert mode. Don't insert spaces.
set backspace=indent,eol,start

set nobackup        " do not keep a backup file
set history=500     " keep 500 lines of command line history
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ KEYBOARD MAPPINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" <CR> sends Enter

" Open NERDTree with \n
nmap <Leader>n :NERDTreeToggle<CR>

" Open Taglist with \t
nmap <Leader>t :TlistToggle<CR>

" Show Yankring
nnoremap <silent> <F8> :YRShow<CR>

" Using left and right for adjusting comments
no <left> <<
no <right> >>

" key-mappings for comment line in normal mode
noremap  <C-C> :call CommentLine()<CR>
"noremap  <C-C> :set nowrap!<CR>:call CommentLine()<CR>:set nowrap!<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Yank from the cursor to the end of the line
nmap Y y$

" Filetype specific make commands are e.g. in ~/.vim/ftplugin/python.vim
nmap <Leader>f :w <CR> :make <CR>

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <Leader>o :set nospell!<CR>
"nnoremap <Leader>o :setlocal spell spelllang=en_us<CR>

" Toggle between highlighting line or column
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Some remappings to avoid collision with byobu
imap <C-G> <F5>
nmap <C-G> <F5>
imap <C-H> <F7>
nmap <C-H> <F7>

" Vim-Latex Mappings
imap ICG includegraphics<C-H>
imap ECL columns<C-G>
imap EAL Balign<C-G>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ SCROLLING ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" Set the number of lines you want to stay off of bottom and top. This induces
" vim to scroll automatically when the cursor comes close.
set scrolloff=5

function SmoothScroll(up)
    if a:up
        let scrollaction="\<C-Y>k"
    else
        let scrollaction="\<C-E>j"
    endif
    exec "normal " . scrollaction 
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 5m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
nnoremap <C-B> :call SmoothScroll(1)<Enter> :call SmoothScroll(1)<Enter>
nnoremap <C-F> :call SmoothScroll(0)<Enter> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" This is the not recommended version for .less support. There are proper addons
" for full highlighting.
au BufNewFile,BufRead *.less set filetype=css

" Use the default filetype settings. Also load indent files,
" to automatically do language-dependent indenting.
filetype plugin on
filetype indent on

" Switch syntax highlighting on
syntax on

" Highlight consistent line at 81 char
set colorcolumn=81

" Using my color scheme
colorscheme bcn_dark

" Disable the annoying menu bar taking away precious pixels in gVim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar

" Standard searches are case insensitive
set ignorecase
" If there is an uppercase character in the search, it becomes case sensitive
set smartcase

" In most terminal emulators the mouse works just fine, thus enable it
if has('mouse')
  set mouse=a
endif

" Set 'textwidth' to 80 characters. Vim will break after 80 chars.
set textwidth=80

" Vim will not break words
set linebreak

" Highlight current line 
set cursorline

" Fold per default according to syntax
set foldmethod=syntax

" Enable omni completion. Complete things with CTRL-X O.
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Activate linenumbers on the left side
set number

" Switch on highlighting the last used search pattern
set hlsearch

" Allows to use the overall clipboard
set clipboard=unnamedplus

" Consistent tabbing. Note: Clean up existing files with :retab
set shiftwidth=2        " Size of indentation
set expandtab           " Always uses spaces instead of tab characters
set tabstop=2           " Size of insterted spaces if tab is pressed

" Printing options
"set pdev=pdf
set number
set printoptions=paper:A4,syntax:y,wrap:y,number:y

map <leader>p :hardcopy <CR>

" Enable concealing, i.e. greek letters are shown as unicode
set cole=2

" GVIM cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Terminal cursor. Use an orange cursor in insert mode
let &t_SI = "\<Esc>]12;orange\x7"
let &t_EI = "\<Esc>]12;blue\x7"
"silent !echo -ne "\033]12;blue\007"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ OCAML ~~~~~~~~~~~~~~~~~~~~~~~~~~
" Settings for ocaml-annot plugin

function! OCamlType()
  let col  = col('.')
  let line = line('.')
  let file = expand("%:p:r")
  echo system("annot -n -type ".line." ".col." ".file.".annot")
endfunction
map <leader>. :call OCamlType()<cr>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ VIM-LATEX ~~~~~~~~~~~~~~~~~~~~~~~~~~
" Settings for vim-latex. \ll starts pdflatex
let g:Tex_DefaultTargetFormat='pdf'        
let g:Tex_MultipleCompileFormats='dvi,pdf,aux' 
" How many warnings are ignored.
" 1. underfull 2. overfull 3. floating objects 4. requested packages
let g:Tex_IgnoreLevel=2  
let g:Tex_flavor='latex'
let g:Tex_BibtexFlavor ='biber'

" Disable folding for tex
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""

" Changing environments
let g:Tex_Env_slide = "\\begin{Bframe}{<++>}\<CR><++>\<CR>\\end{Bframe}"
let g:Tex_Env_columns = 
 \"\\begin{columns}\<CR>\\column{.5\\textwidth}<++>\<CR>\\column{.5\\textwidth}\<CR>\\end{columns}"
let g:Tex_Com_includegraphics = "\\includegraphics[width=<++>\\textwidth]{<+filename+>}"

" Conceal: a accents, d delimiters, g Greek, m math and NOT s super/subscripts
let g:tex_conceal="dgm"
let g:tex_indent_brace=0
let g:tex_indent_items=0

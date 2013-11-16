" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
"
" bcn .vimrc - vim configuration file. Maintained since 2011.
"
" Copyright (C)     2013-08-25    Bijan Chokoufe Nejad    <bijan@chokoufe.com>
" Recent versions:  https://github.com/bijanc/bcn_scripts
"
" This source code is free software; you can redistribute it and/or
" modify it under the terms of the GNU General Public License Version 2: 
" http://www.gnu.org/licenses/gpl-2.0-standalone.html
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" 
" Put me in:
"             for Unix and OS/2:     ~/.vimrc
"             for MS-DOS and Win32:  $VIM\_vimrc
" 
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ BASIC BEHAVIOR ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle can be invoked by :BundleInstall. Updates with :BundleUpdate!
filetype off                   " required for Vundle!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'comments.vim'
Bundle 'YankRing.vim'
Bundle 'bling/vim-airline'
"Bundle 'scrooloose/nerdtree'
Bundle 'matchit.zip'
Bundle 'ervandew/supertab'
"Bundle 'nw.vim' "Bundle 'noweb.vim' These two suck quite hard compared to:
Bundle 'noweb.vim--McDermott'
"Bundle 'taglist.vim' "Don't really use it
"Bundle 'jcf/vim-latex' " Too annoying and slow
"Bundle 'Dynetrekk/snipmate.vim'
Bundle 'bijancn/snipmate.vim'

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
"nmap <Leader>n :NERDTreeToggle<CR>

" Open Taglist with \t
"nmap <Leader>t :TlistToggle<CR>

" Show Yankring
nnoremap <silent> <F8> :YRShow<CR>

" key-mappings for comment line in normal mode
nmap <C-C> :call CommentLine()<CR>
"nmap  <C-C> :set nowrap!<CR>:call CommentLine()<CR>:set nowrap!<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <C-C> :call RangeCommentLine()<CR>

" Unfolding and folding with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <silent> <C-Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf

" key-mappings for un-comment line in normal mode
nmap <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

" Filetype specific make commands are e.g. in ~/.vim/ftplugin/python.vim
"nmap <Leader>f :w <CR> :make <CR><CR>

nmap <Leader>b :exe '!biber ' . expand('%:r') . '.bcf' <CR><CR>

" Put yanked noweb chunk line to the end
nmap <Leader>np p$xkJ

" Yank noweb in current line
nmap <Leader>ny 0v$hhy

" Make new chunk
nmap <Leader>nc o%<CR><<<<>>=<CR>@<CR>%<Esc>2kla

" Open corresponding html file
"nmap <Leader>v :!google-chrome %<.html<CR><CR>

nnoremap <Leader>o :set nospell!<CR>
"nnoremap <Leader>o :setlocal spell spelllang=en_us<CR>

" Toggle between highlighting line or column
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Change working directory to current file
map <Leader>d :cd %:p:h<CR>:pwd<CR>

" 
let dark=1
nnoremap <Leader>i :call Colortoggle(dark)<CR> 

function! Colortoggle(dark)
  if a:dark
    :colorscheme bcn_light
    " This doesn't work yet 
    let dark=0
  else
    :colorscheme bcn_dark
    " This doesn't work yet 
    let dark=1
  endif
endfunction

command W :execute 'silent w !sudo tee > /dev/null %'
command Wq :execute ':W' | :q!
command WQ :Wq

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Using left and right for adjusting comments
no <left> <<
no <right> >>

" Don't use Ex-mode, use Q for formatting
map Q gq

" Create new tab
map tn :tabnew <CR>

" Tab opened buffers
map ta :tab all <CR>

" Open new tab with directory of current file
map te :tabedit <c-r>=expand("%:p:h")<cr>/

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O<Tab>
inoremap {{     {
inoremap {}     <Space>
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O<Tab>
inoremap ((     (
inoremap ()     <Space>
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O<Tab>
inoremap [[     [
inoremap []     <Space>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ ABBREVIATIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
iabbrev lamda lambda
iabbrev teh the
iabbrev excecute execute
iabbrev Rkd real((kind=default)
iabbrev Di dimension(
iabbrev Ii intent((in) ::
iabbrev Io intent((out) ::
iabbrev Icg \includegraphics[[width=\textwidth]{
iabbrev Ecl \begin{{columns}<CR><CR>\end{{columns}<Esc>ki<Space><Space>
iabbrev Eal \begin{{Balign}<CR><CR>\end{{Balign}<Esc>ki<Space><Space>
iabbrev Efi \begin{{figure}<CR><CR>\end{{figure}<Esc>ki<Space><Space>\includegraphics[[width=\textwidth]{{}
iabbrev Nc <Esc>ddk<leader>nc

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ SCROLLING ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" Set the number of lines you want to stay off of bottom and top. This induces
" vim to scroll automatically when the cursor comes close.
set scrolloff=2

" Sadly this script isn't robust for scrolling in really large files
" The bang tells vim that it can reload the function
function! SmoothScroll(up)
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
        sleep 1m
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
" Use the default filetype settings. Also load indent files,
" to automatically do language-dependent indenting.
filetype plugin on
filetype indent on

" This is the not recommended version for .less support. There are proper addons
" for full highlighting.
au BufNewFile,BufRead *.less set filetype=css

" Performance option
set lazyredraw

" In most terminal emulators the mouse works just fine, thus enable it
if has('mouse')
  set mouse=a
endif

" Set 'textwidth' to 80 characters. Vim will break after 80 chars.
set textwidth=80

" Vim will not break words
set linebreak

" Switch syntax highlighting on
syntax on

" Highlight consistent line at 81 char
if exists('+colorcolumn')
  set colorcolumn=81
else
  " At least mark the awful content as Error
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

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

" Fold per default according to syntax
set foldmethod=syntax

set foldnestmax=3

" Search only in unfolded text
set fdo-=search

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

"if has ("conceal")
  "" Enable concealing, i.e. greek letters are shown as unicode
  "set cole=2
"endif

" Highlight current line 
set cursorline

" GVIM cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Terminal cursor. Use an orange cursor in insert mode
let &t_SI = "\<Esc>]12;blue\x7"
let &t_EI = "\<Esc>]12;orange\x7"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FORTRAN ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Form: We will always use Fortran free not fixed form
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NOWEB ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let noweb_backend = "tex"
let noweb_language = "fortran" 
let noweb_fold_code = 1

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VIM-LATEX ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Settings: \ll starts pdflatex. \lv starts pdf viewer
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf,aux' 
let g:Tex_flavor='latex'
let g:Tex_BibtexFlavor ='biber'

" Warnings: How many warnings are ignored:
" 1. underfull + 2. overfull + 3. floating objects + 4. requested packages
let g:Tex_IgnoreLevel=3
let g:Tex_IgnoredWarnings=
\"Underfull\n".
\"Overfull\n".
\"LaTeX Font Warning\n".
\"specifier changed to\n".
\"You have requested\n".
\"Missing number, treated as zero.\n".
\"There were undefined references\n"
\"Citation %.%# undefined"

let g:Tex_GotoError=0

" Folding: Disabled
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments="Balign,Bframe"
let g:Tex_FoldedMisc="preamble"

let Imap_PlaceHolderStart='<'
let Imap_PlaceHolderEnd='>'

let g:Imap_UsePlaceHolders=0

" Speed things up with python
let g:Tex_UsePython=1

" Environments:
let g:Tex_Env_slide = "\\begin{Bframe}\<CR>{<++>}\<CR><++>\<CR>\\end{Bframe}"
let g:Tex_Env_columns = 
 \"\\begin{columns}\<CR>\\column{.5\\textwidth}<++>\<CR>\\column{.5\\textwidth}\<CR>\\end{columns}"
let g:Tex_Com_includegraphics = "\\includegraphics[width=<++>\\textwidth]{<+filename+>}"

" Feynmp: Automatically calling mpost to compute diagrams with bcn_koma
let g:Tex_CompileRule_pdf='pdflatex -file-line-error -enable-write18 -halt-on-error'

" Conceal: a accents, d delimiters, g Greek, m math and NOT s super/subscripts
"let g:tex_conceal="dgm"
let g:tex_indent_brace=0
let g:tex_indent_items=0

" Disables the jumping into braces but also abbreviations.
let g:Imap_FreezeImap=0

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AIR-LINE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set encoding=utf-8
" Good looking powerline
let g:airline_powerline_fonts = 1
" Ensure that airline shows up
set laststatus=2
" Super fancy tabline
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '>'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" Get rid of that random trailing indication  
let g:airline_detect_whitespace=0

set rtp+=/home/bijancn/.opam/system/share/ocamlmerlin/vim
set rtp+=/home/bijancn/.opam/system/share/ocamlmerlin/vimbufsync

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SUPERTAB ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:SuperTabDefaultCompletionType = "context"

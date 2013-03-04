" ~~~~~~~~~~~~~~~~~~~~~~~~~~ VIMRC OF BCN ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
"  Put me in:
"             for Unix and OS/2:     ~/.vimrc
"             for MS-DOS and Win32:  $VIM\_vimrc

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ BASIC BEHAVIOR ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
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

" Open NERDTree with \n
nmap <Leader>n :NERDTreeToggle<CR>

" Open Taglist with \t
nmap <Leader>t :TlistToggle<CR>

" The Challenge
no <up> <C-Y>   
no <down> <C-E>
no <left> <<
no <right> >>

" key-mappings for comment line in normal mode
noremap  <C-C> :set nowrap!<CR>:call CommentLine()<CR>:set nowrap!<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <C-C> :set nowrap!<CR>:call RangeCommentLine()<CR>:set nowrap!<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Yank from the cursor to the end of the line
nnoremap Y y$

" Providing the shortcut \f to compile python,etc. which are configured
" in ./vim/ftplugin/python.vim, etc. (makeprg)
" <CR> sends Enter to excecute right away
nmap <Leader>f :w <CR> :make <CR>

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Show Yankring
nnoremap <silent> <F8> :YRShow<CR>

nnoremap <Leader>o :set nospell!<CR>
"nnoremap <Leader>o :setlocal spell spelllang=en_us<CR>

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

" Enable file type detection.  Use the default filetype settings, so that mail
" gets 'tw' set to 72, 'cindent' is on in C files, etc.  Also load indent files,
" to automatically do language-dependent indenting.
filetype plugin on
filetype indent on

" Switch syntax highlighting on
syntax on

" Spell checking
"setlocal spell spelllang=en_us

" Highlight consistent line at 81 char
set colorcolumn=81

" Disable the annoying menu bar taking away precious pixels in gVim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar

" Highlight only characters which exceed 80 per line
"highlight OverLength ctermbg=lightgrey ctermfg=red guibg=#592929
"match OverLength /\%81v.\+/

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

" Get more tags files from ctags -R *
set tags=./tags,./../tags,./*/tags

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

" Size of indentation
set shiftwidth=2
" Always uses spaces instead of tab characters
set expandtab
" Size of insterted spaces if tab is pressed
set tabstop=2
" Note: Clean up existing files with :retab

" Printing options
"set pdev=pdf
set number
set printoptions=paper:A4,syntax:y,wrap:y,number:y

"map <leader>p :color print_bw <CR> :hardcopy >~/temp.pdf <CR> :color default<CR>
map <leader>p :hardcopy <CR>

" Enable concealing, i.e. greek letters are shown as unicode
set cole=2

" GVIM cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Terminal cursor
" use an orange cursor in insert mode
let &t_SI = "\<Esc>]12;orange\x7"
" use a red cursor otherwise
let &t_EI = "\<Esc>]12;darkblue\x7"
silent !echo -ne "\033]12;darkblue\007"
  
" ~~~~~~~~~~~~~~~~~~~~~~~~~~ COLORS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" Enable 256 colors
set t_Co=256

" Setting some colors for dark background. hi == highlight. To see the color
" codes, open a new buffer and :so ~/.vim/color_demo.vim
hi Normal	        ctermbg=none        ctermfg=254         cterm=None
hi Cursor         ctermbg=black       ctermfg=17        cterm=None
"hi iCursor        ctermbg=17          ctermfg=white        cterm=None
hi SpecialKey	    ctermbg=None        ctermfg=70          cterm=None
hi Directory	    ctermbg=254         ctermfg=57          cterm=None
hi ErrorMsg       ctermfg=160         ctermbg=245         cterm=None
hi PreProc	      ctermbg=None        ctermfg=5           cterm=None
hi NonText	      ctermbg=None        ctermfg=105         cterm=Bold
hi DiffText	      ctermbg=244         ctermfg=165         cterm=None
hi Todo           ctermbg=None        ctermfg=162         cterm=Bold
hi Identifier	    ctermbg=None        ctermfg=77          cterm=none
hi Ignore         ctermbg=None        ctermfg=221         cterm=Bold
hi Underline      ctermbg=None        ctermfg=147         cterm=Italic

hi Conceal        ctermbg=None        ctermfg=magenta 
hi Search         ctermbg=17          ctermfg=NONE 
hi LineNr                             ctermfg=gray
hi SpellBad       ctermbg=88
hi Comment        ctermbg=none        ctermfg=lightblue   cterm=none
hi Error	        ctermbg=none        ctermfg=None        cterm=Bold
"hi Special	    ctermfg=172         ctermbg=None        cterm=Bold
hi Constant	      ctermbg=None        ctermfg=1           cterm=None
hi Statement	    ctermbg=None        ctermfg=208         cterm=none
hi Type		        ctermbg=None        ctermfg=227         cterm=none
hi Visual         ctermbg=238         ctermfg=250         cterm=None
hi ColorColumn    ctermbg=gray 
hi CursorColumn   ctermbg=17          ctermfg=white       cterm=NONE 
hi CursorLine     ctermbg=233                             cterm=none

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

" Disable folding
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

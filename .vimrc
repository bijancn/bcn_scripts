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

let python_highlight_all = 1

"=============================================================================="
"                                BASIC BEHAVIOR                                "
"=============================================================================="
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" This allows backspacing over everything in insert mode. Don't insert spaces.
set backspace=indent,eol,start

set nobackup        " do not keep a backup file
set history=500     " keep 500 lines of command line history
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set wildmode=longest,list
set wildmenu

"=============================================================================="
"                                    VUNDLE                                    "
"=============================================================================="

" Vundle can be invoked by :PluginInstall. Updates with :PluginUpdate!
filetype off                   " required for Vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/vundle'

"=========="
"  stable  "
"=========="
" Pure epicness, the one and only
Bundle 'bling/vim-airline'

" The ultimate snippet solution
Bundle 'SirVer/ultisnips'

" Allows to focus completely
Bundle 'junegunn/goyo.vim'

"==========="
"  testing  "
"==========="
" Does not change in noweb chunks, might be fixable
"Bundle 'comments.vim'

" Giving it a try
Bundle 'scrooloose/nerdcommenter'

"This should be standard vim now?!
"Bundle 'matchit.zip'

" YCM needs VIM 7.3.584 :(
"Bundle 'Valloric/YouCompleteMe'

" Diffing parts of a or two files
Bundle 'AndrewRadev/linediff.vim'

Bundle 'jonathanfilip/vim-lucius'

Bundle 'vim-pandoc/vim-pandoc'

"=============="
"  deprecated  "
"=============="
" Almost never need this
"Bundle 'YankRing.vim'

" Just isn't as smart as it pretends to be
"Bundle 'ervandew/supertab'

" Don't really use it
"Bundle 'taglist.vim'

" Sadly it is bugged for me. Must collide with some setting I can't find
"Bundle 'scrooloose/nerdtree'

" Just can't get used to it
"Bundle 'tpope/vim-surround'
"Bundle 'tpope/vim-repeat'

"=============================================================================="
"                              KEYBOARD MAPPINGS                               "
"=============================================================================="
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" <CR> sends Enter

" Unfolding and folding with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <silent> <C-Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf
nnoremap <Leader> f :set foldmethod=none

" Toggle between highlighting line or column
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Using left and right for adjusting comments
no <left> <<
no <right> >>

" Create new tab
map tn :tabnew <CR>

" Tab opened buffers
map ta :tab all <CR>

" Open new tab with directory of current file
map te :tabedit <c-r>=expand("%:p:h")<cr>/

" Change working directory to current file
map <Leader>d :cd %:p:h<CR>:pwd<CR>

" Filetype specific make commands are in ~/.vim/ftplugin/<lang>.vim
nmap <Leader>m :w<CR>:make<CR> <CR>

" Update biber file
nmap <Leader>b :exe '!biber ' . expand('%:r') . '.bcf' <CR><CR>

" Linediff two ranges
vmap <Leader>ld :Linediff<CR>

" Printing
map <leader>p :hardcopy <CR>

" Put in yanked and keep it yanked
xnoremap P pgvy

" Allow full screen in GVIM
map <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" Don't use Ex-mode, use Q for formatting
map Q gq

"=============="
"  deprecated  "
"=============="
" key-mappings for comment line in normal mode
"nmap <C-C> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
"vnoremap <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
"nmap <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
"vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

" Open NERDTree with \n
"nmap <Leader>n :NERDTreeToggle<CR>

" Open Taglist with \t
"nmap <Leader>t :TlistToggle<CR>

" Show Yankring
"nnoremap <silent> <F8> :YRShow<CR>

" Open corresponding html file
"nmap <Leader>v :!google-chrome %<.html<CR><CR>

"=============================================================================="
"                                ABBREVIATIONS                                 "
"=============================================================================="

iabbrev lamda lambda
iabbrev teh the
iabbrev wether whether
iabbrev excecute execute
iabbrev pertubation perturbation
iabbrev acchieved achieved
iabbrev acchieve achieve
" These should be snippets
"iabbrev Icg \includegraphics[[width=\textwidth]{
"iabbrev Ecl \begin{{columns}<CR><CR>\end{{columns}<Esc>ki<Space><Space>
"iabbrev Efi \begin{{figure}<CR><CR>\end{{figure}<Esc>ki<Space><Space>\includegraphics[[width=\textwidth]{{}

"=============================================================================="
"                                  SCROLLING                                   "
"=============================================================================="
" Set the number of lines you want to stay off of bottom and top. This induces
" vim to scroll automatically when the cursor comes close.
set scrolloff=2

" Sadly this script isn't robust for scrolling in really large files
" The bang tells vim that it can reload the function
"function! SmoothScroll(up)
    "if a:up
        "let scrollaction="\<C-Y>k"
    "else
        "let scrollaction="\<C-E>j"
    "endif
    "exec "normal " . scrollaction
    "redraw
    "let counter=1
    "while counter<&scroll
        "let counter+=1
        "sleep 1m
        "redraw
        "exec "normal " . scrollaction
    "endwhile
"endfunction

"nnoremap <C-U> :call SmoothScroll(1)<Enter>
"nnoremap <C-D> :call SmoothScroll(0)<Enter>
"nnoremap <C-B> :call SmoothScroll(1)<Enter> :call SmoothScroll(1)<Enter>
"nnoremap <C-F> :call SmoothScroll(0)<Enter> :call SmoothScroll(0)<Enter>
"inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
"inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

"=============================================================================="
"                               Functionalities                                "
"=============================================================================="

" Show to which higroup a certain word belongs to. Indispensable for creating
" color schemes and syntax files
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

if !exists('W_defined')
  let W_defined = "True"
  command W :execute 'silent w !sudo tee > /dev/null %'
  command Wq :execute ':W' | :q!
  command WQ :Wq
endif

" Put spaces around operators
"map <Leader>so :%s/\(\w\|)\)\(=\|+\|-\|*\|/\|<\|>\)\(\w\|(\)/\1 \2 \3/<CR>
map <Leader>so :%s/\(\w\)\(=\|+\|-\|*\|/\|<\|>\)\(\w\)/\1 \2 \3/c<CR>

" Remove all trailing spaces in document
map <Leader>st :%s/\s\+$/<CR>

"map <Leader>j :call setline('.', join(sort(split(getline('.'), ' ')), " "))<CR>
" Sort words in visual
vnoremap <Leader>o d:execute 'normal a' . join(sort(split(getreg('"'))), ' ')<CR>

"==========="
"  OpenPDF  "
"==========="
function! OpenPDF()
  let file_stripped = expand("%:r")
  echo system('gnome-open '.file_stripped.'.pdf')
endfunction
map <Leader>v :call OpenPDF()<CR>

"==============="
"  ocaml annot  "
"==============="
function! OCamlType()
  let col  = col('.')
  let line = line('.')
  let file = expand("%:r")
  let folder = "~/decrypted/bcn_omega211-build/src/"
  let cmd = "annot -n -type ".line." ".col." ".file.".annot"
  echo system('cd '.folder.' && '.cmd)
endfunction
map <Leader>t :call OCamlType()<CR>

"=============================================================================="
"                                   SETTINGS                                   "
"=============================================================================="
" Use the default filetype settings. Also load indent files,
" to automatically do language-dependent indenting.
filetype plugin on
filetype indent on

set autoindent

" Switch syntax highlighting on
syntax on

" Performance option
set lazyredraw

" In most terminal emulators the mouse works just fine, thus enable it
if has('mouse')
  set mouse=a
endif

" Set 'textwidth' to 80 characters. Vim will break after 80 chars.
set textwidth=80

" Highlight consistent line
if exists('+colorcolumn')
  set colorcolumn=81
else
  " At least mark the awful content as Error
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

" Vim will not break words. See :help breakat
set linebreak

" Vim will prefix soft-wrapped lines with these characters
set showbreak=-->\  " N.B. This would be trailing space

" Using my color scheme
colorscheme bcn_light

" Do not store global and local values in a session
set ssop-=options

" Disable the annoying menu bar taking away precious pixels in gVim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

" Standard searches are case insensitive
set ignorecase
" If there is an uppercase character in the search, it becomes case sensitive
set smartcase

" Fold per default according to syntax
set foldmethod=syntax

" Open all per default
setlocal foldlevel=99

" Don't go apeshit with nesting
set foldnestmax=3

" Search only in unfolded text. Does this work?
set fdo-=search
"
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
set printoptions=paper:A4,syntax:y,wrap:y,number:y

" Highlight current line
set cursorline

" GVIM cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Terminal cursor. Use different colors for insert and normal mode.
let &t_SI = "\<Esc>]12;blue\x7"
let &t_EI = "\<Esc>]12;orange\x7"

" Defaulting to latex and not plain tex
let g:Tex_flavor='latex'

"if has ("conceal")
  "" Enable concealing, i.e. greek letters are shown as unicode
  "set cole=2
"endif

" Disable things for better performance on huge noweb files.. doesnt help.. ?
syntax sync minlines=256
autocmd BufEnter * :syntax sync fromstart
set ttyfast

"=============================================================================="
"                                   AUTOCMD                                    "
"=============================================================================="
" This is the not recommended version for .less support. There are proper addons
" for full highlighting.
autocmd BufNewFile,BufRead *.less set filetype=css

" Enable omni completion. Complete things with CTRL-X O.
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" noweb specifics
"autocmd Filetype noweb set foldnestmax=1
autocmd Filetype noweb set nofoldenable

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
"
"=============================================================================="
"                                   FORTRAN                                    "
"=============================================================================="
" We will always use Fortran free not fixed form
let fortran_free_source=1
let fortran_fold=1
let fortran_fold_conditionals=1

"=============================================================================="
"                                   AIR-LINE                                   "
"=============================================================================="
set encoding=utf-8
" Good looking powerline
let g:airline_powerline_fonts = 1

" Ensure that airline shows up
set laststatus=2

" Super fancy tabline
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Shows trailing whitespace
let g:airline_detect_whitespace=1

"=============================================================================="
"                                   ULTISNIP                                   "
"=============================================================================="
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<C-j>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsJumpBackwardTrigger="<C-J>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "ultisnips_my"]

"=============================================================================="
"                                     GOYO                                     "
"=============================================================================="
let g:goyo_width=120
let g:goyo_margin_top=3
let g:goyo_margin_bottom=3
let g:goyo_linenr=0
nmap <Leader>g :Goyo<CR>

"=============================================================================="
"                              erikw/toggle_spell                              "
"=============================================================================="
" Toggle spell with a specific language and spellfile
function! ToggleSpell(lang)
	if !exists("b:old_spelllang")
		let b:old_spelllang = &spelllang
		let b:old_spellfile = &spellfile
		let b:old_dictionary = &dictionary
	endif

	let l:newMode = ""
	if !&l:spell || a:lang != &l:spelllang
		setlocal spell
		let l:newMode = "spell"
		execute "setlocal spelllang=" . a:lang
		execute "setlocal spellfile=" . "~/.vim/spell/" . matchstr(a:lang, "[a-zA-Z][a-zA-Z]") . "." . &encoding . ".add"
		execute "setlocal dictionary=" . "~/.vim/spell/" . a:lang . "." . &encoding . ".dic"
		let l:newMode .= ", " . a:lang
	else
		setlocal nospell
		let l:newMode = "nospell"
		execute "setlocal spelllang=" . b:old_spelllang
		execute "setlocal spellfile=" . b:old_spellfile
		execute "setlocal dictionary=" . b:old_dictionary
	endif
	return l:newMode
endfunction

nmap <silent> <F7> :echo ToggleSpell("en")<CR>			  " Toggle English spell.
nmap <silent> <F8> :echo ToggleSpell("de_de")<CR>     " Toggle German spell.

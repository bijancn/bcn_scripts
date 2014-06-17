" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" bcn .vimrc - vim configuration file. Maintained since 2011.
"
" Copyright (C)     2014-05-27    Bijan Chokoufe Nejad    <bijan@chokoufe.com>
" Recent versions:  https://github.com/bijancn/bcn_scripts
"
" This source code is free software; you can redistribute it and/or
" modify it under the terms of the GNU General Public License Version 2:
" http://www.gnu.org/licenses/gpl-2.0-standalone.html
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"=============================================================================="
"                                    VUNDLE                                    "
"=============================================================================="
" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle can be invoked by :PluginInstall. Updates with :PluginUpdate!
filetype off                   " required for Vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

"=========="
"  stable  "
"=========="
" Pure epicness, the one and only statusbar
Plugin 'bling/vim-airline'

" The ultimate snippet solution
Plugin 'SirVer/ultisnips'

" Allows to focus completely
Plugin 'junegunn/goyo.vim'

" Nice fuzzy autocompletion with supertab support
Plugin 'Valloric/YouCompleteMe'

" Diffing parts of one or two files
Plugin 'AndrewRadev/linediff.vim'

"==========="
"  testing  "
"==========="
" Does not change in noweb chunks, might be fixable
"Plugin 'comments.vim'

" Reasonably good. Not perfect. Also doesn't change in noweb.
Plugin 'scrooloose/nerdcommenter'

" Allows to use % on keywords like if
Plugin 'matchit.zip'

" A decent color scheme from which I want to borrow some concepts
"Plugin 'jonathanfilip/vim-lucius'

" Good support for Markdown
Plugin 'vim-pandoc/vim-pandoc'

" Syntax file for form
Plugin 'tueda/form.vim'

"=============="
"  deprecated  "
"=============="
" Don't really use it
"Plugin 'taglist.vim'

" Sadly it is bugged for me. Must collide with some setting I can't find
"Plugin 'scrooloose/nerdtree'

" Just can't get used to it
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-repeat'

call vundle#end()

"=============================================================================="
"                                   SETTINGS                                   "
"=============================================================================="
" Use the default filetype settings. Also load indent files,
" to automatically do language-dependent indenting.
filetype plugin indent on

" Reuse the indentation of the previous line if no filetype indent is available
set autoindent

" Consistent tabbing. Note: Clean up existing files with :retab
set shiftwidth=2        " Size of indentation
set expandtab           " Always uses spaces instead of tab characters
set tabstop=2           " Size of insterted spaces if tab is pressed

set textwidth=80        " Vim will break after 80 characters
set linebreak           " Vim will not break words. See :help breakat
set showbreak=-->\      " Prefix soft-wrapped lines with these characters

" Highlight consistent line
if exists('+colorcolumn')
  set colorcolumn=81
else
  " Mark as Error if no consistent line is available
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

" This allows backspacing over everything in insert mode. Don't insert spaces.
set backspace=indent,eol,start

set incsearch           " do incremental searching
set ignorecase          " Standard searches are case insensitive
set smartcase           " Case sensitive only when uppercase characters appear
set hlsearch            " Switch on highlighting the last used search pattern

set fdo-=search         " Search only in unfolded text. Does this work?
set foldmethod=syntax   " Fold per default according to syntax
setlocal foldlevel=99   " Open all folds per default
set foldnestmax=3       " Create 3 levels of folds overall

" The mode of wildmenu is set by wildmode. Gives way better tab completion of
" file names. Only completes as far as possible and gives list of possibilities
" with second TAB
set wildmode=longest,list
set wildmenu

set nobackup            " do not keep a backup file
set history=500         " keep 500 lines of command line history
set ssop-=options       " Do not store global and local values in a session
set showcmd             " display incomplete commands

syntax on               " Switch syntax highlighting on
colorscheme bcn_light

if has('mouse')         " Activate mouse
  set mouse=a
endif

set guioptions-=m       " remove menu bar in gVim
set guioptions-=T       " remove toolbar in gVim
set number              " Activate line numbers on the left side

set cursorline          " Highlight current line

" GVIM cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Terminal cursor. Use different colors for insert and normal mode.
let &t_SI = "\<Esc>]12;blue\x7"
let &t_EI = "\<Esc>]12;orange\x7"

set lazyredraw          " Performance option

set clipboard=unnamedplus " Allows to use the overall clipboard

set printoptions=paper:A4,syntax:y,wrap:y,number:y " Printing options

let python_highlight_all = 1

let g:Tex_flavor='latex'  " Defaulting to latex and not plain tex

" Apparantly those are performance settings. I see no difference, though.
syntax sync minlines=256
autocmd BufEnter * :syntax sync fromstart
set ttyfast

"if has ("conceal")
  "" Enable concealing, i.e. greek letters are shown as unicode
  "set cole=2
"endif

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
nnoremap <Leader>f :set foldmethod=none

" Toggle between highlighting line or column
nnoremap <Leader>o :set cursorline! cursorcolumn!<CR>

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

" Save with su rights without having started with them
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

" Show the corresponding PDF file
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

" Saving views for noweb viles
autocmd BufWinLeave *.nw mkview
autocmd BufWinEnter *.nw silent loadview

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
" Ensure compatibility with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsListSnippets="<C-S-tab>"
"let g:UltiSnipsJumpForwardTrigger="<C-tab>"
"let g:UltiSnipsJumpBackwardTrigger="<C-S-tab>"
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

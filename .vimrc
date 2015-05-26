" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" bcn .vimrc - vim configuration file. Maintained since 2011.
"
" Copyright (C) 2014         Bijan Chokoufe Nejad         <bijan@chokoufe.com>
" Recent versions:  https://github.com/bijancn/bcn_scripts
"
" This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
" can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
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
" Quickstart:
" git clone https://github.com/gmarik/Vundle.vim.git  ~/.vim/bundle/Vundle.vim

filetype off                   " required for Vundle!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

"=========="
"  stable  "
"=========="
" Diffing parts of one or two files
Plugin 'AndrewRadev/linediff.vim'

" A very decent color scheme. Forked for minor color changes.
Plugin 'bijancn/vim-lucius'

" Faster syntax and indent for free-form Fortran
Plugin 'bijancn/free-fortran.vim'

" Syntax file for sindarin
Plugin 'bijancn/whizard.vim'

" Pure epicness, the one and only statusbar
Plugin 'bling/vim-airline'

" Generate a fast shell prompt with powerline symbols and airline colors
" in vim:     :PromptlineSnapshot ~/.shell_prompt.sh airline
" in bashrc:  source ~/.shell_prompt.sh
Plugin 'edkolev/promptline.vim'

" Allows to focus completely
Plugin 'junegunn/goyo.vim'

" Fuzzy search on files, buffers and more
Plugin 'kien/ctrlp.vim'

" Rainbow parentheses
Bundle 'luochen1990/rainbow'

" Show errors and warnings of compilers and checkers
Plugin 'scrooloose/syntastic'

" The ultimate snippet solution
Plugin 'SirVer/ultisnips'

" Allow to run stuff asynchronously with normal vim
Plugin 'tpope/vim-dispatch.git'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Allow to increment/decremt dates, roman numerals, ordinals, letters
Plugin 'tpope/vim-speeddating'

" Add the surround physics. Repeat allows to repeat those
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" Syntax file for form
Plugin 'tueda/form.vim'

" Nice fuzzy autocompletion with supertab support
" Ubuntu libs:  build-essential cmake python-dev
" Build with:   cd ~/.vim/bundle/YouCompleteMe && ./install.sh
Plugin 'Valloric/YouCompleteMe'

"==========="
"  testing  "
"==========="
" Interesting color scheme
Plugin 'sjl/badwolf'

" Reasonably good. Not perfect. Also doesn't change in noweb.
Plugin 'scrooloose/nerdcommenter'

" Does not change in noweb chunks, might be fixable
"Plugin 'comments.vim'

" Good support for Markdown
Plugin 'vim-pandoc/vim-pandoc'

" Work together - apart. Only works with neovim
Plugin 'floobits/floobits-neovim'

" Add support for emacs org-mode
Plugin 'jceb/vim-orgmode'

" Show an outline / table of content of org or tex file and move things around
" Seems to conflict with vim-orgmodes <CR> and <TAB> behavior
Plugin 'vim-voom/VOoM'

" Create tables automatically and allow spreadsheet computations
Plugin 'dhruvasagar/vim-table-mode'

" Compute sums of columns
Plugin 'visSum.vim'

" Close all buffers but the current one
Plugin 'BufOnly.vim'

"Asynchronous make. Asynchronous part only works with neovim
"Plugin 'benekastah/neomake'

" Does not work with neovim. deoplete will and will use asynchronous completion
"Plugin 'Shougo/neocomplete.vim'

" 'awesome Python autocompletion library' - works with neocomplete
" This is mostly part of YCM
"Plugin 'davidhalter/jedi-vim'

" Nice fuzzy search on files, buffers and more
"Plugin 'Shougo/unite.vim'
" Can be used by unite for more efficient search. Has to be build with `make`
"Plugin 'Shougo/vimproc.vim'
" Powerful file explorer that needs unite
"Plugin 'Shougo/vimfiler.vim'

" Complete C, C++ using clang
"Plugin 'osyo-manga/vim-marching'

call vundle#end()

"=============================================================================="
"                                   SETTINGS                                   "
"=============================================================================="
" Use the default filetype settings. Also load indent files,
" to automatically do language-dependent indenting.
filetype plugin indent on
syntax on                 " Switch syntax highlighting on

" Reuse the indentation of the previous line if no filetype indent is available
set autoindent
set shiftwidth=2        " Size of indentation
set textwidth=80        " Vim will break after 80 characters
set linebreak           " Vim will not break words. See :help breakat
set showbreak=-->\      " Prefix soft-wrapped lines with these characters

" Highlight consistent line
if exists('+colorcolumn')
  set colorcolumn=81
else
  " Mark as Error if no consistent line is available
  autocmd BufWinEnter * let w:m2 = matchadd('ErrorMsg', '\%>81v.\+', -1)
endif
set cursorline          " Highlight current line

" Tabs. Note: Use :retab to clean up mixed indentation
set expandtab           " Always uses spaces instead of tab characters
set tabstop=2           " Size of insterted spaces if tab is pressed
set list                " Highlight tab characters in files
" disabled highlighting of trailing spaces: trail:., eol:¬,
set listchars=tab:▸\ ,extends:#,nbsp:.

" This allows backspacing over everything in insert mode. Don't insert spaces.
set backspace=indent,eol,start

" Searching
set incsearch             " do incremental searching
set ignorecase            " Standard searches are case insensitive
set smartcase             " Case sensitive only when uppercase characters appear
set hlsearch              " Switch on highlighting the last used search pattern

" Folds
set foldmethod=syntax     " Fold per default according to syntax
setlocal foldlevel=99     " Open all folds per default
set foldnestmax=3         " Create 3 levels of folds overall

set wildmenu              " Mode of wildmenu is set by wildmode
" Complete only as far as possible then give list of possibilities
set wildmode=longest,list
" Files and folders to ignore
set wildignore+=*.so,*.swp,*.zip,*/.git/*,*/.hg/*,*/.svn/*
" set wildignore+=*/_build/*,*/_install/*,*/_test/*

set nobackup              " do not keep a backup file
set directory=/tmp/       " Don't put swap files in local directories
set history=500           " keep 500 lines of command line history
set ssop-=options         " Do not store global and local values in a session
set showcmd               " display incomplete commands
set number                " Activate line numbers on the left side
set diffopt+=iwhite       " Ignore whitespace when diffing

set shell=/bin/bash

" Colors
set background=light
colorscheme lucius
LuciusWhite
"LuciusDarkLowContrast
" colorscheme bcn_light

" Mouse
if has('mouse')         " Activate mouse
  set mouse=a
endif
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

set guioptions-=m       " remove menu bar in gVim
set guioptions-=T       " remove toolbar in gVim

" Terminal cursor. Use different colors for insert and normal mode.
"let &t_SI = "\<Esc>]12;blue\x7"
"let &t_EI = "\<Esc>]12;orange\x7"

set clipboard=unnamedplus " Always use the overall clipboard

set printoptions=paper:A4,syntax:y,wrap:y,number:y " Printing options

let python_highlight_all = 1

let g:Tex_flavor = 'latex'  " Defaulting to latex and not plain tex

" Pretty vsplit and fold symbols
set fillchars=vert:│,fold:─
hi VertSplit      ctermbg=none ctermfg=gray

" A buffer becomes hidden when it is abandoned. Allows to have unsaved changes
" in different buffers.
set hidden

" Set new splits below and right
set splitbelow
set splitright

" Per default replace all with :s/pattern/replacement/ and replace only one by
" adding g
set gdefault

" Performance (?)
"syntax sync minlines=2048
"autocmd BufEnter * :syntax sync fromstart
set ttyfast
"set lazyredraw

"if has ("conceal")
  "" Enable concealing, i.e. greek letters are shown as unicode
  "set cole=2
"endif

" Toggle if vim should take paste from clipboard literally or try to reformat
set pastetoggle=<F2>

"=============================================================================="
"                              KEYBOARD MAPPINGS                               "
"=============================================================================="
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" <CR> sends Enter

map ]p ]cdp
map [p [cdp

" Unfolding and folding with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <silent> <C-Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap <Leader>f :VimFilerExplorer <c-r>=expand("%:p:h")<cr>/

" Toggle between highlighting line or column
nnoremap <Leader>o :set cursorline! cursorcolumn!<CR>

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Using left and right for adjusting comments
no <left> <<
no <right> >>

" Create new tab
map tn :tabnew <CR>
"
" Create a new empty buffer
map bn :enew <CR>

" Open new tab with directory of current file
map te :tabedit <c-r>=expand("%:p:h")<cr>/

" Open new buffer with directory of current file
map be :e <c-r>=expand("%:p:h")<cr>/

" Use less shift key
let mapleader = ";"

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Tab opened buffers. No good command!
"map ta :tab all <CR>

" Yank from current position to end
nnoremap Y y$

" Center to new location after movement
nnoremap n nzz
nnoremap } }zz

" Don't skip rows when long lines are wrapped
nnoremap j gj
nnoremap k gk

" Go to the next buffer
map K :bnext<CR>

" Go to the last buffer
map J :bprevious<CR>

" Close the current buffer and move to the previous one
nmap bq :bp <BAR> bd #<CR>
nmap bc :bp <BAR> bd #<CR>

nmap bo :BufOnly<CR>

" Show all open buffers and their status
nmap bl :ls<CR>

" Join lines and stay at the same position
map <Leader>j mz:join<CR>`z

" Change working directory to current file
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Move working directory one level higher
map <Leader>.. :cd ..<CR>:pwd<CR>

" Update biber file
nmap <Leader>bi :exe '!biber ' . expand('%:r') . '.bcf' <CR><CR>

" Linediff two ranges
vmap <Leader>l :Linediff<CR>

" Printing
map <Leader>p :hardcopy <CR>

" Put in yanked and keep it yanked
xnoremap P pgvy

" Allow full screen in GVIM
map <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" Don't use Ex-mode, use Q for formatting the current line (or selection)
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

"=============================================================================="
"                                ABBREVIATIONS                                 "
"=============================================================================="
iabbrev lamda lambda
iabbrev teh the
iabbrev halfed halved
iabbrev halfe halve
iabbrev wether whether
iabbrev excecute execute
iabbrev pertubation perturbation
iabbrev acchieved achieved
iabbrev acchieve achieve
" American versions
iabbrev analyse analyze
iabbrev behaviour behavior
iabbrev generalisation generalization

"=============================================================================="
"                                  SCROLLING                                   "
"=============================================================================="
" Set the number of lines you want to stay off of bottom and top. This induces
" vim to scroll automatically when the cursor comes close.
set scrolloff=2

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

" Strip Trailing spaces in document
noremap <Leader>st :%s/\s\+$/<CR>

" Remove ^M chars
noremap <Leader>rm :%s/\r//g<CR>

" Reload .vimrc
"nmap <silent> <Leader>so :so ~/.vimrc<CR>

" Edit vimrc
nnoremap <silent> <Leader>rc :e ~/.vimrc<CR>

" Sort words in visual
vnoremap <Leader>o d:execute 'normal a' . join(sort(split(getreg('"'))), ' ')<CR>

" Search for selected text, forwards or backwards.
vmap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vmap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Yank selected text and paste it in search
" vnoremap // y/<C-R>"<CR>

" Visually select a line
nnoremap vv 0v$h

nnoremap <silent> <Leader>ff :grep -r 'public :: <cword>$' %:p:h/../*<CR><CR>
nnoremap <silent> <Leader>fm :grep -r 'module <cword>$' %:p:h/../*<CR><CR>
nnoremap <silent> <Leader>fa :grep -r '<cword>' %:p:h/../*<CR><CR>

" Number of lines for command line
set cmdheight=2

" Show registers
nnoremap <Leader>re :registers<CR>

" Show the corresponding PDF file
function! OpenPDF()
  let file_stripped = expand("%:r")
  echo system('gnome-open '.file_stripped.'.pdf')
endfunction
map <Leader>v :call OpenPDF()<CR>

"=============================================================================="
"                                   AUTOCMD                                    "
"=============================================================================="
augroup load_filetypes
  autocmd!
  " Poor mans .less support. There are proper addons for this.
  autocmd BufNewFile,BufRead *.less set filetype=css

  " Enable omni completion
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete
augroup END

" Automatically reload .vimrc upon saving it
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup reload_other
  autocmd!
  " Auto load quick fix ?
  autocmd QuickFixCmdPost * copen
  " Automatically save and load views for files
  " TODO: (bcn 2015-02-09) This screws up viewing the same file with a split
  "autocmd BufWinLeave *.* mkview
  "autocmd BufWinEnter *.* silent loadview

  " Load indentexpr from fortran and switch back to noweb for syntax hl
  autocmd BufWinEnter *.nw setlocal filetype=fortran | setlocal filetype=noweb

  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  " http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
  autocmd InsertEnter * if !exists('w:last_fdm')
                        \ | let w:last_fdm=&foldmethod
                        \ | setlocal foldmethod=manual
                        \ | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
                                 \ | let &l:foldmethod=w:last_fdm
                                 \ | unlet w:last_fdm
                                 \ | endif

  " Automatically save when losing focus
  autocmd FocusLost *.* :wa

  " This would update when saving
  "autocmd BufWritePost * silent !update_mupdf.sh
augroup END

"=============================================================================="
"                                    NEOVIM                                    "
"=============================================================================="
" Avoid UltiSnip errors with python3
let g:loaded_python3_provider = 0

"=============================================================================="
"
"                                    MERLIN                                    "
"=============================================================================="
"let s:ocamlmerlin=substitute(system('opam config var share'),'\n$','','''') .  "/ocamlmerlin"
"execute "set rtp+=".s:ocamlmerlin."/vim"
"execute "set rtp+=".s:ocamlmerlin."/vimbufsync"

"=============================================================================="
"                                  SYNTASTIC                                   "
"=============================================================================="
" Checkers
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_fortran_checkers = [""]
let g:syntastic_python_pylint_quiet_messages = { "level" : "warnings" }

" Regexs for files to ignore
let g:syntastic_ignore_files = ['\m^/usr/include/', '\m^/home/bijancn/vm_paper/codes/ovm']

let g:syntastic_enable_signs = 1
"
" Jump to the first error
let g:syntastic_auto_jump = 2
" Close the error window but don't open it automatically
let g:syntastic_auto_loc_list = 2
" Height of the location lists
let g:syntastic_loc_list_height = 5

" Pretty 2 character signs for the left border
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = 'S✗'
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = 'S⚠'

"=============================================================================="
"                                   FORTRAN                                    "
"=============================================================================="
" We will always use Fortran free not fixed form
"let fortran_free_source=1
"unlet! fortran_fixed_source
"let fortran_fold=1                  " Define fold regions for foldmethod=syntax
"let fortran_fold_conditionals=1     " Also fold do, if and select case

let fortran_indent_more=1           " Also indent function, subroutine, program
let g:fortran_do_enddo=1            " Guarantee that do's are matched for indent

" This includes do, if, select case, where, interface
let g:fortran_extra_structure_indent=1
let g:fortran_extra_continuation_indent=3

"=============================================================================="
"                                   AIR-LINE                                   "
"=============================================================================="
" Important for powerline fonts
set encoding=utf-8

" Good looking powerline
let g:airline_powerline_fonts = 1

" Ensure that airline shows up
set laststatus=2

" Super fancy tabline for tabs and buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#bufferline#enabled = 1
"let g:airline#extensions#bufferline#overwrite_variables = 1

" Only show tail of filename if unique
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" default: (fileencoding, fileformat)
let g:airline_section_y = ''

" Control at what with the sections are truncated
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 79,
    \ 'x': 60,
    \ 'y': 88,
    \ 'z': 45,
    \ }

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Do not use tagbar which can be slow
let g:airline#extensions#tagbar#enabled = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Shows trailing whitespace
let g:airline#extensions#whitespace#enabled = 1

"=============================================================================="
"                                    CTRLP                                     "
"=============================================================================="
" Set no max file limit
let g:ctrlp_max_files = 0

" Mapping
let g:ctrlp_map = '<c-p>'

" CtrlP : only files, CtrlPBuffer : only buffer, CtrlPMRU : only recent files
" CtrlPMixed : all
let g:ctrlp_cmd = 'CtrlPMixed'

if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif

" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or
"       files: .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of
"       CtrlP is not a direct ancestor of the directory of the current file.
let g:ctrlp_working_path_mode = 'ra'

"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn|_build|_install|_test)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

"=============================================================================="
"                                   FUGITIVE                                   "
"=============================================================================="
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gp :Gpush<CR>:redraw!<CR>
nnoremap <Leader>gl :Git pull<CR>:redraw!<CR>

"=============================================================================="
"                                   DISPATCH                                   "
"=============================================================================="
" Filetype specific make commands are in ~/.vim/after/ftplugin/<lang>.vim
nnoremap <Leader>m :w<CR>:Make!<CR>
nnoremap <Leader>co :call CopenToggle()<CR>

"=============================================================================="
"                                QUICKFIXTOGGLE                                "
"=============================================================================="
nnoremap <Leader>q :call QuickfixToggle()<CR>
let g:quickfix_is_open = 0

function! QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

function! CopenToggle()
  let g:quickfix_return_to_window = winnr()
  Copen!
  let g:quickfix_is_open = 1
endfunction

"=============================================================================="
"                                DIFFOPTTOGGLE                                 "
"=============================================================================="
nnoremap <Leader>d :call DiffoptToggle()<CR>
set diffopt+=iwhite       " Ignore whitespace when diffing
let g:diffignore_whitespace = 1

function! DiffoptToggle()
  if g:diffignore_whitespace
    set diffopt-=iwhite
    let g:diffignore_whitespace = 0
  else
    set diffopt+=iwhite
    let g:diffignore_whitespace = 1
  endif
endfunction

"=============================================================================="
"                                    UNITE                                     "
"=============================================================================="
"let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])

" -no-split opens search in current window
" -start-insert causes Unite to open with the prompt activated
" -quick-match allows to open an entry quickly with one keypress
" async uses vimproc behind the scenes, which affords for searching while it
" populates the file list in the background
"nnoremap <space><space> :Unite -no-split -start-insert file_rec<CR>
" The :! tells unite to run things in the background
"nnoremap <space><space> :Unite -no-split -start-insert file_rec/async:!<CR>
"nnoremap <space>f       :Unite -no-split -start-insert file<cr>
"nnoremap <space>b       :Unite -no-split -start-insert buffer<cr>
"nnoremap <space>/       :Unite grep:.<cr>

" Allow to delete files in unite (might be dangerous)
"call unite#custom#alias('file', 'delete', 'vimfiler__delete')

"=============================================================================="
"                                   VIMFILER                                   "
"=============================================================================="
"let g:vimfiler_as_default_explorer = 1

" Pretty symbols
"let g:vimfiler_tree_leaf_icon = "¦"
""let g:vimfiler_tree_leaf_icon = "⋮"
"let g:vimfiler_tree_opened_icon = "▼"
"let g:vimfiler_tree_closed_icon = "▷"
""let g:vimfiler_tree_closed_icon = '▸'
"let g:vimfiler_file_icon = '-'
"let g:vimfiler_marked_file_icon = '※'

" Enable file operation commands
"call vimfiler#custom#profile('default', 'context', {
"      \ 'safe' : 0,
"      \ })

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
"                                YOUCOMPLETEME                                 "
"=============================================================================="
" Defines the max size (in Kb) for a file to be considered for completion
let g:ycm_disable_for_files_larger_than_kb = 2000

" Query the UltiSnips plugin for possible completions of snippet triggers
let g:ycm_use_ultisnips_completer = 1

nnoremap <Leader>t :YcmCompleter GoTo<CR>

"=============================================================================="
"                                     GOYO                                     "
"=============================================================================="
let g:goyo_width=120
let g:goyo_margin_top=3
let g:goyo_margin_bottom=3
let g:goyo_linenr=0
nmap <Leader>g :Goyo<CR>

"=============================================================================="
"                                 VIM-ORGMODE                                  "
"=============================================================================="

" Files used for the global agenda
let g:org_agenda_files=['~/safe/phd/index.org']

" Wether to make the leading stars less visible
let g:org_heading_shade_leading_stars = 1

" Multi-state workflows
let g:org_todo_keywords=['TODO', 'GETFEEDBACK', 'VERIFY', '|', 'DONE', 'DELEGATED']

"=============================================================================="
"                                   RAINBOW                                    "
"=============================================================================="
let g:rainbow_active = 0
map <Leader>rt :RainbowToggle<CR>
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['black', '21', 'darkmagenta', '160', '172'],
    \   'operators': '_,_',
    \   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
    \   'separately': {
    \       '*': {},
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \           'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
    \       },
    \       'vim': {
    \           'parentheses': [['fu\w* \s*.*)','endfu\w*'], ['for','endfor'], ['while', 'endwhile'], ['if','_elseif\|else_','endif'], ['(',')'], ['\[','\]'], ['{','}']],
    \       },
    \       'tex': {
    \           'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
    \       },
    \       'css': 0,
    \       'stylus': 0,
    \   }
    \}

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

nmap <silent> <F7> :echo ToggleSpell("en")<CR>\        " Toggle English spell.
nmap <silent> <F8> :echo ToggleSpell("de_de")<CR>\     " Toggle German spell.

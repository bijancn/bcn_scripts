" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" .vimrc - vim configuration file. Maintained since 2011.
"
" Copyright ©          Bijan Chokoufe Nejad          <bijan@chokoufe.com>
"
" This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
" can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
" http://www.gnu.org/licenses/gpl-2.0-standalone.html
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let g:plug_threads=8
let g:plug_timeout=100

call plug#begin()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                STABLE PLUGINS                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Adds git status next to the line numbers and allows reverting of chunks
Plug 'airblade/vim-gitgutter'

" Diffing parts of one or two files
Plug 'AndrewRadev/linediff.vim'

" Replace true with false with <leader>gs and much more
Plug 'AndrewRadev/switch.vim'

" Faster syntax and indent for free-form Fortran
Plug 'bijancn/free-fortran.vim'

" Syntax file for sindarin
Plug 'bijancn/whizard.vim'

" Close all buffers but the current one
Plug 'schickling/vim-bufonly', {'on': 'BufOnly'}

" Generate a fast shell prompt with powerline symbols and airline colors
" in vim:     :PromptlineSnapshot ~/.shell_prompt.sh airline
" in bashrc:  source ~/.shell_prompt.sh
Plug 'edkolev/promptline.vim'
" in vim:     :Tmuxline airline         :TmuxlineSnapshot ~/.tmux.statusline
Plug 'edkolev/tmuxline.vim'

Plug 'wadackel/vim-dogrun'

" Fix vims indentation to conform with PEP8
Plug 'hynek/vim-python-pep8-indent'

" A Vim wrapper for running tests on different granularities
Plug 'janko-m/vim-test'

" Allows to focus completely. limelight dims out other paragraphs
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Add the s motion. Should use it more. Especially to go to the next line(s)
Plug 'justinmk/vim-sneak'

" Fuzzy search on files, buffers and more
Plug 'kien/ctrlp.vim', { 'on' : ['CtrlP', 'CtrlPMixed'] }

" Pretty and useful startup screen
Plug 'mhinz/vim-startify'

" Make the indent level a text object
Plug 'michaeljsmith/vim-indent-object'

" Fast search with ag
Plug 'mileszs/ack.vim'

" Show indentation by gray scales
Plug 'nathanaelkane/vim-indent-guides'

" Markdown support
Plug 'plasticboy/vim-markdown'

" Reasonably good commenting
" Try tpope/vim-commentary when you find something lacking
Plug 'scrooloose/nerdcommenter'

" tree explorer plugin
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Show errors and warnings of compilers and checkers
Plug 'scrooloose/syntastic'

" The ultimate snippet solution
" Plug 'SirVer/ultisnips'
" Community driven Ultisnips snippets repo
" Plug 'honza/vim-snippets'

" Allow to run stuff asynchronously with normal vim
Plug 'tpope/vim-dispatch'

" Vim sugar for UNIX shell commands
Plug 'tpope/vim-eunuch'

" Git wrapper
Plug 'tpope/vim-fugitive'
" Advanced git wrapper like gitk. Show history of lines. Needs vim-fugitive
Plug 'gregsexton/gitv'
" Can show and switch branches easily. Needs vim-fugitive
Plug 'idanarye/vim-merginal'

" Standard set of options
Plug 'tpope/vim-sensible'

" Allow to increment/decremt dates, roman numerals, ordinals, letters
Plug 'tpope/vim-speeddating'

" Add the surround physics. Repeat allows to repeat those
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Syntax file for form
Plug 'tueda/form.vim'

" Nice fuzzy autocompletion with supertab support
" Ubuntu libs:  build-essential cmake python-dev
" Build with:   cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --tern-completer
" Plug 'Valloric/YouCompleteMe', { 'on' : [] } " , { 'do': 'export YCM_CORES=4 ; ./install.py' }
" Generate YCM configs for C++
Plug 'rdnetto/YCM-Generator', {'branch': 'stable', 'on': []}

" Personal wiki and journal
Plug 'vimwiki/vimwiki'

" Compute sums of columns
Plug 'vim-scripts/visSum.vim', {'on': ['VisSum', '<Plug>SumNum']}

" Pure epicness, the one and only statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    COLORS                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The infamous solarized
Plug 'altercation/vim-colors-solarized'

" A very decent color scheme. Forked for minor color changes.
Plug 'bijancn/vim-lucius'

" A dark, low-contrast, Vim colorscheme
Plug 'romainl/Apprentice'

" Swap arguments with g<, g> and gs
Plug 'machakann/vim-swap'

" Exchange two objects with cx<motion>
Plug 'tommcdo/vim-exchange'

Plug 'Erichain/vim-monokai-pro'

Plug 'aonemd/kuroi.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   TESTING                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

" Plug 'rust-lang/rust.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'hashivim/vim-terraform'

Plug 'martinda/Jenkinsfile-vim-syntax'

" Highlight characters for f,F,t,T
Plug 'unblevable/quick-scope'

" Create tables automatically and allow spreadsheet computations
Plug 'dhruvasagar/vim-table-mode'

" Vim script for text filtering and alignment. Also used by plasticboy/vim-markdown
Plug 'godlygeek/tabular'

Plug 'tpope/vim-unimpaired'

" class outline viewer
Plug 'majutsushi/tagbar'

" Browse ctags
" Plug 'vim-scripts/taglist.vim'
Plug 'majutsushi/tagbar'

" Visualize vim undo tree
Plug 'sjl/gundo.vim'

" Good support for Markdown
" Plug 'vim-pandoc/vim-pandoc'

" Trac highlighting
Plug 'vim-scripts/tracwiki'

Plug 'wkentaro/conque.vim'

" Edit multiple locations at once
Plug 'terryma/vim-multiple-cursors'

" eZchatting while vimming
Plug 'JNicL/vim-eZchat'

" Helper plugin for unicode
Plug 'chrisbra/unicode.vim'

" Post to slack out of vim
Plug 'heavenshell/vim-slack'
" Requirement for vim-slack
Plug 'mattn/webapi-vim'

" Show synonyms in a quickfix window
Plug 'beloglazov/vim-online-thesaurus'

" Show coverage
Plug 'alfredodeza/coveragepy.vim'

" Grammar checker for English, German and more
Plug 'vim-scripts/LanguageTool'

" Lightweight latex folder
" Plug 'matze/vim-tex-fold'

" Scala syntax. Also has SortScalaImports and let g:scala_scaladoc_indent = 1
Plug 'derekwyatt/vim-scala'

" ENSIME integration
" Plug 'ensime/ensime-vim'

Plug 'Chiel92/vim-autoformat'

" Plug 'luochen1990/rainbow'

" Quick fix file is not created by sbt :(
Plug '~/.vim/plugged/vim-sbt'

Plug 'reasonml-editor/vim-reason-plus'

Plug 'sk1418/HowMuch'

" Work together - apart. Only works with neovim
"Plug 'floobits/floobits-neovim'

" Show an outline / table of content of org or tex file and move things around
" Seems to conflict with vimwiki <CR> and <TAB> behavior
" Plug 'vim-voom/VOoM', {'on': ['Voom', 'VoomToggle']}

call plug#end()

"=============================================================================="
"                                   SETTINGS                                   "
"=============================================================================="
set shiftwidth=2          " Size of indentation
set textwidth=80          " Where to break text to new line
set formatoptions=qrnj    " Add t to activate automatic wrapping
set linebreak             " Vim will not break words. See :help breakat
set wrap                  " Wrap long lines softly
set showbreak=-->\        " Prefix soft-wrapped lines with these characters
set scroll=10             " number of lines for <C-D> and <C-U>
set nobackup              " do not keep a backup file
set directory=/tmp/       " Don't put swap files in local directories
set showcmd               " display incomplete commands
set number                " Activate line numbers on the left side
set relativenumber        " Hybrid relative absolute number mode
set clipboard=unnamed " Always use the overall clipboard
set hidden                " Allows to have unsaved changes in different buffers
set gdefault              " search+replace globally per default
set cmdheight=2           " Number of lines for command line
set ttyfast               " Indicate a fast terminal for smoother drawing
set pastetoggle=<F2>      " Toggles the paste option
set cursorline            " Highlight current line
set linespace=5           " Value larger than 1 avoids invisible underscores
set thesaurus=/usr/share/dict/words
set printoptions=paper:A4,syntax:y,wrap:y,number:y
"set diffopt+=vertical     " I like em vertical

" If this many milliseconds nothing is typed the swap file will be written
" Also used for CursorHold and gitgutter
set updatetime=1000

" Tabs. Note: Use :retab to clean up mixed indentation
set expandtab
set tabstop=2           " Number of spaces a <Tab> counts for
set list                " Highlight listchars in files
set listchars=tab:▸\ ,extends:#,nbsp:.,trail:⋅
" eol:¬

" Searching
set ignorecase            " Standard searches are case insensitive
set smartcase             " Case sensitive only when uppercase characters appear
set hlsearch              " Switch on highlighting the last used search pattern

" Folds
set foldmethod=indent     " Fold per default according to indent
set foldlevel=99          " Open all folds per default
set foldnestmax=99        " Number of max levels of folds overall
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldchar = ' '
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" foldexpression that matches a paragraph
set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
set foldmethod=expr

" Completion
set wildmode=longest,list  " Complete as far possible then give list
set wildignore+=*.so,*.swp,*.zip,*.git/*,*/.hg/*,*/.svn/*

" Splits
set splitbelow
set splitright

" Pretty vsplit and fold symbols
set fillchars=vert:│,fold:─
hi VertSplit      ctermbg=none ctermfg=gray

" Mouse and GUI
if has('mouse')         " Activate mouse
  set mouse=a
endif
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
set guioptions-=m       " remove menu bar in gVim
set guioptions-=T       " remove toolbar in gVim
set guioptions-=r       " remove right-hand scrollbar
set guioptions-=L       " remove left-hand scrollbar
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 14


" Highlight consistent line
if exists('+colorcolumn')
  set colorcolumn=+1
else
  " Mark as Error if no consistent line is available
  autocmd BufWinEnter * let w:m2 = matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

" Enable concealing, e.g. greek letters are shown as unicode
if has ("conceal")
  let g:conceal_active = 0
  set conceallevel=0
  set concealcursor=nc    " Stay concealed even if cursor is on line
endif

" Lines to load syntax for
syn sync maxlines=2000   " default 200
syn sync minlines=500    " default 50

"=============================================================================="
"                              KEYBOARD MAPPINGS                               "
"=============================================================================="
let mapleader = ";"

noremap ]p ]cdp
noremap [p [cdp
nnoremap d]p ]cdp
nnoremap d[p [cdp
nnoremap <Leader>dp :%diffput<CR>
au FileType diff nnoremap <Leader>do :%diffget<CR>

noremap <leader>w :w<CR>

" Toggle between highlighting line or column
nnoremap <leader>o :set cursorline! cursorcolumn!<CR>

" Clearing highlighted search
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Using left and right for adjusting indent
noremap <left> <<
noremap <right> >>
noremap <up> ddkP
nnoremap <S-up> ddggP
vnoremap <S-up> dggP
noremap <down> ddp
nnoremap <S-down> ddGp
vnoremap <S-down> dGp
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

" Delete
noremap <del> <NOP>
noremap <insert> <NOP>

" Centering
noremap <space> zz

" Center text
noremap <leader>ce :center<CR>

" Create new tab
noremap <leader>tn :tabnew <CR>

" Create a new empty buffer
noremap <leader>bn :enew <CR>

" Open new tab with directory of current file
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Open new buffer with directory of current file
noremap <leader>be :e <c-r>=expand("%:p:h")<cr>/

" Close the current buffer and move to the previous one
nnoremap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nnoremap <leader>bl :ls<CR>

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Yank from current position to end
nnoremap Y y$

" Go to the next buffer
noremap K :bnext<CR>

" Go to the last buffer
noremap J :bprevious<CR>

" Join lines and stay at the same position
noremap <leader>j mz:join<CR>`z

" Change working directory to current file
noremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Move working directory one level higher
noremap <leader>.. :cd ..<CR>:pwd<CR>

" Update biber file
nnoremap <leader>bi :exe '!biber ' . expand('%:r') . '.bcf' <CR><CR>

" Linediff two ranges
vnoremap <leader>l :Linediff<CR>

" Printing
" noremap <leader>p :hardcopy <CR>

" Put in yanked and keep it yanked
xnoremap P pgvy

" Allow full screen in GVIM
noremap <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" Don't use Ex-mode, use Q for formatting the current line (or selection)
noremap Q gq

" Add checkmark to line
noremap <leader>ch I ✓ <ESC>
" Add cross to line
noremap <leader>cr I ✗ <ESC>

" Visually select to the end of the line
nnoremap vv v$

" Show registers
nnoremap <leader>re :registers<CR>

" Strip trailing spaces in document
nnoremap <leader>st :%s/\s\+$/<CR>

" Strip traling space in selection
vnoremap <leader>st :s/\%V\s\+$/<CR>

" Remove ^M chars
noremap <leader>rm :%s/\r//g<CR>

" Reload .vimrc
nnoremap <silent> <leader>so :source $MYVIMRC<CR>

" Edit vimrc
nnoremap <silent> <leader>rc :e $MYVIMRC<CR>


nnoremap <leader>ji :%s/\(\<<c-r>=expand("<cWORD>")<cr>\>\)/[\1](https:\/\/jira.numberfour.eu\/browse\/\1)/<CR>

"=============================================================================="
"                                   AUTOCMD                                    "
"=============================================================================="
augroup load_filetypes
  autocmd!
  " Poor mans .less support. There are proper addons for this.
  autocmd BufNewFile,BufRead *.less set filetype=css

  autocmd BufNewFile,BufRead *.ejs set filetype=html

  autocmd BufNewFile,BufRead *.jnl set filetype=journal

  autocmd BufRead /tmp/mutt-* set tw=72
augroup END

" Automatically reload .vimrc upon saving it
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup reload_other
  autocmd!
  " Auto loading quick fix is quite annoying for make and navigating with ag
  autocmd QuickFixCmdPost * copen

  " Load indentexpr from fortran and switch back to noweb for syntax hl
  autocmd BufWinEnter *.nw setlocal filetype=fortran | setlocal filetype=noweb

  autocmd BufWinEnter *.tex setlocal filetype=tex

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   TOGGLES                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QuickFixToggle
" let g:quickfix_is_open = 0
" function! QuickfixToggle()
"   if g:quickfix_is_open
"     cclose
"     let g:quickfix_is_open = 0
"     execute g:quickfix_return_to_window . "wincmd w"
"   else
"     let g:quickfix_return_to_window = winnr()
"     copen
"     let g:quickfix_is_open = 1
"   endif
" endfunction
" nnoremap <leader>q :call QuickfixToggle()<CR>

" ConcealToggle
function! ConcealToggle()
  if g:conceal_active
    set conceallevel=0
    let g:conceal_active = 0
  else
    set conceallevel=2
    let g:conceal_active = 1
  endif
endfunction
nnoremap <leader>co :call ConcealToggle()<CR>

" DiffoptToggle
let g:diffignore_whitespace = 0
function! DiffoptToggle()
  if g:diffignore_whitespace
    set diffopt-=iwhite
    let g:diffignore_whitespace = 0
  else
    set diffopt+=iwhite
    let g:diffignore_whitespace = 1
  endif
endfunction
nnoremap <leader>d :call DiffoptToggle()<CR>

let g:color_toggle = 2
colorscheme monokai_pro
function! ColorSchemeToggle()
  if g:color_toggle == 1
    colorscheme solarized
    let g:color_toggle = 2
  elseif g:color_toggle == 2
    colorscheme bcn_light
    let g:color_toggle = 3
  elseif g:color_toggle == 3
    colorscheme bcn_dark
    let g:color_toggle = 4
  elseif g:color_toggle == 4
    colorscheme lucius
    let g:color_toggle = 1
    echo "solarized"
  endif
endfunction
nnoremap <leader>ts :call ColorSchemeToggle()<cr>

let g:background_toggle = 2
set background=dark
function! BackgroundToggle()
  if g:background_toggle == 1
    set background=light
    let g:background_toggle = 2
  elseif g:background_toggle == 2
    set background=dark
    let g:background_toggle = 1
  endif
endfunction
nnoremap <leader>tb :call BackgroundToggle()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               EXTRA FUNCTIONS                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fill rest of line with characters
function! FillLine( str )
  " set tw to the desired total length
  let tw = &textwidth
  if tw==0 | let tw = 80 | endif
  " strip trailing spaces first
  .s/[[:space:]]*$//
  " calculate total number of 'str's to insert
  let reps = (tw - col("$") - 4) / len(a:str)
  " insert them, if there's room, removing trailing spaces (though forcing
  " there to be one)
  if reps > 0
    .s/$/\=(' '.repeat(a:str, reps))/
  endif
endfunction
nnoremap <leader>td :call FillLine(' ')<CR>A( )<Esc>

" Show to which higroup a certain word belongs to. Indispensable for creating
" color schemes and syntax files
noremap <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Save with su rights without having started with them
if !exists('W_defined')
  let W_defined = "True"
  command W :execute 'silent w !sudo tee > /dev/null %'
  command Wq :execute ':W' | :q!
  command WQ :Wq
endif

" Sort words in visual
vnoremap <leader>o d:execute 'normal a' . join(sort(split(getreg('"'))), ' ')<CR>

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

" Show the corresponding PDF file
function! OpenPDF()
  let file_stripped = expand("%:r")
  echo system('open '.file_stripped.'.pdf')
endfunction
noremap <leader>v :call OpenPDF()<CR>

" Need to hand over visual range
function! DebugLines () range
let mycount = 0
for linenum in range(a:firstline, a:lastline)
  let mycount += 1
  let curr_line = getline(linenum)
  call setline(linenum, curr_line . DebugLine(mycount))
  call DebugLine (count)
endfor
endfunction
function! DebugLine (count)
  return "  ;   print *, '" . a:count . "' !!! Debugging"
endfunction
vnoremap <leader>d :call DebugLines ()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   SPELLING                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" word not recognized
hi SpellBad                                 ctermbg=209         cterm=undercurl
" word not capitalized
hi SpellCap                                 ctermbg=209         cterm=undercurl
" rare word
hi SpellRare                                ctermbg=209         cterm=undercurl
" wrong spelling for selected region
hi SpellLocal                               ctermbg=209         cterm=undercurl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 TOGGLE-SPELL                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Toggle English spell
nnoremap <silent> <F7> :echo ToggleSpell("en_us")<CR>
" Toggle German spell
nnoremap <silent> <F8> :echo ToggleSpell("de_de")<CR>

"=============================================================================="
"                            DISABLE HJKL MOVEMENTS                            "
"=============================================================================="
" https://gist.github.com/jeetsukumaran/96474ebbd00b874f0865
function! DisableIfNonCounted(move) range
  if v:count
    return a:move
  else
    " You can make this do something annoying like:
    " echoerr "Count required!"
    " sleep 2
    return ""
  endif
endfunction

function! SetDisablingOfBasicMotionsIfNonCounted(on)
  let keys_to_disable = get(g:, "keys_to_disable_if_not_preceded_by_count", ["j", "k"])
  if a:on
    for key in keys_to_disable
      execute "noremap <expr> <silent> " . key . " DisableIfNonCounted('" . key . "')"
    endfor
    let g:keys_to_disable_if_not_preceded_by_count = keys_to_disable
    let g:is_non_counted_basic_motions_disabled = 1
  else
    for key in keys_to_disable
      try
        execute "unmap " . key
      catch /E31:/
      endtry
    endfor
    let g:is_non_counted_basic_motions_disabled = 0
  endif
endfunction

function! ToggleDisablingOfBasicMotionsIfNonCounted()
  if get(g:, "is_non_counted_basic_motions_disabled", 0)
    call SetDisablingOfBasicMotionsIfNonCounted(0)
  else
    call SetDisablingOfBasicMotionsIfNonCounted(1)
  endif
endfunction

command! ToggleDisablingOfNonCountedBasicMotions :call ToggleDisablingOfBasicMotionsIfNonCounted()
command! DisableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(1)
command! EnableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(0)

"=============================================================================="
"                                  SYNTASTIC                                   "
"=============================================================================="
" checkers
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_fortran_checkers = [""]
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
let g:syntastic_ocaml_checkers = ['merlin']
"let g:syntastic_python_checkers = ['pep8', 'pyflakes']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_pep8_args='--max-line-length=89'
let g:syntastic_python_pylint_quiet_messages = { "level" : "warnings" }
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_scala_checkers = ['scalastyle']
let g:syntastic_scala_scalastyle_jar = '~/scalastyle_2.11-0.8.0-batch.jar'
let g:syntastic_scala_scalastyle_config_file = '~/scalastyle_config.xml'

" settings
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 0: dont jump, 1: always jump to first issue, 2: jump to first error
let g:syntastic_auto_jump = 0
" Close the error window but don't open it automatically
let g:syntastic_auto_loc_list = 2
" Height of the location lists
let g:syntastic_loc_list_height = 5

" Pretty character signs for the left border
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = 'S✗'
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = 'S⚠'

"=============================================================================="
"                                   AIR-LINE                                   "
"=============================================================================="
" Important for powerline fonts
set encoding=utf-8

" Good looking powerline
let g:airline_powerline_fonts = 1

" Super fancy tabline for tabs and buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#bufferline#enabled = 1

" Only show tail of filename if unique
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" default: (fileencoding, fileformat)
let g:airline_section_y = ''

" Control at what length the sections are truncated
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

let g:airline#extensions#tmuxline#enabled = 0

let g:airline_theme = "deus"
let g:airline_solarized_bg='dark'

"=============================================================================="
"                                    CTRLP                                     "
"=============================================================================="
" Set max file limit
let g:ctrlp_max_files = 2000

" CtrlP : only files, CtrlPBuffer : only buffer, CtrlPMRU : only recent files
nnoremap <C-P> :CtrlPMixed<CR>

" Folders to consider (a searches ffor .git, .svn, etc.)
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](_(build|install|test))|(\.(swp|ico|git|svn))|(-\d\+\.*\d*)$',
  \ 'file': '\v(\.(exe|so|dll|hepmc|yoda|mod|vg|so.0.0.0|phs|o|lo|la|f90\.in|dat))$',
  \ }

"=============================================================================="
"                                   FUGITIVE                                   "
"=============================================================================="
nnoremap <leader>gc :Gcommit -v<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>:redraw!<CR>
" TODO: (bcn 2015-05-19) Gpull doesnt work with 1.7.1...
command! -bar -nargs=* Gpurr execute 'Git pull --rebase' fugitive#head()
nnoremap <leader>gl :Gpurr<CR>:redraw!<CR>
if !exists('G_defined')
  let G_defined = "True"
  command Greview :Git! diff --staged
endif
nnoremap <leader>gr :Greview<cr>

"=============================================================================="
"                                YOUCOMPLETEME                                 "
"=============================================================================="
" Defines the max size (in Kb) for a file to be considered for completion
" let g:ycm_disable_for_files_larger_than_kb = 2000

" Query the UltiSnips plugin for possible completions of snippet triggers
" let g:ycm_use_ultisnips_completer = 1

" nnoremap <leader>gt :YcmCompleter GoTo<CR>
" nnoremap <leader>fi :YcmCompleter FixIt<CR>
" nnoremap <leader>[  <C-O>
" nnoremap <leader>]  <C-I>
"
" augroup load_ycm
"   autocmd!
"   autocmd InsertEnter,CursorHold * call plug#load('YouCompleteMe')
"         \| call youcompleteme#Enable() | autocmd! load_ycm
" augroup END
"
"  YCM's identifier completer will seed its database with keywords of language
" let g:ycm_seed_identifiers_with_syntax = 1

" Load every .ycm_extra_conf.py that you find
" let g:ycm_confirm_extra_conf = 0

"=============================================================================="
"                                  LIMELIGHT                                   "
"=============================================================================="
" Automatically enable and disable Limelight with Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Default 0.5. 1.0 blends out to white. 0.0 blends nothing.
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

nnoremap <leader>l :Limelight!!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   VIMWIKI                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimwiki_path='~/'
let vimwiki_export_path='~/www/'
let wiki_settings={
\ 'template_path': '~/vimwiki/templates/',
\ 'template_default': 'default',
\ 'template_ext': '.html',
\ 'path': '~/vimwiki/',
\ 'syntax': 'markdown',
\ 'ext': '.md',
\ 'auto_export': 1 ,
\ 'auto_toc': 1 }
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
au BufNewFile ~/vimwiki/monthly_*-*.md :silent 0r !~/bcn_scripts/bin/monthly-log.py '%'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                      AG                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher
if executable('ag')
  " Use ag over grep in vim as grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --vimgrep'
endif

" Autoclose the quickfix window
let g:ack_autoclose = 1

" TODO: (bcn 2016-03-24) also match modules
" TODO: (bcn 2016-09-09) also match public parameters
function! FindFortranObject()
  let path = system("git rev-parse --show-toplevel")
  let pattern = "'((public\|type\|function\|subroutine).* ::\|module) " . expand("<cword>") . "$'"
    execute ":Ack! " . pattern . " " . path
endfunction
function! FindAnyObject()
  let path = system("git rev-parse --show-toplevel")
  let pattern = expand("<cword>")
  execute ":Ack! --case-sensitive " . pattern . " " . path
endfunction
nnoremap <silent> <leader>ff :call FindFortranObject()<CR>
nnoremap <silent> <leader>fa :call FindAnyObject()<CR>

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! AddBibitem()
  let selection = getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]
  let cmdline = "curl -s 'https://inspirehep.net/search?p=".selection."&of=hx&em=B&sf=year&so=d' | sed '/div>\\|<div\\|pre\\|%%%\\|%%%>/d'"
  let result = system(cmdline)
  put = result
endfunction
vnoremap <silent> <leader>ab :call AddBibitem()<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                NERD-COMMENTER                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" This is actually <C-/> as well
map <C-_> :call NERDComment(0,"toggle")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                SMALL PLUGINS                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeWinSize = 50

" Gundo
nnoremap <leader>gu :GundoToggle<CR>

" Quick-Scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Merginal
" Show branches
nnoremap <leader>gb :MerginalToggle<CR>

" Gitv
noremap <leader>gv :Gitv!<CR>

" GitGutter
nnoremap <leader>glt :GitGutterLineHighlightsToggle<CR>
let g:slack_incoming_token = $SLACK_TOKEN

" BufOnly
nnoremap <leader>bo :BufOnly<CR>

" Sneak
let g:sneak#streak = 1
let g:sneak#s_next = 1
hi link SneakStreakTarget Error
hi link SneakStreakMask Comment

" TmuxLine
let g:tmuxline_preset = {
    \'a'    : '#H',
    \'b'    : "#(tmux-mem-cpu-load --interval 3 --graph-lines 3 --mem-mode 1)",
    \'c'    : '',
    \'win'  : ['#I'],
    \'cwin' : ['#I'],
    \'x'    : '',
    \'y'    : ['%a %d', '%b'],
    \'z'    : '%R'}

" Promptline
" sections (a, b, c, x, y, z, warn) are optional
let g:promptline_preset = {
      \'a' : [promptline#slices#cwd()],
      \'b' : [promptline#slices#host({'only_if_ssh': 1})],
      \'x' : [promptline#slices#git_status()],
      \'y' : [promptline#slices#vcs_branch()]}

" Goyo
let g:goyo_width=80
let g:goyo_margin_top=3
let g:goyo_margin_bottom=3
let g:goyo_linenr=0
nnoremap <leader>go :Goyo<CR>

" VimTest
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "dispatch"
let test#python#minitest#file_pattern = '\.py'
let test#python#runner = 'nose'
let g:test#python#nose#file_pattern = '.*\.py$'

" IndentGuides
let g:indent_guides_guide_size = 1      " Size of the indent guide
let g:indent_guides_start_level = 2     " Default: 1
let g:indent_guides_enable_on_vim_startup = 1

" UltiSnip
" Ensure compatibility with YouCompleteMe
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "ultisnips_my"]

" Dispatch
" Filetype specific make commands are in ~/.vim/after/ftplugin/<lang>.vim
nnoremap <leader>m :w<CR>:Make!<CR>

" Fortran
let fortran_indent_more=1           " Also indent function, subroutine, program
let g:fortran_do_enddo=1            " Guarantee that do's are matched for indent
" This includes do, if, select case, where, interface
let g:fortran_extra_structure_indent=1
let g:fortran_extra_continuation_indent=3

" NeoVim
" Avoid UltiSnip errors with python3
let g:loaded_python3_provider = 0

" LaTeX
let g:Tex_flavor = 'latex'      " Use latex per default

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               ONLINE THESAURUS                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:online_thesaurus_map_keys = 0
nnoremap <Leader>h :OnlineThesaurusCurrentWord<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                LANGUAGE TOOL                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:languagetool_jar = "~/LanguageTool-3.6/languagetool-commandline.jar"
let g:languagetool_disable_rules = "WHITESPACE_RULE,EN_QUOTES,COMMA_PARENTHESIS_WHITESPACE,EN_UNPAIRED_BRACKETS,CURRENCY,MORFOLOGIK_RULE_EN_US"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             vim-highlightedyank                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map y <Plug>(highlightedyank)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    ENSIME                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typechecking after writing
autocmd BufWritePost *.scala silent :EnTypeCheck
" Easy Type Inspection
nnoremap <leader>ty :EnType<CR>
" Go to declaration
au FileType scala nnoremap <leader>de :EnDeclaration<CR>
" Open declaration in a horizontal split
au FileType scala nnoremap <leader>ds :EnDeclarationSplit<CR>
" Open documentation in a browser
au FileType scala nnoremap <leader>do :EnDocBrowse<CR>

let ensime_server_v2=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           VIM-AUTOFORMAT SCALAFMT                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F5> :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']


au BufEnter *.scala setl formatprg=java\ -jar\ /home/bijan/bin/scalariform.jar\ -f\ -q\ -preserveSpaceBeforeArguments\ -spacesAroundMultiImports\ +doubleIndentConstructorArguments\ -placeScaladocAsterisksBeneathSecondAsterisk\ --stdin\ --stdout
au BufEnter *.scala setl equalprg=java\ -jar\ /home/bijan/bin/scalariform.jar\ -f\ -q\ -preserveSpaceBeforeArguments\ -spacesAroundMultiImports\ +doubleIndentConstructorArguments\ -placeScaladocAsterisksBeneathSecondAsterisk\ --stdin\ --stdout
au BufEnter *.scala set textwidth=120          " Where to break text to new line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   RAINBOW                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1
  let g:rainbow_conf = {
  \  'ctermfgs': ['64', '37', '33', '61', '125', '124', '166'],
  \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    CTAGS                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move up until you find tags
set tags=tags;/
map <leader>ct :!ctags -R .<CR>
nnoremap <C-g> <C-]>
vnoremap <C-g> <C-]>
" map <C-h> :tn<CR>
" map <C-f> :tp<CR>
map <leader>p :CtrlPTag<CR>
map <leader>to :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     RUST                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif 

let g:rustfmt_autosave = 1

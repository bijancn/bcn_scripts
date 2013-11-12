" ~~~~~~~~~~~~~~~~~~~~~~~~~~ BCN_DARK ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" bcn:              bijan@chokoufe.com
" Recent versions:  https://github.com/bijanc/bcn_scripts
" Last Change:      2013 Mar 15
"
" Put me in:
"             for Unix and OS/2:     ~/.vim/colors/bcn_dark.vim
"
" vim color file
" This color scheme gives you decent colors on dark background

" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "bcn_dark"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ COLORS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" Enable 256 colors
set t_Co=256

" Setting some colors for dark background. hi == highlight. 
" To see the color codes, use bcn_color_demo.vim
"hi Normal	        ctermbg=black        ctermfg=254         cterm=none
hi Normal	      ctermbg=none  ctermfg=254        cterm=none guibg=gray9 guifg=snow
hi Cursor       ctermbg=none  ctermfg=17         cterm=none guibg=blue guifg=white
"hi Cursor       ctermbg=black  ctermfg=17       cterm=None
hi iCursor      guibg=orange guifg=white
"ctermbg=17    ctermfg=white     cterm=None
hi SpecialKey	  ctermbg=None  ctermfg=70         cterm=none
hi Directory	  ctermfg=86    ctermbg=none       cterm=none
hi ErrorMsg     ctermfg=160   ctermbg=245        cterm=none
hi PreProc	    ctermbg=None  ctermfg=5          cterm=none
hi NonText	    ctermbg=None  ctermfg=105        cterm=Bold
hi Todo         ctermbg=None  ctermfg=162        cterm=Bold
hi Identifier	  ctermbg=None  ctermfg=77         cterm=none
hi Underline    ctermbg=None  ctermfg=147        cterm=Italic
hi DiffAdd    term=bold ctermbg=black ctermfg=46 guibg=black
hi DiffDelete term=bold ctermbg=black ctermfg=1  gui=bold guifg=red guibg=black
hi DiffChange term=bold ctermbg=black ctermfg=15  guibg=black
hi DiffText   term=bold ctermbg=black ctermfg=227  guibg=black

hi Conceal      ctermbg=None  ctermfg=magenta    guibg=gray9  guifg=Magenta
hi Search       ctermbg=17    ctermfg=NONE 
hi LineNr                     ctermfg=gray
hi SpellBad     ctermbg=88
hi Comment      ctermbg=none  ctermfg=lightblue  cterm=none
hi Error	      ctermbg=none  ctermfg=None       cterm=Bold guibg=gray9 guifg=white gui=bold
hi Special	    ctermbg=None  ctermfg=green      cterm=none
hi Constant	    ctermbg=None  ctermfg=1          cterm=None
hi Statement	  ctermbg=None  ctermfg=208        cterm=none
hi Ignore       ctermbg=None  ctermfg=221        cterm=Bold
hi Type		      ctermbg=None  ctermfg=227        cterm=none
hi Visual       ctermbg=238   ctermfg=250        cterm=None guibg=gray15 guifg=gray60
hi ColorColumn  ctermbg=232                                 guibg=black
hi CursorColumn ctermbg=17    ctermfg=white      cterm=NONE guibg=blue guifg=white
hi CursorLine   ctermbg=233                      cterm=none guibg=black
hi Folded       ctermbg=238   ctermfg=DarkBlue 
hi FoldColumn   ctermbg=238   ctermfg=DarkBlue 
hi Pmenu        ctermbg=238   ctermfg=DarkBlue   gui=bold   guibg=brown gui=bold
hi PmenuSel     ctermbg=232   ctermfg=DarkBlue   gui=bold   guibg=brown gui=bold
hi PmenuSbar    ctermbg=232   ctermfg=DarkBlue   gui=bold   guibg=brown gui=bold
hi PmenuThumb   ctermbg=232   ctermfg=DarkBlue   gui=bold   guibg=brown gui=bold

"hi IncSearch term=reverse cterm=reverse gui=reverse
"hi ModeMsg term=bold cterm=bold gui=bold
"hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
"hi StatusLineNC term=reverse cterm=reverse gui=reverse
"hi VertSplit term=reverse cterm=reverse gui=reverse
"hi VisualNOS term=underline,bold cterm=underline,bold gui=underline,bold
"hi lCursor guibg=Cyan guifg=NONE
"hi MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=SeaGreen
"hi Question term=standout ctermfg=DarkGreen gui=bold guifg=SeaGreen
"hi Title term=bold ctermfg=DarkMagenta gui=bold guifg=Magenta
"hi WarningMsg term=standout ctermfg=DarkRed guifg=Red
"hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black

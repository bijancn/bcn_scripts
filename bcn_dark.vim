" Vim color file
" bcn : bijan@chokoufe.com
" Last Change:	2012 Mar 7

" This color scheme gives you strong colors on black background

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

" Setting some colors for dark background. hi == highlight. To see the color
" codes, open a new buffer and :so ~/.vim/color_demo.vim
hi Normal	        ctermbg=black        ctermfg=254         cterm=none
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
hi Underline      ctermbg=None        ctermfg=147         cterm=Italic

hi Conceal        ctermbg=None        ctermfg=magenta 
hi Search         ctermbg=17          ctermfg=NONE 
hi Fold           ctermbg=black
hi LineNr                             ctermfg=gray
hi SpellBad       ctermbg=88
hi Comment        ctermbg=black       ctermfg=lightblue   cterm=none
hi Error	        ctermbg=none        ctermfg=None        cterm=Bold
hi Special	      ctermbg=None        ctermfg=green       cterm=none
"hi Special	      ctermbg=None        ctermfg=172         cterm=Bold
hi Constant	      ctermbg=None        ctermfg=1           cterm=None
hi Statement	    ctermbg=None        ctermfg=208         cterm=none
hi Ignore         ctermbg=None        ctermfg=221         cterm=Bold
hi Type		        ctermbg=None        ctermfg=227         cterm=none
hi Visual         ctermbg=238         ctermfg=250         cterm=None
hi ColorColumn    ctermbg=gray 
hi CursorColumn   ctermbg=17          ctermfg=white       cterm=NONE 
hi CursorLine     ctermbg=233                             cterm=none
hi Folded         ctermbg=238         ctermfg=DarkBlue 
hi FoldColumn     ctermbg=238         ctermfg=DarkBlue 



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
"hi DiffAdd term=bold ctermbg=LightBlue guibg=LightBlue
"hi DiffChange term=bold ctermbg=LightMagenta guibg=LightMagenta
"hi DiffDelete term=bold ctermfg=Blue ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan

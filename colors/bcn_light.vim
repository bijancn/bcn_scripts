" Vim color file
" bcn : bijan@chokoufe.com
" Last Change:	2012 Mar 7

" This color scheme gives you strong colors on white background
" Helps in bright environments, where you can't use bcn_dark

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "bcn_light"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~ COLORS ~~~~~~~~~~~~~~~~~~~~~~~~~~ 
" Enable 256 colors
set t_Co=256

" Setting some colors for dark background. hi == highlight. To see the color
" codes, open a new buffer and :so ~/.vim/color_demo.vim
hi Normal	        ctermbg=white          ctermfg=16         cterm=none
"hi Cursor         ctermbg=black       ctermfg=255        cterm=None
"hi iCursor        ctermbg=17          ctermfg=white        cterm=None
hi Directory	    ctermbg=none        ctermfg=57          cterm=None
hi ErrorMsg       ctermbg=none        ctermfg=160         cterm=None
hi NonText	      ctermbg=None        ctermfg=105         cterm=Bold
hi DiffText	      ctermbg=none         ctermfg=170         cterm=None
hi Underline      ctermbg=None        ctermfg=147         cterm=Italic
hi Conceal        ctermbg=None        ctermfg=magenta 
hi Search         ctermbg=117         ctermfg=none 
hi LineNr         ctermbg=none        ctermfg=245
hi SpellBad       ctermbg=88
hi Comment        ctermbg=none        ctermfg=33          cterm=none
hi Error	        ctermbg=none        ctermfg=None        cterm=Bold
hi Special	      ctermbg=None        ctermfg=2           cterm=none
hi Type		        ctermbg=None        ctermfg=20          cterm=none
hi PreProc	      ctermbg=None        ctermfg=91          cterm=None
hi SpecialKey	    ctermbg=None        ctermfg=22          cterm=None
hi Identifier	    ctermbg=None        ctermfg=40          cterm=none
hi Constant	      ctermbg=None        ctermfg=196         cterm=None
hi Statement	    ctermbg=None        ctermfg=202         cterm=none
hi Todo           ctermbg=None        ctermfg=162         cterm=Bold
hi Ignore         ctermbg=None        ctermfg=220         cterm=Bold
hi Visual         ctermbg=250         ctermfg=232         cterm=None
hi ColorColumn    ctermbg=245 
hi CursorColumn   ctermbg=12          ctermfg=16          cterm=NONE 
hi CursorLine     ctermbg=253                             cterm=none
hi Folded         ctermbg=249         ctermfg=17 
hi FoldColumn     ctermbg=249         ctermfg=17 

"hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
"hi StatusLineNC term=reverse cterm=reverse gui=reverse

"hi IncSearch term=reverse cterm=reverse gui=reverse
"hi ModeMsg term=bold cterm=bold gui=bold
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

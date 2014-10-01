" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/colors/bcn_light.vim - color file with strong colors on white background
"
" Copyright (C) 2014         Bijan Chokoufe Nejad         <bijan@chokoufe.com>
" Recent versions:  https://github.com/bijancn/bcn_scripts
"
" This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
" can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
" http://www.gnu.org/licenses/gpl-2.0-standalone.html
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"=========="
"  prelim  "
"=========="
" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "bcn_light"

"=========="
"  colors  "
"=========="
" Setting some colors for light background. hi == highlight.
" To see the color codes, use bcn_color_demo.vim
hi Normal	        ctermbg=white          ctermfg=233         cterm=none
" Can only be used for gvim. See vimrc for cursor customization
hi Cursor         ctermbg=black       ctermfg=255        cterm=None
hi iCursor        ctermbg=17          ctermfg=white        cterm=None
hi Directory	    ctermbg=none        ctermfg=57          cterm=None
hi ErrorMsg       ctermbg=none        ctermfg=160         cterm=None
hi NonText	      ctermbg=None        ctermfg=105         cterm=Bold
hi Underline      ctermbg=None        ctermfg=147         cterm=Italic
hi Conceal        ctermbg=None        ctermfg=magenta
hi Search         ctermbg=117         ctermfg=none
hi LineNr         ctermbg=none        ctermfg=247
hi SpellBad       ctermbg=177
hi Comment        ctermbg=none        ctermfg=33          cterm=none
hi Error	        ctermbg=none        ctermfg=None        cterm=Bold
hi Special	      ctermbg=None        ctermfg=34           cterm=none
hi Type		        ctermbg=None        ctermfg=20          cterm=none
hi PreProc	      ctermbg=None        ctermfg=54          cterm=None
hi SpecialKey	    ctermbg=None        ctermfg=22          cterm=None
hi Identifier	    ctermbg=None        ctermfg=162          cterm=none
hi Constant	      ctermbg=None        ctermfg=1         cterm=None
hi Number  	      ctermbg=None        ctermfg=9         cterm=None
hi Float  	      ctermbg=None        ctermfg=9         cterm=None
hi Statement	    ctermbg=None        ctermfg=208         cterm=none
hi Todo           ctermbg=None        ctermfg=162         cterm=Bold
hi Ignore         ctermbg=None        ctermfg=220         cterm=Bold
hi Visual         ctermbg=250         ctermfg=232         cterm=None
hi ColorColumn    ctermbg=253
hi CursorColumn   ctermbg=12          ctermfg=16          cterm=NONE
hi CursorLine     ctermbg=255                             cterm=none
hi Folded         ctermbg=254         ctermfg=17
hi FoldColumn     ctermbg=254         ctermfg=17
hi pandocEmphasis ctermfg=20          ctermbg=None    cterm=Bold
hi PmenuSel       ctermfg=black       ctermbg=255
hi Pmenu          ctermfg=black       ctermbg=250

hi DiffAdd    cterm=bold ctermfg=black ctermbg=229 gui=none guifg=bg guibg=Red
hi DiffDelete cterm=bold ctermfg=black ctermbg=229 gui=none guifg=bg guibg=Red
hi DiffChange cterm=bold ctermfg=black ctermbg=229 gui=none guifg=bg guibg=Red
hi DiffText   cterm=bold ctermfg=160 ctermbg=None gui=none guifg=bg guibg=Red

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

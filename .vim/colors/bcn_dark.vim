" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/colors/bcn_dark.vim - color file with decent colors on dark background
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
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "bcn_dark"

"=========="
"  colors  "
"=========="
" Setting some colors for dark background. hi == highlight.
" To see the color codes, use bcn_color_demo.vim
hi Normal	      ctermbg=none  ctermfg=254    cterm=none guibg=gray9 guifg=snow
" Can only be used for gvim. See vimrc for cursor customization
hi Cursor       guibg=blue guifg=white
hi iCursor      ctermbg=17    ctermfg=254    guibg=orange guifg=white
hi SpecialKey	  ctermbg=None  ctermfg=70     cterm=none
hi Directory	  ctermbg=none  ctermfg=86     cterm=none
hi ErrorMsg     ctermbg=245   ctermfg=160    cterm=none
hi PreProc	    ctermbg=None  ctermfg=5      cterm=none
hi NonText	    ctermbg=None  ctermfg=105    cterm=Bold
hi Todo         ctermbg=None  ctermfg=162    cterm=Bold
hi Identifier	  ctermbg=None  ctermfg=77     cterm=none
hi Underline    ctermbg=None  ctermfg=147    cterm=Italic
hi DiffAdd      ctermbg=232   ctermfg=46     cterm=bold guibg=black
hi DiffDelete   ctermbg=232   ctermfg=1      cterm=bold guifg=red guibg=black
hi DiffChange   ctermbg=232   ctermfg=15     cterm=bold  guibg=black
hi DiffText     ctermbg=232   ctermfg=227    cterm=bold   guibg=black
hi Conceal      ctermbg=None  ctermfg=magenta    guibg=gray9  guifg=Magenta
hi Search       ctermbg=17    ctermfg=NONE
hi LineNr                     ctermfg=gray
hi SpellBad     ctermbg=88
hi Comment      ctermbg=none  ctermfg=lightblue  cterm=none
hi Error	      ctermbg=none  ctermfg=None   cterm=Bold guibg=gray9 guifg=white gui=bold
hi Special	    ctermbg=None  ctermfg=green  cterm=none
hi Constant	    ctermbg=None  ctermfg=1      cterm=None
hi Statement	  ctermbg=None  ctermfg=208    cterm=none
hi Ignore       ctermbg=None  ctermfg=221    cterm=Bold
hi Type		      ctermbg=None  ctermfg=227    cterm=none
hi Visual       ctermbg=238   ctermfg=250    cterm=None guibg=gray15 guifg=gray60
hi ColorColumn  ctermbg=232                                 guibg=black
hi CursorColumn ctermbg=17    ctermfg=white      cterm=NONE guibg=blue guifg=white
hi CursorLine   ctermbg=232                      cterm=none guibg=black
hi Folded       ctermbg=235   ctermfg=DarkBlue
hi FoldColumn   ctermbg=235   ctermfg=DarkBlue
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

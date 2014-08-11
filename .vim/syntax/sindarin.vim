" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vim/syntax/sindarin.vim - Quite complete Whizard 2.2 sindarin syntax
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
" Remove any old syntax stuff hanging around
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
  w
endif

"=================="
"  keyword regexs  "
"=================="
syn match sindarinComment     "#.*$"
syn match sindarinComment     "!.*$"

syn keyword sindarinBoolean   false true
syn match sindarinInteger     "-\=\<[0-9]*\>"
syn match sindarinFloat       "-\=\<[0-9]*\.[0-9]*"
syn match sindarinUnit        "\(.\?eV\|degree\)"
syn match sindarinString     "\".*\""

syn match sindarinOperator	"\(\(>\|<\)=\=\|=\)"
syn match sindarinOperator	"=>"
syn match sindarinOperator	"\(+\|-\|/\|\*\)"
syn keyword sindarinOperator and or

syn match sindarinParticles	"[a-zA-Z0-9]*:[a-zA-Z0-9]*"
syn keyword sindarinLogFunc	all any no

syn keyword sindarinType cmplx int logical real stable unstable
syn keyword sindarinStatement compile as integrate simulate show echo exec expect include
syn keyword sindarinStatement if then else end read_slha write_analysis
syn keyword sindarinStatement	alias histogram plot process record scan nextgroup=sindarinProc skipwhite
syn match sindarinProc "\%(\%(alias\|histogram\|plot\|process\|record\|scan\)\s*\)\@<=\h\%(\w\|\.\)*" contained

setlocal iskeyword+=_
syn keyword sindarinIntrinsic combine eval
syn keyword sindarinBuiltin ascii athena debug epsilon hepevt hepmc lha lhapdf lhef long mokka range real_precision results short stdhep stdhep_up tiny
syn keyword sindarinSettings analysis_filename beams check_events_file check_grid_file checkpoint cuts description diags diags_color extension_ascii extension_ascii_long extension_ascii_short extension_debug extension_hepevt extension_hepmc extension_lhef fatal_beam_decay iterations keep_beams label library luminosity model n_events observable physical_unit rebuild rebuild_events recompile restrictions sample sample_format seed sqrts title tolerance vis_channels x_label y_label
syn keyword sindarinSettings allow_shower hadronization_active mlm_Rmin mlm_etamax mlm_matching mlm_nmaxMEjets mlm_ptmin ps_PYTHIA_PYGIVE ps_fsr_active ps_isr_active ps_isr_only_onshell_emitted_partons ps_isr_primordial_kt_width ps_isr_pt_ordered ps_isr_tscalefactor ps_mass_cutoff ps_max_n_flavors ps_use_PYTHIA_shower

"===================="
"  linking keywords  "
"===================="
hi def link sindarinBoolean	  Boolean
hi def link sindarinComment	  Comment
hi def link sindarinFloat	    Float
hi def link sindarinBuiltin   SpecialKey
hi def link sindarinInteger	  Number
hi def link sindarinIntrinsic Identifier
hi def link sindarinOperator	Operator
hi def link sindarinLogFunc   Function
hi def link sindarinParticles Special
hi def link sindarinProc      Identifier
hi def link sindarinSettings  Include
hi def link sindarinStatement Statement
hi def link sindarinString	  String
hi def link sindarinType      Type
hi def link sindarinUnit	    Constant

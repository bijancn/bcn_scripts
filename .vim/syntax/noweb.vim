"=============================================================================="
"                                 noweb.vim                                 "
"=============================================================================="
" bcn:              bijan@chokoufe.com
" Recent versions:  https://github.com/bijancn/bcn_scripts
" Last Change:      2014-04-27
"
" Put me in:
"             for Unix/Linux:     ~/.vim/syntax/sindarin.vim
"
" This noweb file is very specific for use with LaTeX and Fortran2003 but orders
" of magnitudes faster than the default

" Remove any old syntax stuff hanging around
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
  w
endif

" Code will only appear in chunks
syntax region codeChunk
  \ start="^<<.*>>=$" end="^@"
  \ contains=@fortran,nowebChunkName fold

" Gather the Fortran objects
syntax cluster fortran contains=fortranComment,fortranString,fortranStatement,fortranDoStatement,fortranBuiltin,fortranOperator,fortranBoolean,fortranType

" Keywords and regexes where necessary
syn match nowebChunkName contained      "^<<.*>>=$"
syn match nowebChunkName contained      "\( \|^\)<<.*>>"
syn match nowebVerbatim                 "\[\[.\{-}\]\]"
syn region latexMath                    start='\$' end='\$'
syn match latexComment                  " *%.*$"
syn match latexStatement                "\\\([a-z]\|[A-Z]\|\$\|\\\)*"

" This is only highlighted because it comes after latexStatement
syn match latexSection                  "\\chapter"
syn match latexSection                  "\\\(sub\)*section"

syn match fortranComment contained      " *!.*$"
syn match fortranString contained       "\".\{-}\""
syn match fortranString contained       "\'.\{-}\'"
syn match fortranStatement contained    "contains$"
syn match fortranStatement contained    "only:"
syn match fortranStatement contained    "^ *write"
syn match fortranStatement contained    "^ *implicit none"
syn match fortranDoName contained       "\([A-Z]\|_\)*"
syn match fortranDoStatement contained  "^\(.*: do\| *end do.*\| *exit.*\)$" contains=fortranDoName
syn keyword fortranStatement contained do else then call
syn keyword fortranStatement contained subroutine function interface module result pure elemental abstract
syn keyword fortranStatement contained return exit cycle if stop private extends import associate end print read open close inquire rewind use deallocate allocate nullify select case while
syn keyword fortranBuiltin contained present associated allocated len max min minloc minval int char trim sin cos tan sinh cosh tanh tan2 sqrt huge epsilon abs size
syn match fortranOperator	contained "\(\(>\|<\)[ =]\|=\|=>\|+\|-\|*\|/\)"
setlocal iskeyword+=.
syn keyword fortranBoolean contained .false. .true.
syn keyword fortranOperator contained .and. .or. .not.
syn keyword fortranType contained logical procedure complex public private save pointer target allocatable generic parameter optional

syn keyword fortranType	contained intent dimension type class real integer character nextgroup=fortranTy
" Special highlighting for the 'type argument'
syn match fortranTy contained "(\(\w\|=\|_\|\*\)*)"

" Linking keywords to highlighted objects
hi def link nowebChunkName     Identifier
hi def link nowebVerbatim      SpecialKey
hi def link latexMath          Special
hi def link latexSection       pandocEmphasis
hi def link latexComment	     Comment
hi def link latexStatement     Statement
hi def link fortranComment	   Comment
hi def link fortranBuiltin     SpecialKey
hi def link fortranString	     String
hi def link fortranBoolean	   Boolean
hi def link fortranOperator    Operator
hi def link fortranStatement   Statement
hi def link fortranDoStatement Statement
hi def link fortranDoName      Special
hi def link fortranType        Type
hi def link fortranTy          Include

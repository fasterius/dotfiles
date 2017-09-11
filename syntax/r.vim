" Vim syntax file
" Language:     R
" Maintainer:   Erik Fasterius <erik dot fasterius at hotmail dot com>
" URL:          https://github.com/fasterius/dotvim
" Comments:     This is the syntax highlighting file i use for my R
"               scripting. It contains some keyword highlighting for
"               some standard R functions and built-ins, and a number
"               of regex matches for other things.
" --------------------------------------------------------------------

" Use the 'marker' folding method
set foldmethod=marker

" Version 5.x: clear all syntaxes
" Version 6.x: quit when another syntax file is loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

if version >= 600
  setlocal iskeyword=@,48-57,_,.
else
  set iskeyword=@,48-57,_,.
endif

" Case sensitivity for factors
syn case match

" Definitions
"  Comments: {{{1
syn match rComment "#.*$"
syn keyword rTodo TODO ToDo Todo
" }}}
"  Constants: {{{1
syn keyword rConstant NULL NA NaN
syn keyword rBoolean TRUE FALSE
syn match rConst "\<Na's\>"
syn match rInf "-Inf\>"
syn match rInf "\<Inf\>"
" }}}
"  Dates: {{{1
syn match rDate "[0-9][0-9][0-9][0-9][-/][0-9][0-9][-/][0-9][-0-9]"
syn match rDate "[0-9][0-9][-/][0-9][0-9][-/][0-9][0-9][0-9][-0-9]"
syn match rDate "[0-9][0-9]:[0-9][0-9]:[0-9][-0-9]"
" }}}
"  Errors: {{{1
syn match rError "^Error.*"
syn match rWarning "^Warning.*"
" }}}
"  Functions: {{{1
" Matches any function that does not start with a '$'
syn match rFunction "\($.*\)\@<!\([a-zA-Z0-9_.]\+\|[a-zA-Z0-9]\+\)("me=e-1
syn match rFunction "as.[a-zA-Z]("me=e-1

" Function definitions
syn match rFunctionDef "[a-zA-Z_.]*\ =\ function("me=e-12
syn match rFunctionDef "[a-zA-Z_.]*\ <-\ function("me=e-12

" Default functions
syn match rCombine "c("me=e-1
syn keyword rInclude library require detach
syn match rImportFrom "[a-zA-Z0-9_.]*\:\:"me=e-2
syn keyword rMessage suppressMessages suppressWarnings suppressPackageStartupMessages
syn keyword rTry try tryCatch
" }}}
"  Miscellaneous: {{{1
syn match rDollar "\$"
syn match rBuiltIn "%in%"
syn match rBuiltIn "|\|&"
syn match rDplyr "%>%"

" Index of vectors
syn match rIndex /^\s*\[\d\+\]/

" Delimiters
syn match rDelimiter /[,;]/
" }}}
"  Numbers: {{{1

" Integers
syn match rInteger "\<\d\+L"
syn match rInteger "\<0x\([0-9]\|[a-f]\|[A-F]\)\+L"
syn match rInteger "\<\d\+[Ee]+\=\d\+L"

" Numbers with no fractional part or exponent
syn match rNumber "\<\d\+\>"
syn match rNegNum "-\<\d\+\>"

" Hexadecimal numbers
syn match rNumber "\<0x\([0-9]\|[a-f]\|[A-F]\)\+"

" Floating point numbers with integer and fractional parts and optional exponent
syn match rFloat "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="
syn match rNegFloat "-\<\d\+\.\d*\([Ee][-+]\=\d\+\)\="

" Floating point numbers with no integer part and optional exponent
syn match rFloat "\<\.\d\+\([Ee][-+]\=\d\+\)\="
syn match rNegFloat "-\<\.\d\+\([Ee][-+]\=\d\+\)\="

" Floating point numbers with no fractional part and optional exponent
syn match rFloat "\<\d\+[Ee][-+]\=\d\+"
syn match rNegFloat "-\<\d\+[Ee][-+]\=\d\+"

" Complex numbers
syn match rComplex "\<\d\+i"
syn match rComplex "\<\d\++\d\+i"
syn match rComplex "\<0x\([0-9]\|[a-f]\|[A-F]\)\+i"
syn match rComplex "\<\d\+\.\d*\([Ee][-+]\=\d\+\)\=i"
syn match rComplex "\<\.\d\+\([Ee][-+]\=\d\+\)\=i"
syn match rComplex "\<\d\+[Ee][-+]\=\d\+i"
" }}}
"  Statements: {{{1
syn keyword rStatement break return next
syn keyword rRepeat for while repeat in
syn keyword rConditional if else
" }}}
"  Strings: {{{1
syn region rString start=/"/ skip=/\\\\\|\\"/ end=/"/
syn region rString start=/'/ skip=/\\\\\|\\'/ end=/'/
" }}}
"  Types: {{{1
syn keyword rType S4 raw promise weakref environment externalptr closure 
syn keyword rType bytecode pairlist list symbol expression any ... 
syn keyword rType character language special complex double integer
syn keyword rType logical char builtin
" }}}

"  Set Highlighting: {{{1
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_r_syn_inits")
    if version < 508
        let did_r_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink rBoolean     Type
    HiLink rBuiltIn     Type
    HiLink rCombine     Comment
    HiLink rComment     Comment
    HiLink rComplex     Type
    HiLink rConditional Type
    HiLink rConstant    Type 
    HiLink rDate        Underlined
    HiLink rDelimiter   Normal
    HiLink rDollar      Comment
    HiLink rDplyr       Type
    HiLink rError       Error
    HiLink rFloat       Underlined
    HiLink rFunction    Identifier
    HiLink rFunctionDef PreProc
    HiLink rImportFrom  Underlined
    HiLink rInclude     Underlined
    HiLink rIndex       Underlined
    HiLink rInf         Type
    HiLink rInteger     Identifier
    HiLink rMessage     Underlined
    HiLink rNegFloat    Identifier
    HiLink rNegNum      Identifier
    HiLink rNumber      Identifier
    HiLink rRepeat      Type
    HiLink rStatement   PreProc
    HiLink rString      String
    HiLink rTodo        Todo
    HiLink rTry         Type
    HiLink rType        Type
    HiLink rWarning     Error

    delcommand HiLink
endif
" }}}

" Set current syntax to 'r'
let b:current_syntax = "r"


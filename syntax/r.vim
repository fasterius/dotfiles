" Vim syntax file
" Language:     R
" Maintainer:   Erik Fasterius <erik dot fasterius at hotmail dot com>
" URL:          https://github.com/fasterius/dotvim
" Version:      0.1.0
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

" Case sensitivity for factors
syn case match

" Definitions
" Comments {{{1
syn match rComment "\v#.*$"
syn keyword rTODO TODO ToDo
" }}}
" Conditionals {{{1
syn keyword rConditional if else
" }}}
" Constants {{{1
syn keyword rConstant NULL NA NaN
syn keyword rBoolean TRUE FALSE
syn match rConst "\<Na's\>"
syn match rInf "-Inf\>"
syn match rInf "\<Inf\>"
" }}}
" Dates and times {{{1
syn match rDate "[0-9][0-9][0-9][0-9][-/][0-9][0-9][-/][0-9][-0-9]"
syn match rDate "[0-9][0-9][-/][0-9][0-9][-/][0-9][0-9][0-9][-0-9]"
syn match rDate "[0-9][0-9]:[0-9][0-9]:[0-9][-0-9]"
" }}}
" Errors and warnings {{{1
syn match rError "^Error.*"
syn match rWarning "^Warning.*"
" }}}
" Functions {{{1
syn match rFunction "\([a-zA-Z0-9_.]\+\|[a-zA-Z0-9]\+\)("me=e-1
syn keyword rAttach library require detach
syn keyword rMessage suppressMessage suppressWarnings suppressPackageStartupMessages
syn match rVector "c("me=e-1
" }}}
" Loops and flow control {{{1
syn keyword rLoop for while repeat break next
" }}}
" Miscellaneous {{{1
syn match rMisc "\$"
syn match rBuiltIn "%in%"
syn match rBuiltIn "|\|&"

" Index of vectors
syn match rIndex /^\s*\[\d\+\]/
" }}}
" Numbers {{{1

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
" Strings {{{1
syn region rString start=/"/ skip=/\\\\\|\\"/ end=/"/ end=/$/
syn region rString start=/'/ skip=/\\\\\|\\'/ end=/'/ end=/$/
" }}}

" Set highlighting {{{1
highlight rAttach      ctermfg=13
highlight rBoolean     ctermfg=3
highlight rBuiltIn     ctermfg=3
highlight rComment     ctermfg=14
highlight rComplex     ctermfg=5
highlight rConditional ctermfg=3
highlight rConstant    ctermfg=3
highlight rDate        ctermfg=13
highlight rError       ctermfg=1
highlight rFloat       ctermfg=5
highlight rFunction    ctermfg=4
highlight rIndex       ctermfg=13
highlight rInf         ctermfg=3
highlight rInput       ctermfg=1
highlight rInteger     ctermfg=5
highlight rLoop        ctermfg=3
highlight rMessage     ctermfg=13
highlight rMisc        ctermfg=14
highlight rNegFloat    ctermfg=5
highlight rNegNum      ctermfg=5
highlight rNumber      ctermfg=5
highlight rString      ctermfg=6
highlight rTODO        ctermfg=5
highlight rVector      ctermfg=12
highlight rWarning     ctermfg=1
" }}}

" Set current syntax to 'r'
let b:current_syntax = "r"


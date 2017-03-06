" Vim syntax file
" Language:     Snakemake
" Maintainer:   Edward Liaw <ed dot liaw at gmail dot com>
" URL:          https://github.com/edliaw/vim-python
" Last Change:  2012-10-23
" Filenames:    *.py
" Version:      0.1
" ----------------------------------------------------------------------------
" Comments: {{{
" Based on the improved python3.0.vim by Dmitry Vasilev and the vim-ruby syntax
" file (github: vim-ruby/vim-ruby).
"
" TODO more easily distinguishable regex highlighting
" TODO blocks? folding?
" ----------------------------------------------------------------------------
" Features:
"     Regular expression syntax in raw strings (python_highlight_raw_regex)
"     Syntax switchable between python 2 and python 3 (python_highlight_py2)
"     Highlighting tree to make configuring easier
"     Greps identifier names (not highlighted to reduce highlighting overload)
"     Greps bracketed groups - may be handy to fold in the future
"     Highlights function calls
"     Highlights keyword arguments
"     Highlights delimiters
" ----------------------------------------------------------------------------
" Options:
"
"    To set option: let OPTION_NAME = 1
"    To clear option: unlet OPTION_NAME
"
" Option names:
"
"    To switch to python 2.x syntax highlighting:
"       python_highlight_py2
"
"    For fast machines:
"       python_slow_sync
"
"    To highlight all of the following:
"       python_highlight_common
"
"        To highlight all built-ins:
"           python_highlight_builtins
"
"            To highlight built-in objects:
"               python_highlight_builtin_objs
"
"            To highlight built-in functions:
"               python_highlight_builtin_funcs
"
"        To highlight standard exceptions:
"           python_highlight_exceptions
"
"        To highlight string formatting:
"           python_highlight_string_formatting
"
"        To highlight str.format syntax:
"           python_highlight_string_format
"
"        To highlight string.Template syntax:
"           python_highlight_string_templates
"
"        To highlight raw regex syntax:
"           python_highlight_raw_regex
"
"        To highlight indentation errors:
"           python_highlight_indent_errors
"
"        To highlight trailing spaces:
"           python_highlight_space_errors
"
"        To highlight doc-tests:
"           python_highlight_doctests
" ----------------------------------------------------------------------------
"
" }}}


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif


" Options {{{
" ===========

    if has("folding") && exists("python_fold")
        setlocal foldmethod=syntax
    endif
    if exists("python_highlight_common")
        " Not override previously set options
        if !exists("python_highlight_builtins")
            let python_highlight_builtins = 1
        endif
        if !exists("python_highlight_exceptions")
            let python_highlight_exceptions = 1
        endif
        if !exists("python_highlight_string_formatting")
            let python_highlight_string_formatting = 1
        endif
        if !exists("python_highlight_string_format")
            let python_highlight_string_format = 1
        endif
        if !exists("python_highlight_string_templates")
            let python_highlight_string_templates = 1
        endif
        if !exists("python_highlight_raw_regex")
            let python_highlight_raw_regex = 1
        endif
        if !exists("python_highlight_indent_errors")
            let python_highlight_indent_errors = 1
        endif
        if !exists("python_highlight_space_errors")
            let python_highlight_space_errors = 1
        endif
        if !exists("python_highlight_doctests")
            let python_highlight_doctests = 1
        endif
    endif
    if exists("python_highlight_builtins")
        if !exists("python_highlight_builtin_objs")
            let python_highlight_builtin_objs = 1
        endif
        if !exists("python_highlight_builtin_funcs")
            let python_highlight_builtin_funcs = 1
        endif
    endif

" }}}


" Clusters {{{
" ============

    syn cluster pythonNotTop                contains=@pythonQuotedSpecial,pythonTodo,pythonDotOperator,pythonColonOperator,pythonIndices,pythonFunction,pythonClass,pythonDecorName,pythonKwarg,pythonArgs,pythonBlockArgs,pythonBody
    syn cluster pythonData                  contains=@pythonNumeric,@pythonQuoted,@pythonIdentifier,pythonBracketed
    syn cluster pythonInterior              contains=@pythonData,pythonConditional,pythonRepeat,pythonOperator,pythonComment

    syn cluster pythonQuoted                contains=pythonString,pythonRawString,pythonBytes
    syn cluster pythonQuotedSpecial         contains=@pythonStringSpecial,@pythonRawStringSpecial,@pythonBytesSpecial,@pythonRegexSpecial,pythonRegexSet,pythonRegexSetEscape,pythonBytesEscape,pythonBytesEscapeError,pythonDocTest,pythonDocTest2

    syn cluster pythonIdentifier            contains=pythonName,pythonCallable,pythonIndexable,pythonBoolean,pythonBuiltinObj,pythonBuiltinFunc

    syn cluster pythonNumeric               contains=pythonNumber,pythonHexNumber,pythonOctNumber,pythonBinNumber,pythonNumberError

" }}}


" Comments {{{
" ============

    syn match   pythonComment   "#.*$" display contains=pythonTodo,@Spell
    syn match   pythonSharpBang "\%^#!.*$" display
    syn match   pythonCoding    "\%^.*\%(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
    syn keyword pythonTodo      TODO FIXME XXX contained

" }}}


" Keywords {{{
" ============

    syn keyword pythonStatement         break continue pass return yield
    syn keyword pythonStatement         global nonlocal
    syn keyword pythonStatement         del
    syn keyword pythonStatement         lambda
    syn keyword pythonStatement         with as from

    syn keyword pythonConditional       if elif else
    syn keyword pythonRepeat            for while
    syn keyword pythonOperator          and in is not or
    syn keyword pythonException         try finally assert
    syn keyword pythonException         except raise nextgroup=pythonExClass skipwhite
    syn keyword pythonPreProc           import

    syn keyword pythonDefine            def nextgroup=pythonFunction skipwhite
    syn keyword pythonDefine            class nextgroup=pythonClass skipwhite

    if exists("python_highlight_py2")
        syn keyword pythonStatement     exec print
    endif

" }}}


" Identifiers {{{
" ===============

    syn match   pythonName              "\<\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\.\)*\zs\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\>" display contains=pythonDotOperator
    syn match   pythonDotOperator       "\." display contained

    " Bracketed values
    syn region  pythonBracketed         matchgroup=pythonBrackets start=+(+ end=+)+ contains=@pythonInterior
    syn region  pythonBracketed         matchgroup=pythonBrackets start=+\[+ end=+\]+ contains=@pythonInterior
    syn region  pythonBracketed         matchgroup=pythonBrackets start=+{+ end=+}+ contains=@pythonInterior,pythonColonOperator
    syn match   pythonColonOperator     ":" display contained

    " Indexed names
    syn match   pythonIndexable         "\<\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\.\)*\zs\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\ze\s*\[" display contains=pythonDotOperator nextgroup=pythonIndices
    syn region  pythonIndices           matchgroup=pythonBrackets start=+\[+ end=+\]+ contains=@pythonData nextgroup=pythonIndices contained

    " Functions
    syn match   pythonCallable          "\<\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\.\)*\zs\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\ze\s*(" display contains=pythonDotOperator nextgroup=pythonArgs skipwhite
    syn match   pythonFunction          "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display nextgroup=pythonBlockArgs skipwhite contained

    " Classes
    syn match   pythonClass             "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display nextgroup=pythonBlockArgs skipwhite contained

    " Blocks
    syn match   pythonKwarg             "\<\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\ze\s*=" display contains=pythonDotOperator contained
    syn region  pythonArgs              matchgroup=pythonBrackets start=+(+ end=+)+ contains=@pythonInterior,pythonKwarg contained
    syn region  pythonBlockArgs         matchgroup=pythonBrackets start=+(+ end=+)+ contains=@pythonData,pythonKwarg nextgroup=pythonBody skipwhite contained
    "syn region  pythonBody              start=+:\zs$+ end=+^\ze\S+ contains=ALLBUT,@pythonNotTop contained fold

" }}}


" Decorators {{{
" ==============

    syn match   pythonDecorator         "@" display nextgroup=pythonDecorName skipwhite
    syn match   pythonDecorName         "\<\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\.\)*\zs\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\>" display contains=pythonDotOperator contained
    
" }}}


" Strings {{{
" ===========

    " Clustered
    syn cluster pythonStringSpecial     contains=pythonStrEscape,pythonStrEscapeError,pythonStrFormatting,pythonStrFormat,pythonStrFormatEscape,pythonStrTemplate,pythonStrTemplateEscape
    syn cluster pythonRawStringSpecial  contains=pythonStrFormatting,pythonStrFormat,pythonStrFormatEscape,pythonStrTemplate,pythonStrTemplateEscape,@pythonRegexSpecial
    syn cluster pythonBytesSpecial      contains=pythonBytesContent,pythonBytesError
    syn cluster pythonQBlockSpecial     contains=pythonDocTest,pythonSpaceError
    syn cluster pythonQBlock2Special    contains=pythonDocTest2,pythonSpaceError
    syn cluster pythonRegexSpecial      contains=pythonRegex,pythonRegexEscape,pythonRegexBracketed,pythonRegexComment

    " Strings
    syn region  pythonString            matchgroup=pythonStringDelimiter start=+u\='+ skip=+\\\\\ze.\|\\'\ze.+ excludenl end=+'+ end=+\%(\\\\\|[^\\]\)\zs$+ keepend contains=@pythonStringSpecial,@Spell
    syn region  pythonString            matchgroup=pythonStringDelimiter start=+u\="+ skip=+\\\\\ze.\|\\"\ze.+ excludenl end=+"+ end=+\%(\\\\\|[^\\]\)\zs$+ keepend contains=@pythonStringSpecial,@Spell
    syn region  pythonString            matchgroup=pythonStringDelimiter start=+u\='''+ skip=+\\\\\|\\'+ end=+'''+ keepend contains=@pythonStringSpecial,@pythonQBlockSpecial,@Spell
    syn region  pythonString            matchgroup=pythonStringDelimiter start=+u\="""+ skip=+\\\\\|\\"+ end=+"""+ keepend contains=@pythonStringSpecial,@pythonQBlock2Special,@Spell

    syn match   pythonStrEscape         +\\[abfnrtv'"\\]+ display contained
    syn match   pythonStrEscape         "\\\o\o\=\o\=" display contained
    syn match   pythonStrEscapeError    "\\\o\{,2}[89]" display contained
    syn match   pythonStrEscape         "\\x\x\{2}" display contained
    syn match   pythonStrEscapeError    "\\x\x\=\X" display contained
    syn match   pythonStrEscape         "\\$"
    syn match   pythonStrEscape         "\\u\x\{4}" display contained
    syn match   pythonStrEscapeError    "\\u\x\{,3}\X" display contained
    syn match   pythonStrEscape         "\\U\x\{8}" display contained
    syn match   pythonStrEscapeError    "\\U\x\{,7}\X" display contained
    syn match   pythonStrEscape         "\\N{[A-Z ]\+}" display contained
    syn match   pythonStrEscapeError    "\\N{[^A-Z ]\+}" display contained

    " Raw strings
    syn region  pythonRawString         matchgroup=pythonRawStrDelimiter start=+[bB]\=[rR]'+ skip=+\\\\\ze.\|\\'\ze.+ excludenl end=+'+ end=+\%(\\\\\|[^\\]\)\zs$+ keepend contains=@pythonRawStringSpecial,pythonRawEscape,@Spell
    syn region  pythonRawString         matchgroup=pythonRawStrDelimiter start=+[bB]\=[rR]"+ skip=+\\\\\ze.\|\\"\ze.+ excludenl end=+"+ end=+\%(\\\\\|[^\\]\)\zs$+ keepend contains=@pythonRawStringSpecial,pythonRawEscape,@Spell
    syn region  pythonRawString         matchgroup=pythonRawStrDelimiter start=+[bB]\=[rR]'''+ skip=+\\\\\|\\'+ end=+'''+ keepend contains=@pythonQBlockSpecial,@Spell
    syn region  pythonRawString         matchgroup=pythonRawStrDelimiter start=+[bB]\=[rR]"""+ skip=+\\\\\|\\"+ end=+"""+ keepend contains=@pythonQBlock2Special,@Spell

    syn match   pythonRawEscape         +\\['"]+ display transparent contained

    " Bytes
    syn region  pythonBytes             matchgroup=pythonBytesDelimiter start=+[bB]'+ skip=+\\\\\ze.\|\\'\ze.+ excludenl end=+'+ end=+\%(\\\\\|[^\\]\)\zs$+ keepend contains=@pythonBytesSpecial,@Spell
    syn region  pythonBytes             matchgroup=pythonBytesDelimiter start=+[bB]"+ skip=+\\\\\ze.\|\\"\ze.+ excludenl end=+"+ end=+\%(\\\\\|[^\\]\)\zs$+ keepend contains=@pythonBytesSpecial,@Spell
    syn region  pythonBytes             matchgroup=pythonBytesDelimiter start=+[bB]'''+ skip=+\\\\\|\\'+ end=+'''+ keepend contains=@pythonBytesSpecial,@pythonQBlockSpecial,@Spell
    syn region  pythonBytes             matchgroup=pythonBytesDelimiter start=+[bB]"""+ skip=+\\\\\|\\"+ end=+"""+ keepend contains=@pythonBytesSpecial,@pythonQBlock2Special,@Spell

    syn match   pythonBytesError        ".\+" display contained
    syn match   pythonBytesContent      "[\u0000-\u00ff]\+" display contained contains=pythonBytesEscape,pythonBytesEscapeError

    syn match   pythonBytesEscape       +\\[abfnrtv'"\\]+ display contained
    syn match   pythonBytesEscape       "\\\o\o\=\o\=" display contained
    syn match   pythonBytesEscapeError  "\\\o\{,2}[89]" display contained
    syn match   pythonBytesEscape       "\\x\x\{2}" display contained
    syn match   pythonBytesEscapeError  "\\x\x\=\X" display contained
    syn match   pythonBytesEscape       "\\$"

    if exists("python_highlight_string_formatting")
        " String formatting
        syn match   pythonStrFormatting "%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained
        syn match   pythonStrFormatting "%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained
    endif

    if exists("python_highlight_string_format")
        " str.format syntax
        syn match   pythonStrFormatEscape       "{{\|}}" display contained
        syn match   pythonStrFormat             "{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" display contained
    endif

    if exists("python_highlight_string_templates")
        " String templates
        syn match   pythonStrTemplateEscape     "\$\$" display contained
        syn match   pythonStrTemplate           "\${\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*}" display contained
        syn match   pythonStrTemplate           "\$\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
    endif

    if exists("python_highlight_raw_regex")
        " Regular expression syntax
        syn match   pythonRegex                 "[\.\^\$\*+|]" display contained
        syn match   pythonRegex                 "\\[1-9]" display contained
        syn match   pythonRegex                 "\\[AbBdDsSwWZ]" display contained
        syn match   pythonRegexEscape           "\\[afnrtv.^$*+?\\\[\]|()]" display contained

        " Character sets
        syn region  pythonRegexBracketed        matchgroup=pythonRegexBrackets start=+\[\^\=\]\=+ end=+\]+ contains=pythonRegexSet,pythonRegexSetEscape display contained
        syn match   pythonRegexSet              "\\[AbBdDsSwWZ]" display contained
        syn match   pythonRegexSetEscape        +\\[afnrtv'"\-\\\]]+ display contained

        " Match groups
        syn region  pythonRegexBracketed        matchgroup=pythonRegexBrackets start=+(+ end=+)+ contains=@pythonRegexSpecial display contained
        syn region  pythonRegexBracketed        matchgroup=pythonRegexBrackets start="(?[iLmsux]\+" end=+)+ contains=@pythonRegexSpecial display contained
        syn region  pythonRegexBracketed        matchgroup=pythonRegexBrackets start=+(?\%([:=!]\|<=\)+ end=+)+ contains=@pythonRegexSpecial display contained
        syn region  pythonRegexBracketed        matchgroup=pythonRegexBrackets start=+(?P<\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\)*>+ end=+)+ contains=@pythonRegexSpecial display contained
        syn region  pythonRegexBracketed        matchgroup=pythonRegexBrackets start=+(?P=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\)*+ end=+)+ contains=@pythonRegexSpecial display contained

        syn region  pythonRegexComment          matchgroup=pythonRegexBrackets start=+(?#+ end=+)+ display contained

    endif

    if exists("python_highlight_doctests")
        " DocTests
        syn region  pythonDocTest       start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
        syn region  pythonDocTest2      start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained
    endif
    
" }}}


" Numbers {{{
" ===========

    syn match   pythonHexNumber             "\<0[xX]\x\+\>" display
    syn match   pythonOctNumber             "\<0[oO]\o\+\>" display
    syn match   pythonBinNumber             "\<0[bB][01]\+\>" display

    syn match   pythonFloat                 "\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
    syn match   pythonFloat                 "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
    syn match   pythonFloat                 "\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

    syn match   pythonHexError              "\<0[xX]\x*\X\+.*\>" display
    syn match   pythonOctError              "\<0[oO]\=\o*[8-9]\+.*\>" display
    syn match   pythonBinError              "\<0[bB][01]*[2-9]\+.*\>" display

    if exists("python_highlight_py2")
        syn match   pythonHexNumber         "\<0[xX]\x\+[lL]\>" display
        syn match   pythonOctNumber         "\<0[oO]\o\+[lL]\>" display
        syn match   pythonBinNumber         "\<0[bB][01]\+[lL]\>" display

        syn match   pythonNumber            "\<\d\+[lLjJ]\=\>" display
    else
        syn match   pythonNumberError       "\<\d\+\D.*\>" display
        syn match   pythonNumberError       "\<0\d\+\>" display
        syn match   pythonNumber            "\<\d\>" display
        syn match   pythonNumber            "\<[1-9]\d\+\>" display
        syn match   pythonNumber            "\<\d\+[jJ]\>" display
    endif

" }}}


" Builtins {{{
" ============

    " Built-in objects and types
    if exists("python_highlight_builtin_objs")
        syn keyword pythonBoolean       True False
        syn keyword pythonBuiltinObj    Ellipsis None NotImplemented
        syn keyword pythonBuiltinObj    __debug__ __doc__ __file__ __name__ __package__
        syn keyword pythonBuiltinObj    self
    endif

    " Built-in functions
    if exists("python_highlight_builtin_funcs")
        syn keyword pythonBuiltinFunc           __import__ abs all any
                                                \ bin bool bytearray
                                                \ callable chr classmethod compile complex
                                                \ delattr dict dir divmod
                                                \ enumerate eval
                                                \ filter float format frozenset
                                                \ getattr globals hasattr hash hex
                                                \ id input int isinstance issubclass iter
                                                \ len list locals
                                                \ map max min next
                                                \ object oct open ord pow property
                                                \ range repr reversed round
                                                \ set setattr slice sorted
                                                \ staticmethod str sum super
                                                \ tuple type vars zip
                                                \ nextgroup=pythonArgs skipwhite

        if exists("python_highlight_py2")
            syn keyword pythonBuiltinFunc       apply basestring buffer cmp coerce
                                                \ execfile file intern long
                                                \ raw_input reduce reload
                                                \ unichr unicode vars xrange
                                                \ nextgroup=pythonArgs skipwhite
        else
            syn keyword pythonBuiltinFunc       ascii bytes exec print memoryview
                                                \ nextgroup=pythonArgs skipwhite
        endif
    endif

    " Snakemake
    syn keyword snakeStatement          input params output message threads run resources shell
    syn keyword snakePreProc            include workdir
    syn keyword snakeDefine             rule

    " Built-in exceptions and warnings
    if exists("python_highlight_exceptions")
        "syn match   pythonExClass             "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained

        syn keyword pythonExClass       BaseException
                                        \ Exception ArithmeticError BufferError
                                        \ LookupError
                                        \ AssertionError AttributeError EOFError
                                        \ FloatingPointError GeneratorExit ImportError
                                        \ IndexError KeyError KeyboardInterrupt
                                        \ MemoryError NameError NotImplementedError
                                        \ OSError OverflowError ReferenceError
                                        \ RuntimeError StopIteration SyntaxError
                                        \ IndentationError TabError SystemError
                                        \ SystemExit TypeError UnboundLocalError
                                        \ UnicodeError UnicodeEncodeError
                                        \ UnicodeDecodeError UnicodeTranslateError
                                        \ ValueError ZeroDivisionError
                                        \ nextgroup=pythonArgs skipwhite

        syn keyword pythonExClass       EnvironmentError IOError VMSError
                                        \ WindowsError
                                        \ nextgroup=pythonArgs skipwhite

        syn keyword pythonExClass       Warning UserWarning DeprecationWarning
                                        \ PendingDepricationWarning SyntaxWarning RuntimeWarning
                                        \ FutureWarning ImportWarning UnicodeWarning
                                        \ BytesWarning
                                        \ nextgroup=pythonArgs skipwhite

        if exists("python_highlight_py2")
            syn keyword pythonExClass   StandardError nextgroup=pythonArgs skipwhite
        else
            syn keyword pythonExClass   ResourceWarning nextgroup=pythonArgs skipwhite

            syn keyword pythonExClass   BlockingIOError ChildProcessError ConnectionError
                                        \ BrokenPipeError ConnectionAbortedError ConnectionRefusedError
                                        \ ConnectionResetError
                                        \ FileExistsError FileNotFoundError InterruptedError
                                        \ IsADirectoryError NotADirectoryError PermissionError
                                        \ ProcessLookupError TimeoutError
                                        \ nextgroup=pythonArgs skipwhite
        endif
    endif

" }}}


" Errors {{{
" ==========

    syn match   pythonError             "[$?]" display
    syn match   pythonError             "[&|]\{2,}" display
    syn match   pythonError             "[=]\{3,}" display

    " Indent errors (mixed space and tabs)
    if exists("python_highlight_indent_errors")
        syn match   pythonIndentError   "^\s*\%( \t\|\t \)\s*\ze\S" display
    endif

    " Trailing space errors
    if exists("python_highlight_space_errors")
        syn match   pythonSpaceError    "\s\+$" display
    endif

" }}}


" Sync {{{
" ========

    if exists("python_slow_sync")
        syn sync minlines=2000
    else
        " This is fast but code inside triple quoted strings screws it up. It
        " is impossible to fix because the only way to know if you are inside a
        " triple quoted string is to start from the beginning of the file.
        syn sync match pythonSync grouphere NONE "):$"
        syn sync maxlines=200
    endif

" }}}


" Highlight {{{
" =============

    " Highlighting root
    hi def link  pythonComment                  Comment
    hi def link  pythonSharpBang                SpecialComment
    hi def link  pythonCoding                   SpecialComment
    hi def link  pythonTodo                     Todo

    hi def link  pythonStatement                Statement
    hi def link  pythonConditional              Conditional
    hi def link  pythonRepeat                   Repeat
    hi def link  pythonOperator                 Operator
    hi def link  pythonException                Exception
    hi def link  pythonPreProc                  PreProc
    hi def link  pythonDefine                   Statement

    hi def link  pythonDelimiter                Delimiter

    hi def link  pythonName                     Normal
    hi def link  pythonCallable                 Normal
    hi def link  pythonBracketed                NONE
    hi def link  pythonFunction                 Function
    hi def link  pythonClass                    Typedef
    hi def link  pythonKwarg                    NONE
    hi def link  pythonBuiltinObj               Identifier
    hi def link  pythonBuiltinFunc              Identifier

    hi def link  pythonQuoted                   String
    hi def link  pythonRegexBracketed           NONE
    hi def link  pythonEscape                   SpecialChar
    hi def link  pythonStringSpecial            Special

    hi def link  pythonNumber                   Number
    hi def link  pythonFloat                    Float
    hi def link  pythonBoolean                  Boolean

    hi def link  pythonError                    Error

    " Inherits from above
    hi def link  snakeStatement                 pythonStatement
    hi def link  snakeDefine                    pythonDefine
    hi def link  snakePreProc                   pythonPreProc

    hi def link  pythonDotOperator              pythonOperator
    hi def link  pythonColonOperator            pythonOperator

    hi def link  pythonIndexable                pythonName
    hi def link  pythonBrackets                 pythonDelimiter
    hi def link  pythonArgs                     pythonBracketed
    hi def link  pythonBlockArgs                pythonArgs

    hi def link  pythonDecorator                pythonDelimiter
    hi def link  pythonDecorName                pythonCallable

    hi def link  pythonString                   pythonQuoted
    hi def link  pythonRawString                pythonQuoted
    hi def link  pythonBytes                    pythonQuoted
    hi def link  pythonBytesContent             pythonQuoted
    hi def link  pythonRegexComment             pythonComment

    hi def link  pythonStringDelimiter          pythonDelimiter
    hi def link  pythonRawStrDelimiter          pythonDelimiter
    hi def link  pythonBytesDelimiter           pythonDelimiter
    hi def link  pythonRegexBrackets            pythonDelimiter

    hi def link  pythonStrEscape                pythonEscape
    hi def link  pythonBytesEscape              pythonEscape
    hi def link  pythonStrFormatEscape          pythonEscape
    hi def link  pythonStrTemplateEscape        pythonEscape
    hi def link  pythonRegexEscape              pythonEscape
    hi def link  pythonRegexSetEscape           pythonEscape

    hi def link  pythonBytesError               pythonError
    hi def link  pythonStrEscapeError           pythonError
    hi def link  pythonBytesEscapeError         pythonError

    hi def link  pythonStrFormatting            pythonStringSpecial
    hi def link  pythonStrFormat                pythonStringSpecial
    hi def link  pythonStrTemplate              pythonStringSpecial
    hi def link  pythonRegex                    pythonStringSpecial
    hi def link  pythonRegexSet                 pythonStringSpecial

    hi def link  pythonDocTest                  SpecialComment
    hi def link  pythonDocTest2                 pythonDocTest

    hi def link  pythonHexNumber                pythonNumber
    hi def link  pythonOctNumber                pythonNumber
    hi def link  pythonBinNumber                pythonNumber
    hi def link  pythonNumberError              pythonError
    hi def link  pythonOctError                 pythonError
    hi def link  pythonHexError                 pythonError
    hi def link  pythonBinError                 pythonError

    hi def link  pythonExClass                  pythonBuiltinObj

    hi def link  pythonNameError                pythonError
    hi def link  pythonIndentError              pythonError
    hi def link  pythonSpaceError               pythonError

" }}}

let b:current_syntax = "python"

" Vim syntax file
" Language:	        Nextflow (extended from groovy.vim)
" Original Version:	Luke Goodsell
" Maintainer:       Erik Fasterius (erik.fasterius@outlook.com)

if exists("b:current_syntax")
  finish
endif

" Load seetings from system groovy.vim
source $VIMRUNTIME/syntax/groovy.vim

" Nextflow specifics
syn keyword nextflowDirective afterScript beforeScript cache container cpus
syn keyword nextflowDirective clusterOptions disk echo errorStrategy executor
syn keyword nextflowDirective ext label maxErrors maxForks maxRetries memory
syn keyword nextflowDirective module penv publishDir queue scratch storeDir
syn keyword nextflowDirective stageInMode stageOutMode tag time validExitStatus
syn keyword nextflowKeyword from into
syn keyword nextflowType Channel file path process tuple val
syn keyword nextflowSpecial workflow params launchDir
syn keyword nextflowConstant null
syn match nextflowBlock "\v(input|output|script|shell|exec):"
syn match nextflowELExpr "\!{.\{-}}" contained
syn region nextflowBlockString start=+'''+ keepend end=+'''+
    \ contains=groovySpecialChar,groovySpecialError,@Spell,nextflowELExpr,@shell

" Apply highlighting
let b:current_syntax = "nextflow"
hi def link nextflowELExpr            Identifier
hi def link groovyELExpr              Identifier
hi def link nextflowConstant          Constant
hi def link nextflowDirective         Statement
hi def link nextflowKeyword           Operator
hi def link nextflowType              Type
hi def link nextflowSpecial           Special
hi def link nextflowBlock             Function
hi def link nextflowBlockString       String

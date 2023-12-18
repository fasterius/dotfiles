" Vim syntax file
" Language: Nextflow
" Maintainer: Erik Fasterius
" Latest Revision: 18 March 2022

if exists("b:current_syntax")
  finish
endif

" Groovy-based syntax
source $VIMRUNTIME/syntax/groovy.vim

syn region nextflowBlockString start=+'''+ keepend end=+'''+ contains=groovySpecialChar,groovySpecialError,@Spell,nextflowELExpr,@shell

syn match nextflowELExpr "\!{.\{-}}" contained

" Nextflow-specific keywords
syn keyword nextflowDirective accelerator afterScript beforeScript cache cpus
syn keyword nextflowDirective conda container containerOptions clusterOptions
syn keyword nextflowDirective disk echo errorStrategy executor ext label
syn keyword nextflowDirective machineType maxErrors maxForks maxRetries memory
syn keyword NextflowDirective module penv pod publishDir queue scratch
syn keyword nextflowDirective StageInMode stageOutMode storeDir tag time
syn keyword nextflowDirective validExitStatus
syn keyword nextflowType      set tuple file val env path from fromPath first
syn keyword nextflowType      fromFilePairs toList splitCsv map view out mix
syn keyword nextflowType      groupTuple splitText ifEmpty unique join branch
syn keyword nextflowKeyword   into as nextflow params
syn keyword nextflowBoolean   true false
syn keyword nextflowSpecial   include Channel channel launchDir process workflow
syn keyword nextflowConstant  null

" Nextflow-specific matches
syn match nextflowBlock "\v(input|output|script|shell|exec|stub|when):"
syn match nextflowProcessOptions "\v(mode|enabled|emit|optional):"

" Apply highlighting
let b:current_syntax = "nextflow"

hi def link nextflowELExpr            Identifier
hi def link groovyELExpr              Identifier
hi def link nextflowConstant          Constant
hi def link nextflowBoolean			  Boolean
hi def link nextflowDirective         Statement
hi def link nextflowKeyword           Keyword
hi def link nextflowFunction		  Function
hi def link nextflowProcessOptions 	  Define
hi def link nextflowType              Type
hi def link nextflowComment			  Comment
hi def link nextflowSpecial           Special
hi def link nextflowBlock             Function
hi def link nextflowBlockString       String

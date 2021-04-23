" Vim syntax file
" Language:	        Snakemake (extended from python.vim)
" Original Version:	Jay Hesselberth (jay.hesselberth@gmail.com)
" Maintainer:       Erik Fasterius (erik.fasterius@outlook.com)
" Last Change:	    2020 March 19

" load settings from system python.vim
source $VIMRUNTIME/syntax/python.vim

" Snakemake rules
" rule       = "rule" (identifier | "") ":" ruleparams
" include    = "include:" stringliteral
" workdir    = "workdir:" stringliteral
" input      = "input" ":" parameter_list
" output     = "output" ":" parameter_list
" params     = "params" ":" parameter_list
" group	     = "group" ":" parameter_list
" message    = "message" ":" stringliteral
" threads    = "threads" ":" integer
" resources  = "resources" ":" parameter_list
" version    = "version" ":" statement
" run        = "run" ":" ni statement
" shell      = "shell" ":" stringliteral

syn keyword pythonStatement	include workdir onsuccess onerror
syn keyword pythonStatement	ruleorder localrules configfile
syn keyword pythonStatement	touch protected temp wrapper
syn keyword pythonStatement	input output params group message threads
syn keyword pythonStatement	resources version run shell benchmark snakefile
syn keyword pythonStatement	log script priority
syn keyword pythonStatement	rule subworkflow nextgroup=pythonFunction skipwhite

" Similar to special def and class treatment from python.vim,
" except parenthetical part of def and class
syn match pythonFunction
    \ "\%(\%(rule\s\|subworkflow\s\)\s*\)\@<=\h\w*" contained

syn sync match pythonSync
    \ grouphere NONE "^\s*\%(rule\|subworkflow\)\s\+\h\w*\s*"

let b:current_syntax = "snakemake"

"  Vim Run Commands file
"  Author:  Erik Fasterius <erik dot fasterius at outlook dot com>
"  URL:     https://github.com/fasterius/dotvim

" Backups: {{{1

" Backups in '~/.vim/tmp' folder
set backup
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Store undo data in a file
set undofile

" Filetypes: {{{1

" Enable filetype detection and filetype-specific indentation/plugins
filetype plugin indent on

" Autocommands for filetypes
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead Snakefile,*.smk set filetype=snakemake
    autocmd BufNewFile,BufRead *.R,*.r set filetype=r
    autocmd BufNewFile,BufRead *.Rnw,*.rnw set filetype=rnoweb
    autocmd BufNewFile,BufRead *.py set filetype=python
    autocmd BufNewFile,BufRead *bash* let g:is_bash=1
    autocmd BufNewFile,BufRead *bash* set filetype=sh
    autocmd BufNewFile,BufRead nextflow.config set filetype=java
    autocmd BufNewFile,BufRead *.nf set filetype=nextflow
    autocmd BufNewFile,BufRead *.def set filetype=singularity
    autocmd BufNewFile,BufRead Dockerfile,*.dockerfile,.dockerignore
        \ set filetype=dockerfile
augroup END

" Autocommands for filetype commentstrings
augroup commentstrings
    autocmd FileType r set commentstring=#\ %s
    autocmd FileType rmd set commentstring=#\ %s
    autocmd FileType rmarkdown set commentstring=#\ %s
    autocmd FileType singularity set commentstring=#\ %s
augroup END

" Autocommands for filetype foldmethods
augroup folding
    autocmd FileType r set foldmethod=syntax
    autocmd FileType r set foldnestmax=1
    autocmd FileType rmd set foldmethod=expr
    autocmd FileType rmarkdown set foldmethod=expr
    autocmd FileType snakemake set foldmethod=indent
    autocmd FileType snakemake set foldnestmax=1
    autocmd FileType nextflow set foldmethod=indent
    autocmd FileType nextflow set foldnestmax=1
augroup END

" Autocommand for syntax syncing methods
augroup syntaxsync
    autocmd BufEnter *.nf :syntax sync fromstart
augroup END

" Folding: {{{1

" Enable FastFold
let g:markdown_folding = 1
let g:r_syntax_folding = 1

" Folding for vim-pandoc
let g:pandoc#folding#mode = 'expr'  " Use expression folding
let g:pandoc#folding#fold_yaml = 1  " Fold the YAML header
let g:pandoc#folding#fold_fenced_codeblocks = 1  " Fold R code chunks
let g:pandoc#folding#fastfolds = 1  " Use FastFolds for Pandoc folding

" General Key Mappings: {{{1

" Set leaders
let maplocalleader=','
let mapleader="\<SPACE>"

" Replace all occurences of word underneath the cursor
map <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Open VIMRC file for editing
nmap <Leader>V :sp <CR> :e $MYVIMRC <CR>

" Re-source VIMRC
nmap <Leader>v :source $MYVIMRC <CR>

" Markdown And LaTeX: {{{1

" Render current Markdown to HTML and open
nmap <LocalLeader>P
    \ :w!<CR>
    \ :w!/tmp/vim-markdown.md<CR>
    \ :!pandoc -s -f markdown -t html
        \ -o /tmp/vim-markdown.html
        \ /tmp/vim-markdown.md<CR>
    \ :!open -a firefox /tmp/vim-markdown.html
        \ > /dev/null 2> /dev/null &<CR><CR>

" Compile current LaTeX to PDF and open
nmap <LocalLeader>L
    \ :w!<CR>
    \ :!pdflatex "%:p" <CR>
    \ :!open "%:p:r.pdf" <CR><CR>

" Miscellaneous: {{{1

" Make <BACKSPACE> work as normal
set backspace=indent,eol,start

" Show commands
set showcmd

" Add line numbers
set number

" Add background highlight to current line
set cursorline

" Wrap lines at 80 characters
set textwidth=80
set formatoptions+=t

" Use the same indentation as currently on for new lines
set autoindent

" Use UTF-8 encoding
set encoding=utf-8

" Movements: {{{1

" Disable arrow key mappings for normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Disable arrow key mappings for insert mode
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Move by visual lines instead of physical lines
nnoremap j gj
nnoremap k gk

" Always keep at least 5 lines above/below scrolling visible
set scrolloff=5

" Plugins: {{{1

" Use vim-plug for plugin management
" (The use of a specific commit for YouCompleteMe is due to subsequent commits
" requiring Mac OSX 10.15 and breaks systems using previous versions)
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'jpalardy/vim-slime'
Plug 'Konfekt/FastFold'
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rbberger/vim-singularity-syntax'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'commit': '14f0d3968c43be7edde15aa67bc600c3998cae16', 'do': 'python3 install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'wellle/targets.vim'
call plug#end()

" Colour scheme
set background=light  " Light background
set t_Co=16  " 16 bit colours
colorscheme solarized  " Solarized colours

" Parentheses
let g:rainbow_active=1  " Use rainbow parentheses
set showmatch  " Show matching parenthesis on cursor hovering

" Status bar
let g:airline_theme='solarized'  " Solarized theme
set laststatus=2  " Status bar is always on

" UltiSnips
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger = '<C-l>' " CTRL-l expands snippets
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snips']

" Open snippets file for current filetype
nnoremap <Leader>n :UltiSnipsEdit <CR>

" NERD Commenter
let g:NERDSpaceDelims = 1  " Add a space after each comment
let g:NERDCommentEmptyLines = 1  " Allow commenting of empty lines
let g:NERDTrimTrailingWhitespace = 1  " Trim trailing whitespace for commenting
let g:NERDCustomDelimiters = { 'snakemake': { 'left': '#' },
                             \ 'nextflow': { 'left': '//' } }

" NERD Tree
let g:NERDTreeQuitOnOpen = 1  " Close NERDTree after opening a file
map <leader>t :NERDTreeToggle<CR>

" Vim-pandoc
let g:pandoc#formatting#textwidth = 80
let g:pandoc#keyboard#blacklist_submodule_mappings = ['lists']
let g:pandoc#keyboard#use_default_mappings = 0

" REPL: {{{1

" General vim-slime settings
let g:slime_target = "vimterminal"  " Use the Vim built-in terminal
let g:slime_vimterminal_config = { "term_finish": "close",
                                 \  "vertical": 1 }
let g:slime_cell_delimiter = "```"  " Delimiter for RMarkdown chunks

" Function for getting the appropriate language for the current filetype
function! GetLanguage()
    if &ft == "rmarkdown" || &ft == "r"
        let language = "r"
    elseif &ft == "python"
        let language = "python"
    else
        let language = "bash"
    endif
    return language
endfunction

" Function for opening a new REPL window
function! OpenTerminal()

    " Get starting window number
    let starting_window = bufwinnr(bufname('%'))

    " Open a terminal with appropriate language and move back to starting window
    :execute ':vertical terminal ++close ++norestore' GetLanguage()
    :execute starting_window 'wincmd w'
    :SlimeConfig
endfunction

" Function for exiting REPL windows
function! CloseTerminal()

    " Get language of current filetype
    let language = GetLanguage()

    " Close terminal using the appropriate command
    if language == "r"
        :SlimeSend1 quit(save = "no")
    elseif language == "python"
        :SlimeSend1 exit()
    else
        :SlimeSend1 exit
    endif
endfunction

" Function for printing the head of a pandas/R dataframe
function! PrintHead()

    " Get language of current filetype
    let language = GetLanguage()

    " Get the word under the cursor
    let current_word = expand("<cword>")

    " Send appropriate command to REPL
    if language == "r"
        :SlimeSend0 "head(" . current_word . ")\n"
    elseif language == "python"
        :SlimeSend0 current_word . ".head()\n"
    else
        :echo "Error: requires Python or R"
    endif
endfunction

" Vim-slime key mappings
nmap <localleader>l <Plug>SlimeLineSend
nmap <localleader>p <Plug>SlimeParagraphSend
xmap <localleader>s <Plug>SlimeRegionSend
nmap <localleader>c <Plug>SlimeSendCell
nmap <localleader>w viw<Plug>SlimeRegionSend
nmap <localleader>a ggVG<Plug>SlimeRegionSend
nmap <localleader>t :call OpenTerminal()<CR>
nmap <localleader>q :call CloseTerminal()<CR>
nmap <localleader>h :call PrintHead()<CR>
nmap <localleader>C :SlimeSend0 "\x03"<CR>

" REPL RMarkdown Rendering: {{{1

" Function for rendering RMarkdown/Sweave documents
function! RenderRMarkdown()
    if &ft == "rnoweb"
        :w!
        :SlimeSend0 "knitr::knit2pdf('" . expand("%:p") . "')\n"
        :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".pdf')\n"
    elseif &ft == "rmd" || &ft == "rmarkdown"
        :w!
        :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "')\n"
        :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
    else
        echoerr "`".expand("%:p")."` is not a RMarkdown or Sweave file."
        return 1
    endif
endfunction

" Function for rendering RMarkdown presentations with Xaringan
function! RenderXaringan()
    if &ft == "rmarkdown"
        :w!
        :SlimeSend0 "rmarkdown::render('" . expand("%:p") . "', 'xaringan::moon_reader')\n"
        :SlimeSend0 "system2('open', '" . expand("%:p:r") . ".html')\n"
    else
        echoerr "`".expand("%:p")."` is not a RMarkdown file."
        return 1
    endif
endfunction

" Render current RMarkdown/Sweave file
nmap <silent> <LocalLeader>k :call RenderRMarkdown()<CR>
nmap <silent> <LocalLeader>x :call RenderXaringan()<CR>

" Search Settings: {{{1

" Search
set incsearch  " Search as characters are entered
set hlsearch  " Highlight searches
set ignorecase  " Case-insensitive searches ...
set smartcase  " ... except when using capital letters

" Cancel a search with <Return>
nnoremap <CR> :noh<CR><CR>

" Splits: {{{1

" Create splits below and to the right
set splitbelow
set splitright

" Remap split movements to just CTR + <movement>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Syntax Highlighting: {{{1

" Enable syntax highlighting
syntax enable

" Python-specific setting to highlight all syntax groups
let python_highlight_all = 1

" Highlight the first character exceeding a linewidth of 80
highlight ColorColumn ctermbg=red ctermfg=white
call matchadd('ColorColumn', '\%81v.', 100)

" Tab Settings: {{{1

" General tab settings
set tabstop=4  " <TAB> is 4 spaces wide
set expandtab  " <TAB> is expanded to spaces
set shiftwidth=4  " Use 4 spaces when indenting with '>'

" Paste toggling with F6 button
set pastetoggle=<F6>

" Graphical menu for tab-completion of files
set wildmenu

" }}}1

set modelines=1
" vim:foldmethod=marker

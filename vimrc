"  Vim Run Commands file
"  Author:  Erik Fasterius <erik dot fasterius at outlook dot com>
"  URL:     https://github.com/fasterius/dotvim

" Backup Settings: {{{1

" Backups in '~/.vim/tmp' folder
set backup
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Store undo data in a file
set undofile

" }}}1
" Filetypes: {{{1

" Autocommands for filetypes
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead Snakefile,*.snakefile,*snake,*.smk
        \ set filetype=snakemake
    autocmd BufNewFile,BufRead *.R,*.Rout,*.r,*.Rhistory,*.Rt,*.Rout*
        \ set filetype=r
    autocmd BufNewFile,BufRead *.Rnw,*.rnw set filetype=rnoweb
    autocmd BufNewFile,BufRead *.py set filetype=python
    autocmd BufNewFile,BufRead *bash* let g:is_bash=1
    autocmd BufNewFile,BufRead *bash* set filetype=sh
    autocmd BufNewFile,BufRead nextflow.config set filetype=java
    autocmd BufNewFile,BufRead *.nf set filetype=nextflow
augroup END

" Autocommands for filetype commentstrings
augroup commentstrings
    autocmd FileType r set commentstring=#\ %s
    autocmd FileType rmd set commentstring=#\ %s
    autocmd FileType rmarkdown set commentstring=#\ %s
augroup END

" Autocommands for filetype foldmethods
augroup folding
    autocmd FileType r set foldmethod=syntax
    autocmd FileType r set foldnestmax=1
    autocmd FileType rmd set foldmethod=expr
    autocmd FileType rmarkdown set foldmethod=expr
    autocmd FileType snakemake set foldmethod=indent
    autocmd FileType snakemake set foldnestmax=1
augroup END

" }}}
" Functions: {{{1

" Function for rendering RMarkdown/Sweave documents
function! RenderRMarkdown()
    if &ft == "rnoweb"
        !Rscript -e 'knitr::knit2pdf("%:p")'
    elseif &ft == "rmd"
        !Rscript -e 'rmarkdown::render("%:p")'
    else
        echo "Error: `".expand("%:p")."` is not a RMarkdown or Sweave file."
    endif
endfunction

" Function for rendering RMarkdown presentations with Xaringan
function! RenderXaringan()
    if &ft == "rmarkdown"
        !Rscript -e 'rmarkdown::render("%:p", "xaringan::moon_reader")'
    else
        echo "Error: `".expand("%:p")."` is not a RMarkdown file."
    endif
endfunction

" }}}1
" Key Mappings: {{{1

" Set leaders
let maplocalleader=','
let mapleader="\<SPACE>"

" File browsing
map <leader>t :NERDTreeToggle<CR>

" Render current RMarkdown/Sweave file
nmap <silent> <LocalLeader>k
    \ :w<CR>
    \ :cd %:p:h<CR>
    \ :call RenderRMarkdown()<CR>

" Render current RMarkdown to Xaringan presentation
nmap <silent> <LocalLeader>x
    \ :w<CR>
    \ :cd %:p:h<CR>
    \ :call RenderXaringan()<CR><CR>
    \ :! open -a Firefox %:p:r.html<CR><CR>

" Render current Markdown to HTML and open
nmap <LocalLeader>p
    \ :w!<CR>
    \ :w!/tmp/vim-markdown.md<CR>
    \ :!pandoc -s -f markdown -t html
        \ -o /tmp/vim-markdown.html
        \ /tmp/vim-markdown.md<CR>
    \ :!open -a firefox /tmp/vim-markdown.html
        \ > /dev/null 2> /dev/null &<CR><CR>

" Add head() command for NVim-R
nmap <silent> <LocalLeader>h :call RAction("head")<CR>

" Replace all occurences of word underneath the cursor
map <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Open VIMRC file for editing
:nmap <Leader>V :sp <CR> :e $MYVIMRC <CR>

" Re-source VIMRC
:nmap <Leader>v :source $MYVIMRC <CR>

" Open snippets file for current filetype
:nnoremap <Leader>n :UltiSnipsEdit <CR>

" }}}
" Miscellaneous Settings: {{{1

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

" }}}1
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

" }}}1
" Plugins: {{{1

" Use vim-plug for plugin management
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'jalvesaq/Nvim-R'
Plug 'jiangmiao/auto-pairs'
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
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
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

" Enable filetype detection and filetype-specific indentation/plugins
filetype plugin indent on

" UltiSnips
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snips']

" NERD Commenter
let g:NERDSpaceDelims = 1  " Add a space after each comment
let g:NERDCommentEmptyLines = 1  " Allow commenting of empty lines
let g:NERDTrimTrailingWhitespace = 1  " Trim trailing whitespace for commenting
let g:NERDCustomDelimiters = { 'snakemake': { 'left': '#' },
                             \ 'nextflow': { 'left': '//' } }

" NERD Tree
let g:NERDTreeQuitOnOpen = 1  " Close NERDTree after opening a file

" Vim-pandoc
let g:pandoc#formatting#textwidth=80
let g:pandoc#folding#mode = 'expr'  " Use expression folding
let g:pandoc#folding#fold_yaml = 1  " Fold the YAML header
let g:pandoc#folding#fold_fenced_codeblocks = 1  " Fold R code chunks
let g:pandoc#folding#fastfolds = 1  " Use FastFolds for Pandoc folding

" NVim-R
let R_min_editor_width = 80  " Set the minimum source window width
let R_rconsole_width = 80  " Always add the R console through a vertical split
let R_assign = 0  " Disable the default underscore shortcut for '<-'
let r_syntax_folding = 1  " Enable Nvim-R folding of R code

" }}}1
" Search Settings: {{{1

" Search
set incsearch  " Search as characters are entered
set hlsearch  " Highlight searches
set ignorecase  " Case-insensitive searches ...
set smartcase  " ... except when using capital letters

" Cancel a search with <Return>
nnoremap <CR> :noh<CR><CR>

" }}}1
" Splits: {{{1

" Create splits below and to the right
set splitbelow
set splitright

" Remap split movements to just CTR + <movement>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"  }}}
" Syntax Highlighting: {{{1

" Enable syntax highlighting
syntax enable

" Use faster regex engine
set regexpengine=1

" Python-specific setting to highlight all syntax groups
let python_highlight_all = 1

" Highlight the first character exceeding a linewidth of 80
highlight ColorColumn ctermbg=red ctermfg=white
call matchadd('ColorColumn', '\%81v.', 100)

" }}}
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

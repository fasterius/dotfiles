"  Vim Run Commands file
"  Author:  Erik Fasterius <erikfas at kth dot se>
"  URL:     https://github.com/fasterius/dotvim

" Set folding method to 'marker'
setlocal foldmethod=marker

"  Backup Settings: {{{1

" Backups in '~/.vim/tmp' folder
set backup
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Store undo data in a file
set undofile
" }}}1
"  Filetypes: {{{1

" File types
autocmd BufNewFile,BufRead Snakefile,*.snakefile,*snake set filetype=snakemake
autocmd BufNewFile,BufRead *.R,*.Rout,*.r,*.Rhistory,*.Rt,*.Rout*
    \ set filetype=r
autocmd BufNewFile,BufRead *.Rmd,*.rmd set filetype=rmd
autocmd BufNewFile,BufRead *.Rnw,*.rnw set filetype=rnoweb
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.py set filetype=python
autocmd BufNewFile,BufRead *bash* let g:is_bash=1
autocmd BufNewFile,BufRead *bash* set filetype=sh
autocmd BufNewFile,BufRead nextflow.config set filetype=java
" }}}
"  Key Mappings: {{{1

" Set leaders
let maplocalleader=','
let mapleader="\<SPACE>"

" File browsing
map <leader>t :NERDTreeToggle<CR>

" Knit RMarkdown/Sweave files
nmap <LocalLeader>k :w<CR>
    \ :cd %:p:h<CR>
    \ :!Rscript -e 'knitr::knit2pdf("%:p")'<CR>

" Add head() command for NVim-R
nmap <silent> <LocalLeader>h :call RAction("head")<CR>
" }}}
"   Miscellaneous Settings: {{{1

" Make <BACKSPACE> work as normal
set backspace=indent,eol,start

" Show commands
set showcmd

" Add line numbers
set number

" Add background highlight to current line
set cursorline

" Do not insert line breaks automatically
set textwidth=0
" }}}1
"  Movements: {{{1

" Remove arrow key mappings for normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Move by visual lines instead of physical lines
nnoremap j gj
nnoremap k gk
" }}}1
"  Plugins: {{{1

" Pathogen plugin manager
execute pathogen#infect()

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

" NERDcommenter
let g:NERDSpaceDelims=1  " Add a space after each comment
let g:NERDCommentEmptyLines=1  " Allow commenting of empty lines  
let g:NERDTrimTrailingWhitespace=1  " Trim trailing whitespace when commenting
let g:NERDCustomDelimiters = { 'snakemake': { 'left': '#' } }

" NVim-R
let R_min_editor_width = 80  " Set the minimum source window width
let R_rconsole_width = 0  " Always add the R console through a horizontal split
let R_rconsole_height = 25  " Specify the R console height
let R_assign = 0 " Disable the default underscore shortcut for '<-'
" }}}1
"  Search Settings: {{{1

" Search
set incsearch  " Search as characters are entered
set hlsearch  " Highlight searches
set ignorecase  " Case-insensitive searches ...
set smartcase  " ... except when using capital letters

" Cancel a search with <Return>
nnoremap <CR> :noh<CR><CR>
" }}}1
"  Splits: {{{1

" Create splits below and to the right
set splitbelow
set splitright

" Remap split movements to just CTR + <movement>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"  }}}
"  Syntax Highlighting: {{{1

" Enable syntax highlighting
syntax enable

" Python-specific setting to highlight all syntax groups
let python_highlight_all = 1

" Highlight the first character exceeding a linewidth of 79
highlight ColorColumn ctermbg=red ctermfg=white
call matchadd('ColorColumn', '\%80v.', 100)
" }}}
"  Tab Settings: {{{1

" General tab settings
set tabstop=4  " <TAB> is 4 spaces wide
set expandtab  " <TAB> is expanded to spaces
set shiftwidth=4  " Use 4 spaces when indenting with '>'

" Paste toggling with F6 button
set pastetoggle=<F6>

" Graphical menu for tab-completion of files 
set wildmenu
" }}}1

" My own (fairly minimal) .vimrc file.

" Miscellaneous {{{1

" Use Vim-mode rather than vi-mode
set nocompatible

" Set folding method to 'marker'
setlocal foldmethod=marker

" Set <leader> to comma
let mapleader=','

" Make <BACKSPACE> work as normal
set backspace=indent,eol,start

" Show commands
set showcmd

" Add line numbers
set number

" Add background highlight to current line
set cursorline

" Highlight the first character exceeding a linewidth of 79
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%80v.', 100)
" }}}1
" Plugins {{{1

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

" Commenting
let g:NERDSpaceDelims=1  " Add a space after each comment
let g:NERDCommentEmptyLines=1  " Allow commenting of empty lines  
let g:NERDTrimTrailingWhitespace=1  " Trim trailing whitespace when commenting
" }}}1
" Syntax highlighting and file types {{{1

" Syntax hightlighting
syntax enable
autocmd BufNewFile,BufRead Snakefile,*.snakefile set filetype=snakemake
autocmd BufNewFile,BufRead *.R,*.Rout,*.r,*.Rhistory,*.Rt,*.Rout.save,*.Rout.fail set filetype=r
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Filetypes
filetype on  " Enable filetype detection
filetype plugin on  " Enable filetype-specific plugins
filetype indent on  " Enable filetype-specific indentation
" }}}1
" Search settings {{{1

" Search
set incsearch  " Search as characters are entered
set hlsearch  " Highlight searches
set ignorecase  " Case-insensitive searches ...
set smartcase  " ... except when using capital letters

" Cancel a search with <Return>
nnoremap <CR> :noh<CR><CR>
" }}}1
" Tab settings {{{1

" General tab settings
set tabstop=4  " <TAB> is 4 spaces wide
set expandtab  " <TAB> is expanded to spaces
set shiftwidth=4  " Use 4 spaces when indenting with '>'

" Paste toggling with F6 button
set pastetoggle=<F6>

" Graphical menu for tab-completion of files 
set wildmenu
" }}}1
" Backups {{{1

" Backups in '~/.vim/tmp' folder
set backup
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Store undo data in a file
set undofile
" }}}1
" Movements {{{1
" Remove arrow key mappings for normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Move by visual lines instead of physical lines
nnoremap j gj
nnoremap k gk
" }}}1

"  Vim Run Commands file
"  Author:  Erik Fasterius <erik dot fasterius at outlook dot com>
"  URL:     https://github.com/fasterius/dotvim

" Set local folding method to 'marker'
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
" }}}
"   Functions: {{{1

" Function for inserting a new chunk in RMarkdown/Sweave documents
function! AddChunk()

    " Stop execution if current filetype is not Sweave/RMarkdown
    if &ft != "rnoweb" && &ft != "rmd"
        echo "Error: `".expand("%:p")."` is not a RMarkdown or Sweave file."
        return
    endif

    " Get chunk name from user
    call inputsave()
    let chunk_name = input("Chunk name: ")
    call inputrestore()

    " Add empty line if current line is not empty
    let line = getline('.')
    if line =~ '[^\s]'
        execute "normal! o\<Esc>"
    endif

    " Add named chunk
    if &ft == "rnoweb"
        execute "normal! o<<".chunk_name.">>=\<CR>\<CR>@\<Up>"
    elseif &ft == "rmd"
        execute "normal! o```{r ".chunk_name."}\<CR>\<CR>```\<Up>"
    endif
endfunction

" Function for rendering RMarkdown/Sweave documents
function! RenderDocument()
    if &ft == "rnoweb"
        !Rscript -e 'knitr::knit2pdf("%:p")'
    elseif &ft == "rmd"
        !Rscript -e 'rmarkdown::render("%:p")'
    else
        echo "Error: `".expand("%:p")."` is not a RMarkdown or Sweave file."
    endif
endfunction

" }}}1
"  Key Mappings: {{{1

" Set leaders
let maplocalleader=','
let mapleader="\<SPACE>"

" File browsing
map <leader>t :NERDTreeToggle<CR>

" Insert new chunk in RMarkdown/Sweave files
nnoremap <silent> <LocalLeader>ic
    \ :call AddChunk()<CR>

" Knit current RMarkdown/Sweave file
nmap <silent> <LocalLeader>k
    \ :w<CR>
    \ :cd %:p:h<CR>
    \ :call RenderDocument()<CR>

" Add head() command for NVim-R
nmap <silent> <LocalLeader>h :call RAction("head")<CR>

" Replace all occurences of word underneath the cursor
map <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Add quotes around a word
nnoremap <Leader>q" ciw""<Esc>P
nnoremap <Leader>q' ciw''<Esc>P

" Remove quotes around a word
nnoremap <Leader>qd daW"=substitute(@@,"'\\\|\"","","g")<CR>P

" Open VIMRC file for editing
:nmap <Leader>V :sp <CR> :e $MYVIMRC <CR>

" Re-source VIMRC
:nmap <Leader>v :source $MYVIMRC <CR>

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

" Use the same indentation as currently on for new lines
set autoindent

" }}}1
"  Movements: {{{1

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
"  Plugins: {{{1

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
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
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

" NERDcommenter
let g:NERDSpaceDelims = 1  " Add a space after each comment
let g:NERDCommentEmptyLines = 1  " Allow commenting of empty lines
let g:NERDTrimTrailingWhitespace = 1  " Trim trailing whitespace for commenting
let g:NERDTreeQuitOnOpen = 1  " Close NERDTree after opening a file
let g:NERDCustomDelimiters = { 'snakemake': { 'left': '#' } }

" Vim-pandoc
let g:pandoc#folding#mode = 'expr'  " Use expression folding
let g:pandoc#folding#fold_yaml = 1  " Fold the YAML header

" NVim-R
let R_min_editor_width = 80  " Set the minimum source window width
let R_rconsole_width = 80  " Always add the R console through a vertical split
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

" Use faster regex engine
set regexpengine=1

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

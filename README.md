# Vim files

This is my dotvim repository with files and settings I use for Vim. The main
interest is the `.vimrc` file, but syntax highlighting files for R, Snakemake
and Nextflow are also included in the `syntax` directory. 

## Installation

Clone the repository:

```bash
git clone git://github.com/fasterius/dotvim.git ~/.vim
```

You then need to add a symbolic link to the `vimrc` file in your home
directory, as well as install the plugins using `:PlugInstall`. These
steps can be done automatically by running the initialising script:

```{bash}
bash ~/.vim/initialise.sh
```

## Adding another plugin

If you want to add another plugin, all you need to do is add a line in the
`vimrc` file specifying the URL or GitHub location to the plugin, followed
by the `:PlugInstall` command again. This line should be between the 
`call plug#begin('~/.vim/plugged')` and `call plug#end()` commands. For
example, the line to install Tim Pope's `vim-surround` looks like this:
`Plug 'tpope/vim-surround'`.

[vim-plug]: https://github.com/junegunn/vim-plug

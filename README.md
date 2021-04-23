# Bash settings

[![License: MIT][1]][2] 

These are my (fairly minimalistic) Bash settings, contained in the
`bash_profile` and `bashrc` files. The latter simply sources the former. The
`gitignore_global` file contains git ignore statements that will be used on a
global (system-wide) scale. A `gitconfig` is also included, containing a git
username and email, as well as the path to the global gitignore file.

In order to simplify usage of this repo, you can execute the
`scripts/create_symlinks.sh` script, which will create symbolic links in your
home folder for the bash profiles and the gitconfig file.

There is also a Bash script (`/scripts/hide_home_folder.sh`) that hides the
default OSX home folders (i.e. "Desktop", "Downloads", etc.) from Finder and
creates symbolic links in a new `~/home` folder for easy access without
cluttering up the default `~` home folder. Simply execute it if you want to use
this solution.

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

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

```bash
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

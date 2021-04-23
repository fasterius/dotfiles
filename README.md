# Dotfiles

[![License: MIT][1]][2]

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

This is my collection of `dotfiles`, covering everything from bash to vim. You
can find Git settings in `git/`, several configuration files in `profiles/`,
everything related to Vim in `vim/` as well as several helper scripts in
`scripts/`.

### Quick installation

```bash
git clone git@github.com:fasterius/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/scripts
./01-hide-home-directories.sh
./02-install-software.sh
./03-create-symlinks.sh
```

## Git

The `gitignore_global` file contains git ignore statements that will be used on
a global (system-wide) scale. A `gitconfig` is also included, containing a git
username and email, as well as the path to the global gitignore file.

## Profiles

The main `bash_profile` contains all bash-related settings and aliases, while
`bashrc` simply source the former. The `uppmax_profile` is source when logged in
to a remote using SSH. The `condarc` contains the Conda configuration, while
`tmux.config` does the same for TMUX.

## Vim

The main interest here is the `.vimrc` file, but syntax highlighting files for
R, Snakemake and Nextflow are also included in the `syntax/` directory.

If you want to add another plugin, all you need to do is add a line in the
`vimrc` file specifying the URL or GitHub location to the plugin, followed by
the `:PlugInstall` command again. This line should be between the `call
plug#begin('~/.vim/plugged')` and `call plug#end()` commands. For example, the
line to install Tim Pope's `vim-surround` looks like this: `Plug
'tpope/vim-surround'`.

## Scripts

In order to simplify usage of this repo, you can execute the scripts contained
in the `scripts/` directory. The `01-hide-home-folder.sh` script hides the
default MacOS home directories (*i.e.* "Desktop", "Download", *etc.*) from
Finder and creates symbolic links in a new `~/home/` directory for easy access
without cluttering up the default home directory.

The `02-install-software.sh` installs Python3, Vim, Conda and Nextflow in
`~/opt/` with the correct build settings that will enable use of *e.g.*
`YouCompleteMe` for Vim.

The `03-create-symlinks.sh` creates all the symbolic links needed for all the
various profiles and configs contained in this repository, as well as installs
all the plugins specified in the Vim settings.

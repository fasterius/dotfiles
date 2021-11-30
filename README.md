# Dotfiles

[![License: MIT][1]][2]

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

This is my collection of `dotfiles`, covering everything from Bash to Vim.

## Installation

```bash
git clone git@github.com:fasterius/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/install
./01-hide-home-directories.sh
./02-install-software.sh
./03-create-symlinks.sh
```

In order to simplify usage of this repo, you can execute the scripts contained
in the `install/` directory. The `01-hide-home-folder.sh` script hides the
default MacOS home directories (*i.e.* "Desktop", "Download", *etc.*) from
Finder and creates symbolic links in a new `~/home/` directory for easy access
without cluttering up the default home directory.

The `02-install-software.sh` installs Python3, Vim, Conda and Nextflow in
`~/opt/` with the correct build settings that will enable use of *e.g.*
`YouCompleteMe` for Vim.

The `03-create-symlinks.sh` creates all the symbolic links needed for all the
various profiles and configs contained in this repository, as well as installs
all the plugins specified in the Vim settings.

## Contents

### Bash

The main `bash_profile` contains all bash-related settings and aliases, while
`bashrc` simply sources the former. The `uppmax_profile` is sourced when logged
in to a remote using SSH.

### Conda

The `condarc` file contains configurations for Conda.

### Git

The `gitignore_global` file contains git ignore statements that will be used on
a global (system-wide) scale. A `gitconfig` is also included, containing a git
username and email, as well as the path to the global gitignore file.

### iTerm2

The `com.googlecode.iterm2.plist` file contains configuration for the iTerm2
terminal software. If you want to use it, you'll have to to to *Preferences* ->
*General* -> *Preferences*, tick `Load preferences from a custom folder or URL`
and type `~/.dotfiles/iterm2`

### Tmux

The `tmux.conf` file contains general configuration for Tmux, including
functionality to make it play well with Vim (*e.g.* moving between Vim splits
anv Tmux panes in the same way).

### Vim

The main interest here is the `.vimrc` file, but custom syntax highlighting
files for R, Snakemake and Nextflow are also included in the `syntax/`
directory. You can read more about what the different directories do in this
[great overview](https://learnvimscriptthehardway.stevelosh.com/chapters/42.html) over
at [Learn Vimscript the Hard way](https://learnvimscriptthehardway.stevelosh.com/),
which is an excellent vim resource in general.

If you want to add another plugin, all you need to do is add a line in the
`vimrc` file specifying the URL or GitHub location to the plugin, followed by
the `:PlugInstall` command again. This line should be between the `call
plug#begin('~/.vim/plugged')` and `call plug#end()` commands. For example, the
line to install Tim Pope's `vim-surround` looks like this: `Plug
'tpope/vim-surround'`.

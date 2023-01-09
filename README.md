# Dotfiles

[![License: MIT][1]][2]

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

This is my collection of `dotfiles`, covering everything from Bash to Vim.

## Installation

```bash
git clone git@github.com:fasterius/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/install
./hide-macos-directories.sh
./create-symlinks.sh
```

In order to simplify usage of this repo, you can execute the scripts contained
in the `install/` directory. The `hide-macos-directories.sh` script hides the
default MacOS home directories (*i.e.* "Desktop", "Download", *etc.*) from
Finder and creates symbolic links in a new `~/home/` directory for easy access
without cluttering up the default home directory, while the
`create-symlinks.sh` creates all the symbolic links needed for all the various
profiles and configs contained in this repository.

## Contents

 * `alacritty/`: The `alacritty.yml` file contains all the configurations needed
 for the [Alacritty](https://github.com/alacritty/alacritty) terminal emulator.

 * `bash/`: The main `bash_profile` contains all bash-related settings and
 aliases, while `bashrc` simply sources the former. The `uppmax_profile` is
 sourced when logged in to a remote using SSH.

 * `bat/`: A `bat.conf` configuration file for the [bat](https://github.com/sharkdp/bat)
 command line utility, used for colouring terminal output (mainly used for
 colouring the `fzf` preview window inside Vim).

 * `conda/`: The `condarc` file contains configurations for
 [Conda](https://docs.conda.io/en/latest/).

 * `git/`: The `gitignore_global` file contains git ignore statements that will
 be used on a global (system-wide) scale. A `gitconfig` is also included,
 containing a git username and email, as well as the path to the global
 gitignore file.

 * `tmux/`: The `tmux.conf` file contains general configuration for
 [Tmux](https://github.com/tmux/tmux), including functionality to make it play
 well with Vim (*e.g.* moving between Vim splits any Tmux panes in the same
 way).

 * `vim/`: The main interest here is the `.vimrc` file, but custom syntax
 highlighting files for R, Snakemake and Nextflow are also included in the
 `syntax/` directory. You can read more about what the different directories do
 in this [great overview](https://learnvimscriptthehardway.stevelosh.com/chapters/42.html)
 over at [Learn Vimscript the Hard way](https://learnvimscriptthehardway.stevelosh.com/),
 which is an excellent vim resource in general.

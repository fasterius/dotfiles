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
./macos-brew-install.sh
```

In order to simplify usage of this repo, you can execute the scripts contained
in the `install/` directory. The `hide-macos-directories.sh` script hides the
default MacOS home directories (*i.e.* "Desktop", "Download", *etc.*) from
Finder and creates symbolic links in a new `~/home/` directory for easy access
without cluttering up the default home directory; `create-symlinks.sh` creates
all the symbolic links needed for all the various profiles and configs contained
in this repository; `macos-brew-install.sh` installs various software packages
using the [Homebrew](https://brew.sh/) package manager for MacOS.

## Contents

 * `alacritty/`: The `alacritty.yml` file contains all the configurations needed
   for the [Alacritty][3] terminal emulator.

 * `bash/`: The main `bash_profile` contains all bash-related settings and
   aliases, while `bashrc` simply sources the former. The `uppmax_profile` is
   sourced when logged in to a remote using SSH.

 * `bat/`: A `bat.conf` configuration file for the [bat][4] command line
   utility, used for colouring terminal output (mainly used for colouring the
   `fzf` preview window inside Vim).

 * `conda/`: The `condarc` file contains configurations for [Conda][5].

 * `git/`: The `gitignore_global` file contains git ignore statements that will
   be used on a global (system-wide) scale. A `gitconfig` is also included,
   containing a git username and email, as well as the path to the global
   gitignore file.

 * `lsp/`: Configuration files for language server protocols.

 * `scripts/`: Some convenience scripts for running common tasks, including
   creating Apptainer images from local Docker images; creating AMD/Intel-based
   Conda environments on ARM-platforms; and starting new TMUX sessions with a
   default pane layout.

 * `tmux/`: The `tmux.conf` file contains general configuration for [Tmux][6],
   including functionality to make it play well with Vim (*e.g.* moving between
   Vim splits any Tmux panes in the same way).

 * `vim/` and `nvim/`: Settings for Vim and Neovim, respectively. You can read
   more about what the different directories do in this [great overview][7] over
   at [Learn Vimscript the Hard Way][8], which is an excellent vim resource in
   general.

[3]: https://github.com/alacritty/alacritty
[4]: https://github.com/sharkdp/bat
[5]: https://docs.conda.io/en/latest/
[6]: https://github.com/tmux/tmux
[7]: https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
[8]: https://learnvimscriptthehardway.stevelosh.com/

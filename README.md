# Dotfiles

[![License: MIT][1]][2]

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

This is my collection of `dotfiles`, covering everything from Bash to Neovim.

## Installation

Some scripts are included as submodules, so make sure you clone using the
`--recursive` flag:

```bash
git clone --recursive git@github.com:fasterius/dotfiles.git ~/.dotfiles
```

In order to simplify usage of this repo, you can execute the scripts contained
in the `install/` directory:

- `macos-brew-install.sh`: Installs various software packages using the
  [Homebrew](https://brew.sh/) package manager for MacOS.
- `hide-macos-directories.sh`: Script hides the default MacOS home directories
  (_i.e._ "Desktop", "Download", _etc._) from Finder and creates symbolic links
  in a new `~/home/` directory for easy access without cluttering up the default
  home directory.
- `install-fonts.sh`: Installs the Meslo LGS Nerd Font.
- `install-software.sh`: Installs software that isn't installable by a package
  manager, _e.g._ Pixi, Nextflow and nf-test.
- `create-symlinks.sh`: Creates all the symbolic links needed for all the
  various profiles and configs contained in this repository.

I use both MacOS and Linux, so some of these scripts are only applicable to
_e.g._ Macs, as evidenced by their name. The scripts without a platform in their
name are written to work on either platform, where _e.g._ MacOS-specific
software is only symlinked on MacOS, and _vice versa_.

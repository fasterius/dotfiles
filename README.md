# Dotfiles

[![License: MIT][1]][2]

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

This is my collection of `dotfiles`, covering everything from Bash to Neovim.
I use both MacOS and Linux, and the configs are written to work on either.

## Installation

Some scripts are included as submodules, so make sure you clone using the
`--recursive` flag. All submodules use SSH, so a GitHub SSH key needs to be set
up first. The repository is expected to live in `~/.dotfiles`:

```bash
git clone --recursive git@github.com:fasterius/dotfiles.git ~/.dotfiles
```

In order to simplify usage of this repo, you can execute the scripts contained
in the `install/` directory:

- `install-wrapper.sh`: Runs all the subsequent scripts in an OS-dependent
  manner (you would usually want to run this, unless you're specifically only
  interested in a single one of the other scripts).
- `create-symlinks.sh`: Creates all the symbolic links needed for all the
  various profiles and configs contained in this repository; safe to run
  multiple times.
- `install-software.sh`: Installs software that isn't installable by a package
  manager, _e.g._ Pixi, Nextflow and nf-test.
- `install-fonts.sh`: Installs the Meslo LGS Nerd Font.
- `macos-brew-install.sh`: Installs the [Homebrew](https://brew.sh/) package
  manager for MacOS and the packages listed in `brew/Brewfile`. The Brewfile
  is linked to `~/.Brewfile`, so `brew bundle check --global` shows missing
  packages and `brew bundle cleanup --global` shows unlisted ones.
- `macos-hide-directories.sh`: Hides the default MacOS home directories
  (_i.e._ "Desktop", "Downloads", _etc._) from Finder and creates symbolic
  links in a new `~/home/` directory for easy access without cluttering up the
  default home directory.

Scripts prefixed with `macos-` only apply to MacOS; the others work on either
platform.

### Updating

After pulling changes, run the following to pick up any changed submodules and
new symlinks:

```bash
git submodule sync
git submodule update --init
~/.dotfiles/install/create-symlinks.sh
```

## Layout

Each program has its own directory, which `create-symlinks.sh` links into place
in one of the following ways:

- **XDG configs:** the whole directory is linked into `~/.config/`, _e.g._
  `~/.config/nvim` → `~/.dotfiles/nvim`.
- **Home directory configs:** single files are linked as hidden files in `~/`,
  _e.g._ `~/.bashrc` → `~/.dotfiles/bash/bashrc`.
- **Scripts:** the scripts meant to be run by hand are linked into
  `~/.local/bin/`. Scripts used by other configs are called by their full path
  instead.
- **Special cases:** Pixi's config and global manifest are linked into
  `~/.pixi/`, and the SSH config into `~/.ssh/`.

Some configs are only linked where they apply: OS-specific ones on that OS,
and GNOME-related ones (including loading `gnome/settings.dconf` with `dconf`)
only on machines with GNOME installed.

## Colour schemes

Which colour scheme a machine uses is defined in a single place,
`scripts/dotfiles-colourscheme.sh`, which prints the colour scheme for the
current hostname. Configs with colours come in one file per colour scheme, named
`<name>-<colourscheme>.<ext>`, and select the right one in one of two ways:

- **At runtime:** Bash and Tmux call the script when they start and load the
  matching file, _e.g._ `bash/colours-everforest.sh`. Bash also exports the
  result as `DOTFILES_COLOURSCHEME`.
- **At install:** programs that can't run a script themselves get a symlink from
  `<name>.<ext>` to the matching file, created by `create-symlinks.sh`. These
  symlinks are not tracked by Git.

To add a new machine, add its hostname to `dotfiles-colourscheme.sh` and
re-run `create-symlinks.sh`.

## Git hooks

Git is configured to use global hooks from `git/hooks/` for every repository
through `core.hooksPath`. All hooks point to a dispatcher script, which:

1. Runs global checks, currently [Gitleaks](https://github.com/gitleaks/gitleaks)
   to block commits containing secrets (if it's installed). It only prints
   something if a secret is found.
2. Runs the repository's own hook of the same name in `.git/hooks/`.

Only hook types that have a symlink in `git/hooks/` are run at all, so add a
new symlink to `_dispatcher` if a repository needs another type of hook.

## Included software

Some software included here live in their respective repositories and are
installed as submodules:

- [`conda-intel-env`](https://github.com/fasterius/conda-intel-env): A helper
  script for creating Intel-based Conda environments on MacOS ARM64.
- [`docker-X11-interactive`](https://github.com/fasterius/docker-X11-interactive):
  A helper script for interactive plotting inside Docker containers on MacOS.
- [`quick-whisper`](https://github.com/fasterius/quick-whisper): A
  cross-platform script for local speech-to-text transcription using
  `whisper.cpp`.

## Archived configs

Configs that are no longer in use are removed from the repository, but kept in
Git tags so they can be found and restored if needed:

- `niri`: Niri desktop setup (Niri, Waybar, eww, Quickshell, Mako, Fuzzel
  and related scripts).
- `jj`: [Jujutsu](https://github.com/jj-vcs/jj) config.

To browse an archived config, use _e.g._ `git show niri:niri/config.kdl`; to
restore it, use `git checkout niri -- niri/`.

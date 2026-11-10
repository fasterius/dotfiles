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
- `install-with-pixi.sh`: Installs Pixi and the environments in its global
  manifest (`pixi/manifests/pixi-global.toml`) with `pixi global sync`.
- `install-fonts.sh`: Installs the Meslo LGS Nerd Font.
- `brew-install.sh`: Installs the packages listed in `brew/Brewfile` with
  [Homebrew](https://brew.sh/), installing Homebrew itself first on MacOS. On
  Linux, Homebrew must already be installed. The Brewfile is linked to
  `~/.Brewfile`, so that `brew bundle check --global` shows missing packages and
  `brew bundle cleanup --global` shows unlisted ones.
- `macos-hide-directories.sh`: Hides the default MacOS home directories (_i.e._
  "Desktop", "Downloads", _etc._) from Finder and creates symbolic links in a
  new `~/home/` directory for easy access without cluttering up the default home
  directory.
- `macos-launchd-services.sh`: Installs and (re)loads the `launchd` services in
  `launchd/` for the software that is installed, _e.g._ the `llama.cpp` server
  and a `tailscaled` that runs without root, and creates the `llama.cpp`
  server's API key in `~/.local/share/llama.cpp/api-key` if it's missing; safe
  to run multiple times.

Scripts prefixed with `macos-` only apply to MacOS; the others work on either
platform.

Afterwards, run `scripts/dotfiles-doctor.sh` to list any missing software that
the configs rely on, and to print the versions of software with a minimum
version requirement.

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
  `~/.pixi/`, and the SSH config into `~/.ssh/`. The `agent-sandbox` command is
  linked into `~/.local/bin/` from its own repository in
  `~/projects/agent-sandbox`, if that has been cloned.
- **`launchd` services:** the services in `launchd/` are copied into
  `~/Library/LaunchAgents/` by `macos-launchd-services.sh` instead, with the
  home directory filled in; re-run it after changing them.

Some configs are only linked where they apply: OS-specific ones on that OS, and
GNOME-related ones (including loading `gnome/settings.dconf` with `dconf`) only
on machines with GNOME installed. Configs that differ between operating systems
come in one file per OS, named `<name>-<os>.<ext>` (_e.g._
`alacritty/size-darwin.toml`), and the one for the current OS is symlinked to
`<name>.<ext>` by `create-symlinks.sh`.

## Host settings

Everything that differs between machines is defined in a single place,
`scripts/dotfiles-host.sh`. It detects facts about the current host, which
configs and install scripts use instead of detecting them themselves:

- `DOTFILES_OS`: the operating system, `darwin` or `linux`, as used in the names
  of OS-specific configs.
- `DOTFILES_HEADLESS`: `1` on Linux hosts without a desktop, otherwise `0`.

It also sets the choices that can't be detected, recognising the current host
(mostly by hostname):

- `DOTFILES_COLOURSCHEME`: the colour scheme (default: Solarized; see below).
- `DOTFILES_HPC`: the HPC system whose `bash/<name>_profile` is loaded in SSH
  sessions (default: nothing).
- `DOTFILES_SLOW_FS`: set to `1` on hosts where Git operations are slow, which
  turns off the Neovim `Gitsigns` plugin (default: `0`).

Unknown hosts get the defaults. Bash and the install scripts source the script,
and Bash exports the choices; programs started from Bash (_e.g._ Neovim) only
read the exported variables. The script can also be run with the name of a
choice (`colourscheme`, `hpc` or `slow-fs`) to print its value, which is how
Tmux gets the colour scheme.

To add a new machine that needs something other than the defaults, add its
hostname to the `case` statement in `dotfiles-host.sh` and re-run
`create-symlinks.sh`.

## Colour schemes

Configs with colours come in one file per colour scheme, named
`<name>-<colourscheme>.<ext>`, and select the right one in one of two ways:

- **At runtime:** Bash, Tmux and Neovim get the colour scheme from the host
  settings when they start and load the matching file or colours, _e.g._
  `bash/colours-everforest.sh`.
- **At install:** programs that can't run a script themselves get a symlink from
  `<name>.<ext>` to the matching file, created by `create-symlinks.sh`. These
  symlinks are not tracked by Git.

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

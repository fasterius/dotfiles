# Vim dotfiles

These are the dotfiles I use for Vim.

This repository is based on http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

### Installation

Clone the repository:

```bash
git clone git://github.com/fasterius/dotvim.git ~/.vim
```

Create symlinks:

```bash
ln -s ~/.vim/vimrc ~/.vimrc
```

Switch to the `~/.vim` directory and fetch submodules:

```bash
cd ~/.vim
git submodule init 
git submodule update
```


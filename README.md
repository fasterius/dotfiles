# Vim files

This is my dotvim repository with files and settings I use for Vim. It is based on http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

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

### Upgrading plugins

If you want to upgrade a specific plugin, you can `cd` into its directory and do

```bash
git pull origin master
```

If you want to update all the plugins, do

```bash
git submodule foreach git pull origin master
```


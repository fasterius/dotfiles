# Vim files

This is my dotvim repository with files and settings I use for Vim. The main interest is the `.vimrc` file, but syntax highlighting files for R and Snakemake are also included in the `syntax` directory. 

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
git submodule update --init
```

### Updating plugins

If you want to update a specific plugin, you can `cd` into its directory and do

```bash
git pull origin master
```

If you want to update all the plugins, do

```bash
git submodule foreach git pull origin master
```

### Adding another plugin

If you have cloned into this repository but want to add a plugin that is not present here, you can add it as a submodule:

```bash
cd ~/.vim/bundle
git submodule add <http://github.com/example-user/example-plugin.git>
```

The plugin can now be updates in the same manner as the others already included in this repository. In order to not dirty the repository tree when generating helptags, you should also add the line `ignore = dirty` for your newly installed plugin in the `.gitmodules` file (you can read more about this at http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules).


# Bash settings

[![License: MIT][1]][2] 

These are my (fairly minimalistic) Bash settings, contained in the
`bash_profile` and `bashrc` files. The latter simply sources the former. The
`gitignore_global` file contains git ignore statements that will be used on a
global (system-wide) scale. A `gitconfig` is also included, containing a git
username and email, as well as the path to the global gitignore file.

In order to simplify usage of this repo, you can execute the
`scripts/create_symlinks.sh` script, which will create symbolic links in your
home folder for the bash profiles and the gitconfig file.

There is also a Bash script (`/scripts/hide_home_folder.sh`) that hides the
default OSX home folders (i.e. "Desktop", "Downloads", etc.) from Finder and
creates symbolic links in a new `~/home` folder for easy access without
cluttering up the default `~` home folder. Simply execute it if you want to use
this solution.

[1]: https://img.shields.io/badge/License-MIT-blue.svg
[2]: https://opensource.org/licenses/MIT

# Path
export PATH="$PATH:/usr/local/bin/"

# Locale
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

# Default editor
export EDITOR=vim

# Aliases --------------------------------------------------------------------

# Long-format, coloured `ls`
alias ll='ls -lG'

# Move upwards multiple directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Auto-clour `grep` output
alias grep='grep --color=auto'

# Prompt ---------------------------------------------------------------------

# Function to get branch if inside a git repository
git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Build prompt
export PS1='[\[\e[1;36m\]\h: ' # Hostname (bold grey)
export PS1=$PS1'\[\e[0;34m\]\w\[\e[m\]]' # Current directory (blue)
export PS1=$PS1'\[\e[0;36m\]$(git_branch)' # Git branch (teal)
export PS1=$PS1'\[\e[m\]$ ' # End

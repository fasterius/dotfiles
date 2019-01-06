# Path
export PATH="$PATH:/usr/local/bin/"

# Prompt
export PS1='[\[\e[1;36m\]\h: \[\e[0;34m\]\w\[\e[m\]]$ '

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

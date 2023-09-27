# Paths
export PATH="$PATH:/Applications/MacVim.app/Contents/bin" # MacVim

# Local Bins
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH"

# Default Projects folder
export PROJECTS_PATH="$HOME/Projects"

# Default shell
export SHELL='/bin/bash'

# E-mail to use in dev environments
export DEV_EMAIL="rahmal@gmail.com"

# Editor to use when opening files from CLI
export EDITOR=atom

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoreboth

# Stop deprecation warnings.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Append to the history file, don't overwrite it
shopt -s histappend

# Hostname
export HOSTNAME_SHORT=`hostname -s`

for file in $(\ls -1 ${HOME}/bash/*.sh); do
  source $file;
  [[ -r $file ]] && source $file;
done

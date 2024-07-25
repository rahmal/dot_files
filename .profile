# Paths
export PATH="$PATH:/opt/homebrew/bin"

# Local Bins
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH"

# Bash Files
export BASH_DIR="$HOME/.bash"

# Root branch in git repo (main|master)
export GIT_ROOT='master'

# Default Projects folder
export PROJECTS_PATH="$HOME/Projects"

# Default shell
export SHELL='/bin/bash'

# E-mail to use in dev environments
export DEV_EMAIL="rahmal@gmail.com"

# Editor to use when opening files from CLI
export EDITOR=nvim

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoreboth

# Stop deprecation warnings.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Open JDK
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# Append to the history file, don't overwrite it
shopt -s histappend

# Hostname
export HOSTNAME_SHORT=`hostname -s`

for file in $(\ls -1 ${BASH_DIR}/*.sh); do
  source $file;
  [[ -r $file ]] && source $file;
done



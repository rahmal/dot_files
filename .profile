# Paths
export BREW_HOME="/opt/homebrew/opt/"
export PG_HOME="$BREW_HOME/postgresql@14/"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
export PROJECTS_PATH="$HOME/Projects"
export PYENV_PATH="/Library/Frameworks/Python.framework/Versions/3.7"
export PYENV_ROOT="$HOME/.pyenv"
export VOLTA_HOME="$HOME/.volta"

# Local Bins
export PATH="$HOME/bin:$VOLTA_HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH"

# App Bins
export PATH="$PATH:/Applications/MacVim.app/Contents/bin" # MacVim
export PATH="$PATH:$PG_HOME/bin"                          # PostgreSQL
export PATH="$PATH:$BREW_HOME/mysql/bin"                  # MySQL Server
export PATH="$PATH:$BREW_HOME/imagemagick/bin"            # ImageMagick
export PATH="$PATH:$BREW_HOME/openssl/bin"                # OpenSSL
export PATH="$PATH:/usr/local/pmd/bin"                    # PMD
export PATH="$PATH:$PYENV_ROOT/bin:$PYENV_PATH/bin"       # Python

# For compilers to find openssl
export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl/include"

# Default shell
export SHELL='bash'

# E-mail to use in dev environments
export DEV_EMAIL="rahmal@gmail.com"

# Editor to use when opening gems, etc.
export EDITOR=mvim

# Disable Rack Debug for rails apps
export NO_RACK_DEBUG=true

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoreboth

# Stop deprecation warnings.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Append to the history file, don't overwrite it
shopt -s histappend

# Hostname
export HOSTNAME_SHORT=`hostname -s`

# Shell Env
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"

for file in $(\ls -1 ${HOME}/bash/*.sh); do
  source $file;
done

export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

export PATH="$PATH:/Applications/MacVim.app/Contents/bin" # MacVim
export PATH="$PATH:/usr/local/opt/postgresql/bin"         # PostgreSQL
export PATH="$PATH:/usr/local/opt/mysql/bin"              # MySQL Server
export PATH="$PATH:/usr/local/opt/mysql-client/bin:"      # MySQL Client
export PATH="$PATH:/usr/local/opt/imagemagick/bin"        # ImageMagick
export PATH="$PATH:/usr/local/opt/openssl/bin"            # OpenSSL
export PATH="$PATH:/usr/local/opt/go/bin"                 # Go
export PATH="$PATH:$GOPATH/bin"                           # Go (local)
export PATH="$PATH:/usr/local/pmd/bin"                    # PMD
export PATH="$PATH:$PYENV_ROOT/bin:$PYENV_PATH/bin"       # Python

export SHELL='bash'

# For compilers to find openssl
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# Paths
export GOPATH="$HOME/go"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
export PROJECTS_PATH="$HOME/Projects"
export PYENV_PATH="/Library/Frameworks/Python.framework/Versions/3.7"
export PYENV_ROOT="$HOME/.pyenv"

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

# rbenv & pyenv
eval "$(rbenv init -)"
eval "$(pyenv init -)"

for file in $(\ls -1 ${HOME}/bash/*.sh); do
  source $file;
done

source ${HOME}/bash/iterm2_shell_integration.sh
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

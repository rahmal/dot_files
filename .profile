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

# For compilers and/or pkg-config to find openssl
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# Go Path
export GOPATH="$HOME/go"

# E-mail to use in dev environments
export DEV_EMAIL="rahmal@gmail.com"

# Editor to use when opening gems, etc.
export EDITOR=mvim

# Disable Rack Debug for rails apps
export NO_RACK_DEBUG=true

# don't put duplicate lines in the history.
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Hostname
export HOSTNAME_SHORT=`hostname -s`

# rbenv
eval "$(rbenv init -)"

for file in $(\ls -1 ${HOME}/bash/*.sh); do
  source $file;
done


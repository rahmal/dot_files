# Source Homebrew's completion definitions to make them available in bash.

if type brew &>/dev/null; then
  export BREW_PREFIX="$(brew --prefix)";
  export BREW_CELLAR="$(brew --cellar)";
  export BREW_REPOSITORY="$(brew --repo)";

  export BREW_HOME="$BREW_CELLAR";
  export BREW_PATH="$BREW_PREFIX";
  export BREW_BIN="$BREW_PATH/bin";
  export BREW_SHARE="$BREW_PATH/share";

  # Brew Paths
  export PATH="$BREW_BIN:$BREW_PATH/sbin${PATH+:$PATH}";
  export MANPATH="$BREW_SHARE/man${MANPATH+:$MANPATH}:";
  export INFOPATH="$BREW_SHARE/info:${INFOPATH:-}";

  # OpenSSL Paths
  export OPENSSL_PATH="$BREW_HOME/openssl@3/3.1.3";
  export OPENSSL_LIB="$OPENSSL_HOME/lib";
  export OPENSSL_INC="$OPENSSL_HOME/include";
  export PKG_CONFIG_PATH="$OPENSSL_LIB/pkgconfig"

  # OpenSSL Compilers
  export LDFLAGS="-L$OPENSSL_LIB"
  export CPPFLAGS="-I$OPENSSL_INC"

  # Brew Apps
  export PATH="$PATH:$BREW_HOME/postgresql@12/12.16/bin"  # PostgreSQL
  export PATH="$PATH:$BREW_HOME/mysql/8.1.0/bin"          # MySQL
  export PATH="$PATH:$BREW_HOME/imagemagick/7.1.1-18/bin" # ImageMagick
  export PATH="$PATH:$OPENSSL_HOME/bin"                   # OpenSSL

  # Brew Completions
  if [[ -r "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${BREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi

  eval "$($BREW_BIN/brew shellenv)"

  # Brew Services
  alias svc='brew services'
  alias start='svc start'
  alias stop='svc stop'
  alias restart='svc restart'
  alias status='svc list'
fi

# Load Python

# PyEnv Paths
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"

eval "$(pyenv init -)"
eval "$(/opt/homebrew/bin/brew shellenv)"

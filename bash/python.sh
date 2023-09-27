# Load Python

# PyEnv Paths
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_PATH="$BREW_HOME/pyenv/2.3.27";
export PATH="$PATH:$PYENV_ROOT/bin:$PYENV_PATH/bin"

eval "$(pyenv init -)"

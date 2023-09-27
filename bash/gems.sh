# Ruby Gems

# Load Path
if which ruby >/dev/null && which gem >/dev/null; then
  export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Aliases
alias gmi='gem install'
alias gui='gem uninstall'

alias b='bundle'
alias be='b exec'
alias bs='b show'
alias bo='b open'

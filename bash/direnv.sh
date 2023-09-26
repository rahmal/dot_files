type _direnv_hook 2>/dev/null | grep -q function || eval "$(direnv hook bash)"
type _direnv_hook 2>/dev/null | grep -q function || eval "$(direnv hook zsh)"

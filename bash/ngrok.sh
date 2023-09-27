# Ngrok Server

if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

alias grok='ngrok http 8080'

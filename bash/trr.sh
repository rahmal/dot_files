# Aliases
alias api='cd $GOPATH/src/github.com/TheRealReal/therealreal-api'
alias grok='ngrok http 8080'

# Functions
function gateway {
  refresh
  api
  go install
  therealreal-api
}


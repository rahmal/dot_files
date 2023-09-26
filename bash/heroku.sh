# Heroku aliases
alias hp='gp heroku master'
alias hpp='gp production master'

# Heroku CLI
alias hero='heroku'
alias h='hero'

# Heroku Run
alias hr='h run'
alias hb='hr bash'
alias hc='hr rails console'
alias hcp='hc -r prod'
alias hcs='hc -r staging'

alias h:rake='hr rake'
alias h:dbm='h:rake db:migrate'

alias h:c='hc'
alias h:logs='h logs -t -n 100'
alias h:run='hr'

# Postgres
alias hpi='h pg:info'
alias hpsql='h pg:psql'

# Production
alias h:c:p='h:c prod'
alias h:ps='h ps -r prod'
alias h:ps:w='h ps:wait -r prod'
alias dynos='h:ps && h:ps:w'

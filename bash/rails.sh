# Rails

# Disable Rack Debug for rails apps
export NO_RACK_DEBUG=true

# Rails Aliases
alias rails='be rails'
alias rs='rails s'
alias rg='rails g'
alias rc='rails c'
alias rgm='rg migration'
alias rake='be rake'
alias rackup='be rackup'
alias spec='RAILS_ENV=test be rspec'
alias cuc='be cucumber'
alias apc='RAILS_ENV=production rake assets:precompile'
alias deploy='cap deploy'
alias lg='tail -f log/development.log'

# Rails DB
alias dbd='rake db:drop'
alias dbc='rake db:create'
alias dbm='rake db:migrate'
alias dbs='rake db:seed'
alias dba='dbd && dbc && dbm'

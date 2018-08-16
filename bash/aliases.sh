### Aliases

# ls
alias ls='ls -G'
alias ll='ls -lrth'
alias la='ll -A'
alias lll='ll|tail'
alias lla='la|tail'

# vim
alias vi='vim -p'
alias vim='mvim'

# Misc Utils
alias syslogs='tail -f /var/log/syslog'
alias sl='syslogs'
alias more='less'
alias p='ps -ef | grep -i '
alias gpg='gpg --use-agent'
alias copy='xsel -ib'
alias paste='xsel -b'
alias last-arg='echo $(ls -1tr | tail -1)'
alias ack='ack --ignore-dir=log --ignore-dir=vendor --ignore-dir=test --ignore-dir=spec'
alias tz='tar -zxf'
alias ping='ping -c4'
alias kill='sudo kill -9'
alias mkdir='mkdir -p'
alias ...='../..'
alias vp='vim ~/.profile && source ~/.profile'
alias hosts='sudo vim /etc/hosts'

# Ruby aliases
alias use='rvm use'
alias rd='use default'
alias gs='rvm gemset'
alias gsl='gs list'
alias gsu='gs use'
alias gsc='gs create'

alias qgem='gem install --no-rdoc --no-ri'
alias ugem='sudo gem uninstall'

alias be='bundle exec'
alias bs='bundle show'
alias bo='bundle open'

# Rails
alias rs='be rails s'
alias rg='be rails g'
alias rc='be rails c'
alias rake='be rake'
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
alias dba='dbd; dbc && dbm && dbs'

alias pg='pg_ctl -D /usr/local/var/postgres'

# Source/Bind
alias src='source ~/.profile'
alias inp='bind -f ~/.inputrc'
alias refresh='src && inp'

# Brew Services
alias svc='brew services'
alias start='svc start'
alias stop='svc stop'
alias restart='svc restart'

# Clean-up Dead files and backups
alias tidy='find * .* -prune \( -name "*~" -o -name ".*~" -o -name "%*" -o -name "*%" -o -name ".*%" -o -name "#*#"  -o -name "core" \) -exec rm {} \; -print'
alias rmbak='find . -name "*.*~" | xargs rm && find . -name "*.swp" | xargs rm'

# MySQL Client
alias int='install_name_tool -change libmysqlclient.18.dylib /usr/local/mysql/lib/libmysqlclient.18.dylib /Users/rahmal/.rvm/gems/ruby-1.9.3-p392/gems/mysql2-0.3.13/lib/mysql2/mysql2.bundle'


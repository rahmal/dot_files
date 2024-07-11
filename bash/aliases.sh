### Aliases

# ls
alias ls='ls -G'
alias ll='ls -lrth'
alias la='ll -A'
alias lll='ll|less'
alias lla='la|less'

# vim
alias vi='vim -p'
alias vim='nvim'

# JS/Node
alias npi='npm i'

# Misc Utils
alias a='sudo apachectl'
alias syslogs='tail -f /var/log/syslog'
alias sl='syslogs'
alias more='less'
alias p='ps -ef | grep -i '
alias gpg='gpg --use-agent'
alias copy='xsel -ib'
alias paste='xsel -b'
alias last-arg='echo $(ls -1tr | tail -1)'
alias ack='ack --ignore-dir=.virtualenvs --ignore-dir=log --ignore-dir=vendor --ignore-dir=test --ignore-dir=spec --ignore-dir=images'
alias tz='tar -zxf'
alias ping='ping -c4'
alias kill='sudo kill -9'
alias mkdir='mkdir -p'
alias ...='../..'
alias vp='vim ~/.profile && source ~/.profile'
alias hosts='sudo vim /etc/hosts'
alias rd='rm -rf'

# Source/Bind
alias src='source ~/.profile'
alias inp='bind -f ~/.inputrc'
alias refresh='src && inp'

# Clean-up Dead files and backups
alias tidy='find * .* -prune \( -name "*~" -o -name ".*~" -o -name "%*" -o -name "*%" -o -name ".*%" -o -name "#*#"  -o -name "core" \) -exec rm {} \; -print'
alias rmbak='find . -name "*.*~" | xargs rm && find . -name "*.swp" | xargs rm'

# MySQL Client
alias mysql='mysql -uroot'

# Pow Server
alias pow='powder'
alias pst='pow restart'

# Misc.
alias ff='find . -name'
alias bfg='java -jar $HOME/bin/bfg.jar' # BFG Repo-Cleaner

alias direnv='/opt/homebrew/bin/direnv'
alias python='python3'

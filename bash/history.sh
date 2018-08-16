# don't put duplicate lines in the history. 
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
#shopt -s histappend

# Backup History
mkdir -p "${HOME}/.history/$(date -u +%Y/%m/)"
export PROMPT_COMMAND='history -a'
HISTFILE="${HOME}/.history/$(date -u +%Y/%m/%d.%H.%M.%S)_${HOSTNAME_SHORT}_$$"
HISTFILESIZE=10000000

#hg () {
#    grep -r "$@" ~/.history
#    history | grep "$@"
#}
#export -f hg

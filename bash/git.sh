# Git Aliases
alias g='git'
alias ga='g add'
alias gaa='ga . --all'
alias gb='g branch'
alias gba='g branch -a'
alias gbr='g branch -r'
alias gc='g commit -vam'
alias gco='g checkout'
alias gcb='gco -b'
alias gcm='g checkout master && gpl'
alias gcs='g checkout staging && gpl'
alias gcp='g checkout production && gpl'
alias gd='g diff'
alias gf='g fetch'
alias gfm='gco master'
alias gk='gitk'
alias gl='glo'
alias gm='g merge --no-ff --log'
alias gmm='gm -m "Merged latest from master." master'
alias gmv='g mv'
alias gp='g push'
alias gpo='gp origin'
alias gpu='gp -u origin'
alias gpl='g pull --no-edit'
alias grm='g rm'
alias gst='g status'
alias gcl='g clone'

alias stash='g stash'
alias pop='stash pop'
alias init='gaa && gc "Initial commit"'

function cmt {
  sid=`story_id`
  msg="[#$sid] $1"
  gc "$msg"
}

function story_id {
  story_name | awk '{split($0,a,"-"); print a[1]}'
}

function story_type {
  branch_path | awk '{split($0,a," "); print a[1]}'
}

function story_name {
  branch_path | awk '{split($0,a," "); print a[2]}'
}

function branch_path {
  echo "$(git symbolic-ref HEAD 2>/dev/null)" | awk '{split($0,a,"/"); print a[3],a[4]}'
}

function branch_name {
  name=`branch_path`
  echo "${name/ //}"
}


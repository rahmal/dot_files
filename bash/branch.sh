source "$BASH_DIR/git.sh"

alias current_branch='branch_name'
alias curb='branch_name'

function branch {
  branch-usage
  parent=""
  name=""
  jira=""

  while [ "$1" != "" ]; do
    if [[ $1 =~ ^boss|BOSS-[0-9]{3,4}$ ]]; then
      jira="$1"
    elif [[ "$1" == "--help" ]]; then
        $usage && return 1;
    elif [[ "$1" =~ ^-[h|f|b|c|p]$ ]]; then
      case $1 in
        -p) parent="$2"; shift;;
        -h) $usage && return 1;
      esac
    else
      name="$1"
    fi
    shift
  done

  if [[ -z $jira || -z $name ]]; then
    $usage && return 1;
  fi

  branch="$jira-$name"

  italic "`dark-gray branch:` "; bold "`magenta $branch`\n"

  gcm

  if [[ -n $parent ]]; then
    gco $parent
  fi

  gcb $branch
  gpu $branch
}

function diff_branch {
  usage="echo -e diff_branch [-n|s|w] [-b1 branch1] [-b2 branch2]"
  branch1="$GIT_ROOT"
  branch2=`current_branch`
  flag=""

  while [[ -n "$1" ]]; do
    case $1 in
      -h|--help) $usage && return 1;;
      -n) flag="--name-only"       ;;
      -s) flag="--name-status"     ;;
      -w) flag="--word-diff=color" ;;
      -b1) branch1="$2"; shift ;;
      -b2) branch2="$2"; shift ;;
    esac
    shift
  done

  bold 'b1: '; red $branch1; bold '  ';
  bold 'b2: '; red $branch2; bold '\n\n';

  if [[ $flag -eq "--name-only" ]]; then
    underline 'Name\n'
  elif [[ $flag -eq "--name-status" ]]; then
    underline 'S'
    bold "       "
    underline 'Name\n'
  fi

  git diff $flag $branch1 $branch2
}

function gdb {
  branch1="$GIT_ROOT"
  branch2=`current_branch`

  if [ -n "$2" ]; then
    branch1="$1"
    branch2="$2"
  elif [ -n "$1" ]; then
    branch2="$1"
  fi

 diff_branch -s -b1 $branch1 -b2 $branch2
}

function gdbs {
  branch1="$GIT_ROOT"
  branch2=`current_branch`

  if [ -n "$2" ]; then
    branch1="$1"
    branch2="$2"
  elif [ -n "$1" ]; then
    branch2="$1"
  fi

 diff_branch -b1 $branch1 -b2 $branch2
}

function cmt {
  jira=`jira_id`
  bold "`magenta [$jira]`"; italic " `dark-gray $1`\n"
  gc "[$jira] $1"
}

function jira_id {
  jid=`branch_name | awk '{split($0,a,"-"); print a[1],a[2]}' | tr " " -`
  upper-case $jid
}

function story_name {
  branch_name | awk '{split($0,a,"-"); print a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11]}' | sed -e 's/[[:space:]]*$//' | tr " " -
}

function branch_name {
  echo "$(git symbolic-ref HEAD 2>/dev/null)" | awk '{split($0,a,"/"); print a[3]}'
}

function branch-usage {
  usage="echo -e \n
    USAGE:       \n
      \t branch [OPTIONS] <jira> <name> \n\n
    DESCRIPTION  \n
      \t Sets up a new git development branch as a child of $GIT_ROOT  or the branch provided. \n\n
    OPTIONS      \n
      \t -p <branch> \t Use <branch> as parent of target    \n
      \t -h,--help   \t Display help/usage                  \n\n
    PARAMS       \n
      \t jira \t Jira project and ID number (i.e. BOSS-123) \n
      \t name \t The text to use as branch name             \n"
}

function diff-usage {
  usage="echo -e \n
    USAGE:       \n
      \t diff_branch [OPTIONS] [-b1 branch1] [-b2 branch2] \n\n
    DESCRIPTION  \n
      \t Show changes/differences in compared files of each branch. \n
      \t Or if specified, list the changed files.                   \n\n
    OPTIONS      \n
      \t -n,--name \t List file names only             \n
      \t -s,--status \t List file name and status      \n
      \t -w,--word \t Show line/word changes in detail \n
      \t -h,--help \t Display help/usage               \n\n
    PARAMS       \n
      \t -b1 <branch> \t Name of source branch (default: $GIT_ROOT) \n
      \t -b1 <branch> \t Name of target branch (default: current)   \n"
}

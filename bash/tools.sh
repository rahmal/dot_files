# Tools.sh - Helper functions for bash shell

function dot {
  path="$HOME/Projects/dot_files/."
  cp -R $1 $path
  cd $path
  ls -lah
  gst
}

function db {
  usage="echo -e USAGE: db <up|dn>"

  case $1 in
    u|up) dbd; dbc && dbm && dbs ;;
    d|dn|down|drop) dbd ;;
    c|cr|create) dbc ;;
    m|mg|migrate) dbm ;;
    seed) dbs ;;
    *) $usage && return 1 ;;
  esac
}

function upper-case {
  echo $1 | tr '[:lower:]' '[:upper:]'
}

function lower-case {
  echo $1 | tr '[:upper:]' '[:lower:]'
}

function hn {
  usage="echo -e \n
USAGE: hn [OPTIONS] <name>\n
DESCRIPTION\n
\tSets the HostName, LocalHostName, CompuerName, or all of the above, to the name provided.\n
OPTIONS\n
\t-h\t\tSet HostName (Default)\n
\t-l\t\tSet LocalHostName\n
\t-c\t\tSet ComputerName\n
\t-a\t\tSet all three names\n\n
\t--help\t\tDisplay help/usage\n"

  type="HostName"
  name=""

  while [ "$1" != "" ]; do
    if [[ "$1" == "--help" ]]; then
      $usage && return 1;
    elif [[ "$1" =~ ^-[a|h|l|c]$ ]]; then
      case $1 in
        -a) type="ALL"           ;;
        -h) type="HostName"      ;;
        -l) type="LocalHostName" ;;
        -c) type="CompuerName"   ;;
      esac
    else
      name="$1"
    fi
    shift
  done

  if [ -z "$name" ]; then
    $usage && return 1;
  fi

  if [ "$type" == "ALL" ]; then
    for type in HostName LocalHostName CompuerName; do
      sudo scutil --set $type $name
    done
  else
    sudo scutil --set $type $name
  fi

  dscacheutil -flushcache
}

function split {
  str=$1
  delim=$2
  num=$3

  if [ -z "$str" ]; then
    echo "USAGE: split <string> [delim] [num]"
    return 1;
  fi

  if [ -z "$delim" ]; then
    delim=","
  fi

  if [ -z "$num" ]; then
    num="1"
  fi

  echo [string=$str]
  echo [delim=$delim]
  echo [num=$num]

  echo $str | awk '{split($0,a,"'$delim'"); print a['$num']}'
}

function say.halt {
  local reason="$1"
  local hint="$2"
  # echo -e "\e[1;31mERROR: ${reason}. Aborting." >&2
  red "ERROR: ${reason}. Aborting. "
  # [[ -n ${hint} ]] && echo -e "\e[1;43m HINT: ${hint}" >&2
  [[ -n ${hint} ]] && blue "`bg-yellow " (HINT: ${hint})\n"`"
  # exit 1
}

function say.okay {
  local reason="$1"
  green " [ ✔︎ ] ${reason}"
}

function say {
  local reason="$1"
  magenta " [ ➔ ] "
  blue "${reason}"
}

# Tools.sh - Helper functions for bash shell

function dot {
  path="$HOME/Projects/dot_files/."
  cp -R $1 $path
  cd $path
  ls -lah
  gst
}

function branch {
  usage="echo -e \n
USAGE: branch [OPTIONS] <sid> <name>\n
DESCRIPTION\n
\tSets up a new git development branch as a child of master, based on the options provided.\n
OPTIONS\n
\t-f\t\tStory type is feature (Default)\n
\t-b\t\tStory type is bug\n
\t-c\t\tStory type is chore\n\n
\t-h,--help\tDisplay help/usage\n
PARAMS\n
\tsid \t\tStory ID number (Must be 4 digits)\n
\tname\t\tBranch name\n"

  stype="feature"
  sname=""
  sid=""

  while [ "$1" != "" ]; do
    if [[ $1 =~ ^[0-9]{3,4}$ ]]; then
      sid="$1"
    elif [[ "$1" == "--help" ]]; then
        $usage && return 1;
    elif [[ "$1" =~ ^-[h|f|b|c]$ ]]; then
      case $1 in
        -f) stype="feature" ;;
        -b) stype="bug"     ;;
        -c) stype="chore"   ;;
        -h) $usage && return 1;
      esac
    else
      sname="$1"
    fi
    shift
  done

  if [[ -z $stype || -z $sid || -z $sname ]]; then
    $usage && return 1;
  fi

  branch="RETURN-$sid-$sname"
  echo "branch: $branch"
  gcm
  gcb $branch
  gpu $branch
}

function db {
  usage="USAGE: db <up|dn>"

  if [ -z "$1" ]; then
    echo $usage && return 1;
  fi

  case $1 in
    u|up) dbd; dbc && dbm && dbs ;;
    d|dn|down|drop) dbd ;;
    c|cr|create) dbc ;;
    m|mg|migrate) dbm ;;
    seed) dbs ;;
    *) echo $usage && return 1 ;;
  esac
}

function gdb {
  b1="master"
  b2=`gb | grep "*" | awk '{print $2}'`
  if [ -n "$2" ]; then
    b1="$1"
    b2="$2"
  elif [ -n "$1" ]; then
    b2="$1"
  fi
 echo "[$b1] -- [$b2]"
 gd --name-status $b1 $b2
}

function running {
  if [ -z "$1" ]; then
    echo "usage: running <processname>";
    return 1;
  fi
  ps aux | grep $1 | grep -v grep
}

function pgrep {
  if [ -z "$1" ]; then
    echo "usage: pgrep <processname>";
    return 1;
  fi
  ps aux | grep $1 | grep -v grep | awk '{print $2}'
}

function pkill {
  if [ -z "$1" ]; then
    echo "usage: pkill <processname>";
    return 1;
  fi
  pid=`pgrep $1`;
  echo "Killing ${pid}..."
  if [ -n "$pid" ]; then
    kill $pid
  fi
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

function show_usage {
  $usage && return 1;
}

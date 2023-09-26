# Process Helpers

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

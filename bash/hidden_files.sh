function hidden_files {
  usage="USAGE: hidden_files <show|hide>"

  case $1 in
    show) flag="YES" ;;
    hide) flag="NO"  ;;
       *) echo $usage && return 1;;
  esac

  defaults write com.apple.Finder AppleShowAllFiles $flag
  killall Finder
}

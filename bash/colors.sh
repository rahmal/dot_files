# Black      0;30   Dark Gray    1;30 
# Red        0;31   Light Red    1;31 
# Green      0;32   Light Green  1;32 
# Brown      0;33   Yellow       1;33 
# Blue       0;34   Light Blue   1;34 
# Purple     0;35   Light Purple 1;35 
# Cyan       0;36   Light Cyan   1;36 
# Light Gray 0;37   White        1;37 


 DARK_GREY="\[\033[1;30m\]"
LIGHT_GREY="\[\033[0;37m\]"

LIGHT_BLUE="\[\033[1;34m\]"
      BLUE="\[\033[0;34m\]"

       RED="\[\033[0;31m\]"
 LIGHT_RED="\[\033[1;31m\]"
  RED_BOLD="\[\033[01;31m\]"

BLACK="\[\033[0;30m\]"
BROWN="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
 CYAN="\[\033[1;36m\]"
WHITE="\[\033[1;37m\]"
BG1="\[\033[44m\]"
BG2="\[\033[41m\]"

# Enable color support 
color_prompt=yes
export CLICOLOR="1" 
export LSCOLORS="FxFxCxDxBxegedabagacad"

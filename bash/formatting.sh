# Bash tips: Colors and formatting

function ansi          { printf "\e[${1}m${*:2}\e[0m"; }

# Formatting
function bold          { ansi 1 "$@"; }
function dim           { ansi 2 "$@"; }
function italic        { ansi 3 "$@"; }
function underline     { ansi 4 "$@"; }
function blink         { ansi 5 "$@"; }
function invert        { ansi 7 "$@"; }
function strikethrough { ansi 9 "$@"; }

# Foreground Colors
function black         { ansi 30 "$@"; }
function red           { ansi 31 "$@"; }
function green         { ansi 32 "$@"; }
function yellow        { ansi 33 "$@"; }
function blue          { ansi 34 "$@"; }
function magenta       { ansi 35 "$@"; }
function cyan          { ansi 36 "$@"; }
function light-gray    { ansi 37 "$@"; }

function dark-gray     { ansi 90 "$@"; }
function light-red     { ansi 91 "$@"; }
function light-green   { ansi 92 "$@"; }
function light-yellow  { ansi 93 "$@"; }
function light-blue    { ansi 94 "$@"; }
function light-magenta { ansi 95 "$@"; }
function light-cyan    { ansi 96 "$@"; }
function white         { ansi 97 "$@"; }

# Background Colors
function bg-black      { ansi 40 "$@"; }
function bg-red        { ansi 41 "$@"; }
function bg-green      { ansi 42 "$@"; }
function bg-yellow     { ansi 43 "$@"; }
function bg-blue       { ansi 44 "$@"; }
function bg-magenta    { ansi 45 "$@"; }
function bg-cyan       { ansi 46 "$@"; }
function bg-light-gray { ansi 47 "$@"; }

function bg-dark-gray  { ansi 100 "$@"; }
function bg-lt-red     { ansi 101 "$@"; }
function bg-lt-green   { ansi 102 "$@"; }
function bg-lt-yellow  { ansi 103 "$@"; }
function bg-lt-blue    { ansi 104 "$@"; }
function bg-lt-magenta { ansi 105 "$@"; }
function bg-lt-cyan    { ansi 106 "$@"; }
function bg-white      { ansi 107 "$@"; }

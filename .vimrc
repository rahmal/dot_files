" set options

syntax on
filetype plugin indent on

set background=dark
set nocompatible
set hlsearch
set incsearch
set ignorecase
set smartcase
set ruler
set number
set showcmd
set showmatch
set showmode
set tabstop=2          " Set tabs as two spaces
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent
set wmh=0
set cindent
set autoread
set encoding=utf-8
set nobackup
set writebackup
set guifont=Monaco:h14 " Font style:size
set guioptions=aAce    " colsole dialogs
set guioptions-=T      " No toolbar
set guioptions-=r      " No right scrollbar
set go-=L              " No left scrollbar
set vb                 " No audible bell
set list
set listchars=tab:>=,trail:~,extends:>,precedes:<,nbsp:.
set wildmenu              " Make file/command completion useful
set wildmode=longest,full " Show a wildmenu when try to find a command or file
set diffopt=iwhite       " ignore whitespace in diff mode
set grepprg=ack           " ACK integration
set grepformat=%f:%l:%m   " ACK format

:set cpoptions+=$      " puts a $ marker for the end of words/lines in cw/c$ commands

autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
autocmd BufWritePre * :%s/\s\+$//e " remove trailing white-space when saving a file

" colorscheme distinguished
" colorscheme crayon
colorscheme jellybeans

" set mappings

" control n kills search hilighting
nmap <silent> <C-N> :silent noh<CR>

" control j and control k switch panes and maximize
nmap <C-J> <C-W>j<C-W>_
nmap <C-K> <C-W>k<C-W>_

" moving over wrapped lines moves to next visual not physical line
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
nmap <silent> j gj
nmap <silent> k gk

" block commenting mappings , and comment characteer will add lhs comment
" character ,c will clear
map ,# :s/^/#/<CR>
map ,/ :s/^/\/\//<CR>
map ,> :s/^/> /<CR>
map ,” :s/^/\”/<CR>
map ,% :s/^/%/<CR>
map ,! :s/^/!/<CR>
map ,; :s/^/;/<CR>
map ,- :s/^/–/<CR>
map ,c :s/^\/\/\\|^–\\|^> \\|^[#”%!;]//<CR>

" set ff as default browser
command -bar -nargs=1 OpenURL :!firefox <args> 2>&1 >/dev/null &

" Move between tabs
nmap t% :tabedit %<CR>
nmap td :tabclose<CR>
nmap tn :tabnew<CR>

let mapleader = "\\"

" Slime
let g:slime_target = "tmux"

" Fuzzy Finder
map <leader>F :FufFile<CR>
map <leader>f :FufTaggedFile<CR>
map <leader>s :FufTag<CR>

" NerdTree
map <F12> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeMirror = 1
"let g:NERDTreeWinPos = "right"

" Ctags/EasyTags/Tag List
"let g:easytags_file = '~/.vim/tags'
"let g:easytags_cmd = '/usr/local/bin/ctags'
"set updatetime=4000

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_WinWidth = 50
map <F14> :TlistToggle<CR>

" Paste from X clipboard to vim
" Commented to use Visual blocks
vnoremap <C-C> "+y
"noremap <C-V> <ESC>"+gP
inoremap <C-V> <ESC>"+gPi

" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

"Plugin 'Valloric/YouCompleteMe'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


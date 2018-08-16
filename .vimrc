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


"ACK integration
set grepprg=ack
set grepformat=%f:%l:%m

" Make file/command completion useful
" Show a wildmenu when try to find a command or file
set wildmenu
set wildmode=longest,full

" Read on comments:
set diffopt+=iwhite " ignore whitespace in diff mode



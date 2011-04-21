set encoding=utf-8
set incsearch
set ignorecase
set smartcase
set scrolloff=5
set number
set smartindent
set ts=3
set shiftwidth=3
set softtabstop=3
set wrap
set linebreak
set nolist
set wildmenu
set ruler
set guioptions-=T
set completeopt-=preview
set cmdheight=2
set laststatus=2
set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w

let no_buffers_menu=1
set mousemodel=popup

" This will turn off the menu bars in gVim
set guioptions-=m
set guioptions-=T

" Change the leader key to be a ',' (comma)
let mapleader = ","

" This will set the colorscheme
set t_Co=256
set background=dark
colorscheme solarized

" Enable Autoloading for FileType
filetype on
filetype plugin on

" Autoloads for Python
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate

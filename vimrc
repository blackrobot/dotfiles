" This is my vimrc file. The first few lines are just general setup, there's
" other stuff which is more specific to the language i'm using.
"
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

filetype on
filetype plugin on

" This will enable fuzzy finder like textmate has.
let mapleader = ","
map <leader>f :FuzzyFinderFile<CR>

" This is for python
source ~/Workspace/dotfiles/vim/source/python-ide.vim

set guioptions-=m
set guioptions-=T

set t_Co=256
" set background=light
set background=dark
colorscheme solarized

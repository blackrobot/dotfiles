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

let no_buffers_menu=1
set mousemodel=popup

filetype on
filetype plugin on

let mapleader = ","

map <leader>t :FuzzyFinderTextMate<CR>

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
syntax enable

set wildmenu
set ruler
set guioptions-=T
set completeopt-=preview
set gcr=a:blinkon0

let g:explHideFiles='^\.,.*\.sw[po]$,.*\.pyc$'

fun! s:SelectHTML()
	let n = 1
	while n < 50 && n < line("$")
		if getline(n) =~ '{%\s*\(extends\|block\|comment\|ssi\|if\|for\|blocktrans\)\>'
			set ft=htmldjango
			return
		endif
	endwhile
endfun

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0

autocmd BufRead *.html setfiletype htmldjango

set cmdheight=2
set laststatus=2
set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w

let g:closetag_html_style=1

set t_Co=256
colorscheme jellybeans

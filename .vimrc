syntax enable

set background=dark
colorscheme default

if $TERM =~ '^\(tmux\|iterm\|vte\|gnome\)\(-.*\)\?$'
  set termguicolors
endif

if &compatible
  set nocompatible
endif

set encoding=utf-8
set lazyredraw

" Change the leader key to ','
let mapleader=","

" Use the default clipboard for the host operating system
set clipboard+=unnamedplus

set number
set relativenumber

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent
set shiftround

set smartcase

filetype plugin indent on

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Spelling
set spelllang=en_us
set spellfile=$DOTFILES/vim/dictionary.en.utf-8.add

" Wildignore
set wildignore+=*.pyc,*.zip,*.gz,*.tar
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.ico,*.psd,*.swf
set wildignore+=*.pdf,*.doc,*.docx
set wildignore+=.gitkeep

" Command tabbing
" set wildmode=longest,list,full
set wildmenu

" Terminal
autocmd TermOpen * setlocal bufhidden=hide

if has('persistent_undo')
  set undofile
endif

""
" Vim Plug
""
" https://github.com/junegunn/vim-plug
"
" Install by downloading the vim script and putting it in the right directory:
"
"   # neovim
"   $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"   # vim
"   $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
""
call plug#begin('~/.vim/plugged')

let brew_prefix = system('brew --prefix') . '/'

" FZF
" Plug $brew_prefix . 'opt/fzf' " '/usr/local/opt/fzf'
Plug '/opt/homebrew/opt/fzf' " '/usr/local/opt/fzf'

" Better Whitespace
let g:better_whitespace_enabled=1
Plug 'ntpeters/vim-better-whitespace'

call plug#end()


" Highlight codetags
augroup codetags
  autocmd!
  autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|XXX\|???\|!!!\|BUG\|HACK\|NOTE\|INFO\|IDEA\):')
augroup END

" Highlight trailing whitespace
highlight BadWhitespace ctermbg=red guibg=red

" Python
augroup python
  autocmd!
  autocmd FileType python let &l:colorcolumn="80,".join(range(120,999),",")
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType python setlocal sts=4 sw=4 ts=4 tw=79
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e``
  autocmd BufRead,BufNewFile *.py match BadWhitespace /^\t\+/
  " autocmd BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
augroup END

" Git messages
augroup gitcommit
  autocmd!
  autocmd FileType gitcommit setlocal colorcolumn=73
augroup END

" Markdown & Text
augroup text_settings
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.txt,*.scratch setlocal spell wrap
augroup END

" Docker
augroup docker_settings
  autocmd!
  autocmd BufNewFile,BufRead .dockerignore setlocal filetype=conf
augroup END

" Cron
augroup crontab_settings
  autocmd!
  autocmd FileType crontab setlocal backupcopy=yes
augroup END


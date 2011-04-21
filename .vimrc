set encoding=utf-8
set incsearch
set ignorecase
set smartcase
set scrolloff=5
set number
set numberwidth=4
set smartindent
set ts=3
set shiftwidth=3
set softtabstop=3
set wrap
set linebreak
set nolist
set wildmenu
set ruler
set showcmd
set completeopt-=preview
set cmdheight=2
set cursorline
set laststatus=2
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<
set nu
set mouse=a
set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w
set nocompatible
set title
set ttyfast
set shortmess=atI
set wildmode=list:longest
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*.DS_Store,*.db
let python_highlight_all=1
syntax on

let no_buffers_menu=1
set mousemodel=popup

" This will turn off the menu bars in gVim
set guioptions-=m
set guioptions-=T
set guioptions-=L

"" Hide hidden and pyc files
let g:explHideFiles='^\.,.*\.pyc$'

" Trim tailing whitespace
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" Auto Indent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"" Dont Beep!
set noerrorbells        " don't beep!
set visualbell          " don't beep!
set t_vb=               " don't beep! (but also see below)

"" Backup Files
set backup              " make backups
set backupdir=~/tmp     " but don't clutter $PWD with them
if !isdirectory(&backupdir)
    " create the backup directory if it doesn't already exist
    exec "silent !mkdir -p " . &backupdir
endif

" Show trailing whitespace and spaces before tabs
hi link localWhitespaceError Error
autocmd Syntax * syn match localWhitespaceError /\(\zs\%#\|\s\)\+$/ display
autocmd Syntax * syn match localWhitespaceError / \+\ze\t/ display

"" Sane Folding
set foldlevel=9999        " initially open all folds
" Space folds and unfolds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
inoremap <Nul> @=(foldlevel('.')?'zM':'l')<CR>

"" Auto close pydoc after omnicompletion
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Change the leader key to be a ',' (comma)
let mapleader = ","

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" This will set the colorscheme
set t_Co=256
set background=dark
colorscheme solarized

" Copy & Paste <ctrl> C/V
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Minibuff Explorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" TaskList
map T :TaskList<CR>
map P :TlistToggle<CR>

" TagList
let Tlist_Ctags_Cmd='/usr/bin/ctags' " point taglist to ctags
let Tlist_Exit_OnlyWindow = 1 " Close vim when only taglist window left
let Tlist_File_Fold_Auto_Close = 1 " Close folds for inactive files
let Tlist_Auto_Highlight_Tag = 1 " Automatically highlight the current tag
let Tlist_Auto_Open = 1 " Auto open taglist
let Tlist_Auto_Update = 1
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 1
let Tlist_File_Fold_Auto_Close = 1 " Close for inactive buffers
let Tlist_Highlight_Tag_On_BufEnter = 0 " Don't highlight on buffer enter
let Tlist_GainFocus_On_ToggleOpen = 0 " Focus on the taglist when its toggled
let Tlist_Show_Menu = 1 " Show menu for taglist

" Enable Autoloading for FileType
filetype on
filetype plugin on
set iskeyword+=.

" Toggle Stuff
map <F3> :NERDTreeToggle<CR>
map <F4> :TlistToggle<CR>
map <F2> :marks 
map <leader>f :FuzzyFinderTextMate<CR>

""""""""""""""""
"""" PYTHON """"
""""""""""""""""

"" Add workpath to python
python << EOF
import os
import sys
import vim
sys.path.append("/opt")
sys.path.append("/opt/xanview")
EOF

" Autoloads for Python
autocmd FileType python set softtabstop=4
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType python set omnifunc=pythoncomplete#Complete
" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*html,*js set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
au BufRead,BufNewFile *.py,*pyw,*.html,*.js set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.html,*.js set expandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Folding based on indentation: 
set foldmethod=indent
set nofoldenable

""""""""""""""""""""
"""" JAVASCRIPT """"
""""""""""""""""""""

" Autoloads for Javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS " For OmniComplete

" Autoloads for HTML
autocmd FileType html set ft=htmldjango.html " For SnipMate
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags " For OmniComplete

" Autoloads for CSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS " For OmniComplete

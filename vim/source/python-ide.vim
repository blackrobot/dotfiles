" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*html,*js set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw,*.html,*.js set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.html,*.js set expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: No limit
" C: 79
" Uncomment this if you want to limit your textwidth in python
" can be very annoying ..
" au BufRead,BufNewFile *.py,*.pyc set textwidth=79
au BufRead,BufNewFile *.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: 
set encoding=utf-8

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Automatically indent based on file type: 
"filetype indent on
" Keep indentation level from previous line: 
"set autoindent

" Folding based on indentation: 
set foldmethod=indent
set nofoldenable

""""""""""""""""""""""""""""""""
" END http://svn.python.org/projects/python/trunk/Misc/Vim/vimrc
""""""""""""""""""""""""""""""""

filetype plugin on
set iskeyword+=.

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" inoremap <Nul> <C-x><C-o>

" setlocal tabstop=4
set softtabstop=4
" setlocal shiftwidth=4
" setlocal textwidth=80
" setlocal smarttab
" setlocal expandtab
" setlocal smartindent
" set noic "no ignore case
" set t_Co=256

set cursorline
set laststatus=2
"set clipboard=unnamed
"set go+=a
"vnoremap y "+y
"set paste
se nu
set mouse=a
set background=dark

"http://vim.wikia.com/wiki/In_line_copy_and_paste_to_system_clipboard
"sudo apt-get install xclip
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

"This should be in /etc/vim/vimrc or wherever you global vimrc is.
"But, if not, I for one can't live without it.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"" Enable filetype detection and file plugins
set nocompatible
filetype on
filetype plugin on

" General
set cursorline          " underline current line
set mouse=a             " enable mouse
set laststatus=2        " always show a status line
set scrolloff=3         " keep 3 lines when scrolling
set guioptions-=L       " disable left scrollbar in GUI
set showcmd             " show partial commands in status line
set ruler               " show cursor position in status line
set list                " show tabs and spaces at end of line:
set listchars=tab:>-,trail:.,extends:>,precedes:<
set hlsearch            " highlight search matches
set incsearch           " use incremental search
set number              " show line numbers
set numberwidth=4       " line numbers take up 5 spaces
set ignorecase          " ignore case when searching
set title               " show title in console title bar
set ttyfast             " smoother changes
set shortmess=atI       " abbreviate messages and suppress welcome
set nostartofline       " don't jump to first character when paging
set wildmode=list:longest " enable nice tab completion on command line
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*.DS_Store,*.db  " ignore some file types
if has("extra_search")
    nohlsearch          " but not initially
endif

"" Hide hidden and pyc files
let g:explHideFiles='^\.,.*\.pyc$'

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

"" Hilight ends of long lines and unwanted whitespace
"" autocmd BufWinEnter * let w:m1=matchadd('Search', '\%>80v.\+', -1)

" Show trailing whitespace and spaces before tabs
hi link localWhitespaceError Error
autocmd Syntax * syn match localWhitespaceError /\(\zs\%#\|\s\)\+$/ display
autocmd Syntax * syn match localWhitespaceError / \+\ze\t/ display

"" Auto close pydoc after omnicompletion
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

"" Javascript lint and jquery syntax
autocmd BufWritePost,BufLeave,BufWinEnter *.js :JSLint
autocmd BufRead,BufNewFile *.js set ft=javascript.jquery

"" Tab navigation firefox style
:nmap <C-S-tab> :tabprevious<cr>
:nmap <C-tab> :tabnext<cr>
:imap <C-S-tab> <ESC>:tabprevious<cr>i
:imap <C-tab> <ESC>:tabnext<cr>i
:nmap <C-t> :tabnew<cr>
:imap <C-t> <ESC>:tabnew<cr>i

"" Closetag plugin
autocmd FileType djangohtml,html,xhtml,xml source ~/.vim/plugin/closetag.vim

"" Sane omnicompletion
let g:SuperTabDefaultCompletionType = "<c-x><c-O>"
set completeopt=menu,preview,longest
set pumheight=5

"" Sane Folding
set foldlevel=9999        " initially open all folds
" Space folds and unfolds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
inoremap <Nul> @=(foldlevel('.')?'zM':'l')<CR>

"" xml folding
"" autocmd BufNewFile,BufRead *.xml,*.htm,*.html so XMLFolding

" ctrl+f should fullscreen
nnoremap <c-f> :ZoomWin<CR>

"" Rope refactoring tool
let ropevim_vim_completion=1
let ropevim_extended_complete=1
nnoremap <silent> <S-z> :RopeShowDoc<CR>

"" Sane whitespace and tab
set tabstop=8
set shiftwidth=4
set smarttab
set expandtab
set textwidth=79
set softtabstop=4
set autoindent
syntax on
" Trim tailing whitespace
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" Auto Indent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"" Detect django models file
if getline(1) =~ 'from django.db import models'
    runtime! ftplugin/django_model_snippets.vim
endif 

"" Remember last position in file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"" NERD_tree config
" let NERDTreeChDirMode=2
" let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
" let NERDTreeShowBookmarks=1
set tags=tags;$HOME/.vim/tags/ "recursively searches directory for 'tags' file

"" TagList Plugin Configuration
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

"" TaskList
" autocmd BufWinEnter * silent :TaskList

"" Show recent files when opening vim
" autocmd BufWinEnter * :MRU
argdo let file_specified=1
if !exists('file_specified')
    autocmd VimEnter * :MRU
endif

map <F3> :NERDTreeToggle<CR>
map <F4> :TlistToggle<CR>
map <F2> :marks 

"" Add workpath to python
python << EOF
import os
import sys
import vim
sys.path.append("/opt")
sys.path.append("/opt/xanview")
EOF

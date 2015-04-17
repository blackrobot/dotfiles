" Pathogen
execute pathogen#infect()

" Basic config
set encoding=utf-8
set number
let mapleader=","

" Colors!
syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized

" Highlight the cursor's current line
set cursorline

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Highlight the 80th column
set colorcolumn=80

" Ctrl-P & Wild ignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -cmo --exclude-standard']
set wildignore+=*.pyc,*.zip,*.gz,*.tar
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.ico,*.psd,*.swf
set wildignore+=*.pdf,*.doc,*.docx
set wildignore+=.gitkeep

" Change the indent defaults
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Command tabbing
set wildmode=longest,list,full
set wildmenu

au FileType python setlocal sts=4 sw=4 ts=4 tw=79

" Syntax
au BufNewFile,BufRead *.scss setlocal filetype=scss
au BufNewFile,BufRead *.html setlocal filetype=htmldjango
au BufnewFile,BufRead *.slim setlocal filetype=slim
au BufNewFile,BufRead /etc/nginx/*,*/nginx/*.conf setlocal filetype=nginx
au BufnewFile,BufRead xorg.conf* setlocal filetype=xf86conf

" Omnicomplete
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS

" Close that stupid YCM preview window
let g:ycm_autoclose_preview_window_after_completion=1

" Python stuff
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E403,E128,F403'
au BufWritePre *.py normal m`:%s/\s\+$//e``
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

" Indent Guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2
let g:indent_guides_enable_on_vim_startup = 1

" Use silver-searcher (ag) instead of ack-grep
let g:ackprg = 'ag --nogroup --nocolor --column'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Gist
let g:gist_post_private = 1

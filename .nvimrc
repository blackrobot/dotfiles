""
"" Janus setup
""

" Explicitly set the python host
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Define paths
let g:janus_path = expand("~/.vim/janus/vim")
let g:janus_vim_path = expand("~/.vim/janus/vim")
let g:janus_custom_path = expand("~/.janus")

" Source janus's core
exe 'source ' . g:janus_vim_path . '/core/before/plugin/janus.vim'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Other stuff
  call dein#add('sheerun/vim-polyglot')
  call dein#add('mhartington/oceanic-next')

  " Deoplete
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neco-syntax')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('Shougo/neco-vim')
  call dein#add('carlitux/deoplete-ternjs')
  call dein#add('Shougo/neopairs.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/echodoc.vim')
  call dein#add('zchee/deoplete-zsh')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
  call dein#remote_plugins()
endif

"End dein Scripts-------------------------

" You should note that groups will be processed by Pathogen in reverse
" order they were added.
call janus#add_group("tools")
call janus#add_group("langs")
call janus#add_group("colors")


""
"" Customisations
""

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

if filereadable(expand("~/.vimrc.before"))
  " fzf
  set rtp+=/usr/local/opt/fzf
  call janus#disable_plugin('ctrlp')
  source ~/.vimrc.before
endif


" Disable plugins prior to loading pathogen
exe 'source ' . g:janus_vim_path . '/core/plugins.vim'

""
"" Pathogen setup
""

" Load all groups, custom dir, and janus core
call janus#load_pathogen()

" .vimrc.after is loaded after the plugins have loaded

" Fuzzy File Finder (fzf)
let g:fzf_layout = { 'down': '~15%' }

nnoremap <Leader>ff :GitFiles<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fa :Ag<Space>
nnoremap <C-p> :Files<CR>

" Terminal
" tnoremap “ <C-\><C-n>
let g:terminal_scrollback_buffer_size = 10000
autocmd TermOpen * setlocal bufhidden=hide

"
" <deoplete>
"

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#max_list = 20

" Taken from rafi/vim-config -> https://git.io/v5ZUz
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#max_abbr_width = 35
let g:deoplete#max_menu_width = 20
let g:deoplete#skip_chars = ['(', ')', '<', '>']
let g:deoplete#tag#cache_limit_size = 800000
let g:deoplete#file#enable_buffer_path = 1


" use tab for completion
" inoremap <silent><expr> <Tab>
"   \ pumvisible() ? "\<C-n>" :
"   \ deoplete#mappings#manual_complete()
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
		endfunction"}}}

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
autocmd CompleteDone * silent! pclose!

" Deoplete Jedi
let g:deoplete#sources#jedi#show_docstring = 1

" Deoplete Tern
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#filetypes = [ 'jsx', 'javascript.jsx', 'js' ]

let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
let g:deoplete#omni#functions.css = 'csscomplete#CompleteCSS'
let g:deoplete#omni#functions.html = 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.markdown = 'htmlcomplete#CompleteTags'
" let g:deoplete#omni#functions.javascript =
"	\ [ 'tern#Complete', 'jspc#omni', 'javascriptcomplete#CompleteJS' ]

let g:deoplete#sources#jedi#statement_length = 30
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#short_types = 1

call deoplete#custom#set('_', 'min_pattern_length', 2)

let g:deoplete#sources = get(g:, 'deoplete#sources', {})

let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})
let g:deoplete#omni_patterns.html = '<[^>]*'
" let g:deoplete#omni_patterns.javascript = '[^. *\t]\.\w*'
" let g:deoplete#omni_patterns.javascript = '[^. \t]\.\%\(\h\w*\)\?'

let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns', {})
let g:deoplete#omni#input_patterns.xml = '<[^>]*'
let g:deoplete#omni#input_patterns.md = '<[^>]*'
let g:deoplete#omni#input_patterns.css  = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.sass = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#omni#input_patterns.javascript = ''

" Default rank is 100, higher is better.
call deoplete#custom#set('omni',          'mark', '⌾')
call deoplete#custom#set('ternjs',        'mark', '⌁')
call deoplete#custom#set('jedi',          'mark', '⌁')
call deoplete#custom#set('vim',           'mark', '⌁')
call deoplete#custom#set('neosnippet',    'mark', '⌘')
call deoplete#custom#set('tag',           'mark', '⌦')
call deoplete#custom#set('around',        'mark', '↻')
call deoplete#custom#set('buffer',        'mark', 'ℬ')
call deoplete#custom#set('tmux-complete', 'mark', '⊶')
call deoplete#custom#set('syntax',        'mark', '♯')

call deoplete#custom#set('vim',           'rank', 630)
call deoplete#custom#set('ternjs',        'rank', 620)
call deoplete#custom#set('jedi',          'rank', 610)
call deoplete#custom#set('omni',          'rank', 600)
call deoplete#custom#set('neosnippet',    'rank', 510)
call deoplete#custom#set('member',        'rank', 500)
call deoplete#custom#set('file_include',  'rank', 420)
call deoplete#custom#set('file',          'rank', 410)
call deoplete#custom#set('tag',           'rank', 400)
call deoplete#custom#set('around',        'rank', 330)
call deoplete#custom#set('buffer',        'rank', 320)
call deoplete#custom#set('dictionary',    'rank', 310)
call deoplete#custom#set('tmux-complete', 'rank', 300)
call deoplete#custom#set('syntax',        'rank', 200)

"
" </deoplete>
"

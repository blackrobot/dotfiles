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

" You should note that groups will be processed by Pathogen in reverse
" order they were added.
call janus#add_group("tools")
call janus#add_group("langs")
call janus#add_group("colors")

""
"" Customisations
""

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
let g:fzf_layout = { 'down': '~20%' }

nnoremap <Leader>ff :GitFiles<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fa :Ag<Space>
nnoremap <C-p> :Files<CR>

" Terminal
" tnoremap “ <C-\><C-n>
let g:terminal_scrollback_buffer_size = 10000
autocmd TermOpen * setlocal bufhidden=hide

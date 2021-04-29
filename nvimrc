""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvimrc {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We need these folders to exist
call system('mkdir -p ~/.vim/session/' )           " session files (shared with vim)
call system('mkdir -p ~/.config/nvim/backup/' )    " backups folder
call system('mkdir -p ~/.config/nvim/undo/' )      " undo folder
call system('mkdir -p ~/.config/nvim/swap/' )      " swap files
call system('mkdir -p ~/.config/nvim/autoload/' )  " autoload folder
call system('mkdir -p ~/.config/nvim/plugged/')    " plugin folder

call system('mkdir -p ~/.cache/tags/')

" Figure out the system python for neovim - we assume that the neovim python
" server has been installed globally.
let g:python3_host_prog="/Users/justin/.asdf/shims/python3"
let g:loaded_python_provider=0

" Install vim plug if not already
if glob("~/.config/nvim/autoload/plug.vim") ==# ""
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/dotfiles/nvimrc
endif

" Add plugins here
call plug#begin('~/.config/nvim/plugged')

Plug 'beanpuppy/vimroot'
Plug 'beanpuppy/git-blame-nvim'

" tools
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'axvr/zepl.vim'
Plug 'rhysd/clever-f.vim'
Plug 'machakann/vim-sandwich'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sleuth'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'clojure-vim/vim-jack-in'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'easymotion/vim-easymotion'

" languages
Plug 'rust-lang/rust.vim'
Plug 'elmcast/elm-vim'
Plug 'arzg/vim-rust-syntax-ext'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'gabrielelana/vim-markdown'
Plug 'evanleck/vim-svelte'
Plug 'elixir-editors/vim-elixir'
Plug 'cakebaker/scss-syntax.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'Olical/conjure', {'tag': 'v4.7.0'}
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'purescript-contrib/purescript-vim'
Plug 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }
Plug 'uarun/vim-protobuf'

" display
Plug 'itchyny/lightline.vim'
Plug 'drzel/vim-line-no-indicator'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentline'
Plug 'psliwka/vim-smoothie'
Plug 'pacha/vem-tabline'
Plug 'TaDaa/vimade'
Plug 'ryanoasis/vim-devicons'
Plug 'kristijanhusak/defx-icons'
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'

" themes
Plug 'rafi/awesome-vim-colorschemes'

" Initialise plugin system
call plug#end()

" remove all existing autocmds
autocmd!

filetype off
syntax on
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

" faster gitgutter
set updatetime=100
" remember more commands and search history
set history=1000
set tabstop=4
set shiftwidth=4
set autoindent
set incsearch
set showmatch
set expandtab
set nu
" Split predictably below
set splitbelow
" Split redictably right
set splitright
" make searches case-sensitve if they contain upper-case chars
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set hidden
" make split char a solid line
set fillchars+=vert:\│
" set backups/undos
set backup
set undofile
set backupdir=$HOME/.config/nvim/backup/
set directory=$HOME/.config/nvim/swap/
set undodir=$HOME/.config/nvim/undo/
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" make tab completion for files/buffers act like bash
set wildmode=longest,list
" folding
set fdm=marker
set foldlevel=99
" keep 3 lines below and above the cursor
set scrolloff=3
" if a file is changed outside vim reload it without asking
set autoread
" hlsearch
set hlsearch
" look in the current directory for 'tags', and work up the tree towards root until one is found.
set tags=./tags;/
" set conceal
set conceallevel=0
" set modelines
set modeline
set modelines=5
" Command menu
set wildmenu
" Make repeated presses cycle between all matching choices
set wildmode=longest,full
" better command line completion
set fileignorecase
set wildignorecase
" wildignore
set wildignore=*.o
set wildignore+=*~
set wildignore+=*.pyc
set wildignore+=.git/*
set wildignore+=.hg/*
set wildignore+=.svn/*
set wildignore+=*.DS_Store
set wildignore+=CVS/*
set wildignore+=*.mod
" Keep the cursor on the same column
set nostartofline
" Replace live preview
set inccommand=nosplit
" Set global replace as default
set gdefault
" Hide `-- INSERT --` at bottom
set noshowmode
" Show trailing whitespace
set list
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
tnoremap <Esc> <C-\><C-n>

" tab traverse
nnoremap <silent> == gt
nnoremap <silent> -- gT

nnoremap <silent>tt :Defx -toggle -split=vertical -winwidth=40 -direction=topleft -columns=indent:icons:filename:type<CR>

" Split vertical
nnoremap <silent> vv <C-w>v
" Split horizontal
nnoremap <silent> ss <C-w>s

" window traverse
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" buffer traverse
nmap <Tab>j <Plug>vem_next_buffer-
nmap <Tab>k <Plug>vem_prev_buffer-
" vem-tabline
nmap <Tab>h <Plug>vem_move_buffer_left-
nmap <Tab>l <Plug>vem_move_buffer_right-
" close current buffer and move to previous one
nnoremap <Tab>q :bp <BAR> bd #<CR>

" move 'correctly' on wrapped lines
nnoremap j gj
nnoremap k gk

" save files as sudo
cnoremap w!! w !sudo tee > /dev/null %

" undotree
nnoremap <silent> U :UndotreeToggle <BAR> :UndotreeFocus<CR>

" Enable folding/unfold with the spacebar
nnoremap <space> za
nnoremap <leader><space> zR

" no highlight
nnoremap // :let@/=""<CR>

" Reference current file's path
cnoremap <expr> %% expand('%:h').'/'

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" move lines and blocks
" normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" visual mode (blocks)
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" indent a line
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>

" qq to record, leader-q to replay
nnoremap <Leader>q @q

" Nearby find and replace
nnoremap <silent> <Leader>c :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> <Leader>c "sy:let @/=@s<CR>cgn
xnoremap <CR> <Esc>.
nnoremap <CR> gnzz
nnoremap ! ungnzz

" Split line
nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>

" copy and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

command! STemp :SSave! __temp__


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clear swap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ClearSwap()
  let l:nvimopen = systemlist("ps aux | grep 'nvim\s'")
  if len(l:nvimopen) <= 1
    call system('rm -f ~/.config/nvim/swap/*')
  endif
endfunction

" Folds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi Folded term=bold cterm=NONE ctermfg=lightblue
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = '·'
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" Create dir
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file !~# '\v^\w+\:\/'
    call mkdir(fnamemodify(a:file, ':h'), 'p')
  endif
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Startify config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_session_dir = '~/.vim/session' " share sessions with normal vim
let g:startify_custom_header = [
\ '   cow died of death rip in piece . uwu ',
\ ]

let g:startify_list_order = [
\ ['   My sessions:'],
\ 'sessions',
\ ['   My most recently used files in the current directory:'],
\ 'dir',
\ ['   My most recently used files:'],
\ 'files',
\ ['   My bookmarks:'],
\ 'bookmarks',
\ ['   My commands:'],
\ 'commands',
\]

" Close Cleanup
let g:startify_session_before_save = [
\ 'silent! defx#do_action("close")',
\]

let g:startify_bookmarks = [
\ { 'n': '~/dotfiles/nvimrc' },
\ { 'z': '~/dotfiles/zshrc' },
\]

" Coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Indent lines
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_enabled = 1
let g:indentLine_char = "┆"

" Context filetype
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes.svelte =
\ [
\    {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\    {'filetype' : 'css', 'start' : '<style>', 'end' : '</style>'},
\ ]
let g:context_filetype#filetypes.html =
\ [
\    {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\    {'filetype' : 'css', 'start' : '<style>', 'end' : '</style>'},
\ ]

" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customize fzf colors to match color scheme
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment']
\}

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <C-p> :Files<CR>

if executable('rg')
  command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)
  " bind mm to search word under cursor
  nnoremap mm :Rg <C-R><C-W><CR>
  vnoremap mm y :Rg <C-R>"<CR>

  nnoremap MM :Rg! <C-R><C-W><CR>
  vnoremap MM y :Rg! <C-R>"<CR>
endif

" Defx
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> l
  \ defx#is_directory() ?
  \ defx#do_action('open') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

autocmd FileType defx call s:defx_my_settings()

" lightline.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GetHunks()
  let hunks = GitGutterGetHunkSummary()
  let string = ''
  if !empty(hunks)
    let string .= printf('+%s ', hunks[0])
    let string .= printf('~%s ', hunks[1])
    let string .= printf('-%s', hunks[2])
  endif
  return string
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? '[+]' : ''
  return filename . modified
endfunction

let g:lightline = {
\ 'colorscheme': 'jellybeans',
\ 'enable': { 'tabline': 0 },
\ 'active': {
\   'left': [
\     [ 'mode', 'paste' ],
\     [ 'githunks', 'gitbranch', 'readonly' ],
\     [ 'filename', 'charvaluehex' ],
\   ],
\   'right': [
\     [ 'lineinfo' ],
\     [ 'line' ],
\     [ 'fileformat', 'fileencoding', 'filetype', ]
\   ]
\ },
\ 'component': {
\   'charvaluehex': '0x%B',
\ },
\ 'component_function': {
\   'filename': 'LightlineFilename',
\   'githunks': 'GetHunks',
\   'gitbranch': 'fugitive#head',
\   'line': 'LineNoIndicator',
\ },
\}

" zepl.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup zepl
  autocmd!
  autocmd FileType python     let b:repl_config = { 'cmd': 'ptpython' }
  autocmd FileType javascript let b:repl_config = { 'cmd': 'node' }
  autocmd FileType clojure    let b:repl_config = { 'cmd': 'clj' }
  autocmd FileType elixir     let b:repl_config = { 'cmd': 'iex -S mix' }
  autocmd FileType haskell    let b:repl_config = { 'cmd': 'ghci' }
augroup END

" EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Other
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimroot_enable = 1
let g:rainbow_active = 1
let g:vim_json_syntax_conceal = 0
let g:Illuminate_delay = 0
let g:gitgutter_eager = 0

let g:rainbow_conf = {
\  'separately': {
\    '*': {},
\    'html': 0,
\    'markdown': {'parentheses_options': 'containedin=markdownCode contained'},
\  }
\}

func! Multiple_cursors_before()
  if deoplete#is_enabled()
    call deoplete#disable()
    let g:deoplete_is_enable_before_multi_cursors = 1
  else
    let g:deoplete_is_enable_before_multi_cursors = 0
  endif
endfunc
func! Multiple_cursors_after()
  if g:deoplete_is_enable_before_multi_cursors
    call deoplete#enable()
  endif
endfunc

" Term handling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set login shell for :terminal command so aliases work
set shell=/opt/homebrew/bin/zsh

" When term starts, auto go into insert mode
autocmd TermOpen * startinsert

" Turn off line numbers etc
autocmd TermOpen * setlocal listchars= nonumber norelativenumber

" Creates a floating window with a most recent buffer to be used
function! CreateCenteredFloatingWindow()
  let width = float2nr(&columns * 0.6)
  let height = float2nr(&lines * 0.6)
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

function! OpenTerm(cmd)
  call CreateCenteredFloatingWindow()
  call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
endfunction

let s:scratch_open = 0
function! ToggleScratchTerm()
  if s:scratch_open
    bd!
    let s:scratch_open = 0
  else
    call OpenTerm('zsh')
    let s:scratch_open = 1
  endif
endfunction

let s:lazygit_open = 0
function! ToggleLazyGit()
  if s:lazygit_open
    bd!
    let s:lazygit_open = 0
  else
    call OpenTerm('lazygit')
    let s:lazygit_open = 1
  endif
endfunction

function! OnTermExit(job_id, code, event) dict
  if a:code == 0
    bd!
  endif
endfunction

command! LazyGit :call ToggleLazyGit()
command! OpenTerm :call ToggleScratchTerm()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Create directory if does not exist
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))

  autocmd FileType go             setlocal sw=4 ts=4 noexpandtab
  autocmd FileType python         setlocal sw=4 ts=4 et
  autocmd FileType ruby           setlocal sw=2 ts=2 et
  autocmd FileType json           setlocal sw=2 ts=2 et
  autocmd FileType haskell        setlocal sw=2 ts=2 et
  autocmd FileType yaml           setlocal sw=2 ts=2 et
  autocmd FileType javascript     setlocal sw=2 ts=2 et
  autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2 et

  " File types
  autocmd BufNewFile,BufRead *.icc               set filetype=cpp
  autocmd BufNewFile,BufRead *.pde               set filetype=java
  autocmd BufNewFile,BufRead *.coffee-processing set filetype=coffee
  autocmd BufNewFile,BufRead Dockerfile*         set filetype=dockerfile

  autocmd FileType crontab setlocal bkc=yes

  " Auto save session as '__previous__' so we can go back
  autocmd VimLeave * if !empty(expand('%')) | SSave! __previous__ | endif
  " Remove all swap files on exit, if no nvims are open
  autocmd VimLeave * call ClearSwap()

  " Spelling for markdown
  autocmd FileType * set nospell
  autocmd FileType markdown syntax spell toplevel | set spell spelllang=en_au
  autocmd FileType rst syntax spell toplevel | set spell spelllang=en_au

  " No indent lines for fzf please
  autocmd FileType fzf :IndentLinesDisable

  " Fugitive
  autocmd FileType gitcommit setlocal completefunc=emoji#complete
  autocmd FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Unset paste on InsertLeave
  autocmd InsertLeave * silent! set nopaste

  " Overwrite quickfix CR to close after selected
  autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
  " Esc to close quickfix
  autocmd FileType qf nnoremap <buffer> <ESC> :cclose<CR>

  " close quickfix if only window
  autocmd WinEnter * if (winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix") | q | endif
  autocmd BufEnter * if (winnr("$") == 1 && getbufvar(winbufnr(winnr()), "&filetype")== "defx") | q | endif

  " If in particular window, just tab to main
  autocmd FileType defx noremap <buffer> <Tab> <c-w>l

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOUR {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:PaperColor_Theme_Options = {
\  'theme': {
\    'default': {
\      'transparent_background': 1
\    }
\  }
\}

" colourscheme
set background=dark
colorscheme gruvbox

" Use terminal background
highlight Normal ctermbg=none
highlight NormalFloat ctermbg=none guibg=none
highlight NonText ctermbg=none ctermfg=8 guifg=gray

" vem-tabline
highlight TabLine                    cterm=none ctermfg=255 ctermbg=240 guifg=#242424 guibg=#cdcdcd gui=none
highlight TabLineSel                 cterm=bold ctermfg=235 ctermbg=255 guifg=#242424 guibg=#ffffff gui=bold
highlight TabLineFill                cterm=none ctermfg=255 ctermbg=240 guifg=#e6e3d8 guibg=#404040 gui=italic
highlight VemTablineNormal           cterm=none ctermfg=246 ctermbg=0   guifg=#262626 guibg=#000000 gui=none
highlight VemTablineLocation         cterm=none ctermfg=255 ctermbg=240 guifg=#666666 guibg=#cdcdcd gui=none
highlight VemTablineSelected         cterm=bold ctermfg=255 ctermbg=0   guifg=#242424 guibg=#ffffff gui=bold
highlight VemTablineLocationSelected cterm=bold ctermfg=235 ctermbg=255 guifg=#666666 guibg=#ffffff gui=bold
highlight VemTablineShown            cterm=none ctermfg=255 ctermbg=240 guifg=#242424 guibg=#cdcdcd gui=none
highlight VemTablineLocationShown    cterm=none ctermfg=255 ctermbg=240 guifg=#666666 guibg=#cdcdcd gui=none
highlight VemTablineSeparator        cterm=none ctermfg=246 ctermbg=240 guifg=#e6e3d8 guibg=#404040 gui=italic
highlight VemTablineTabNormal        cterm=none ctermfg=246 ctermbg=0   guifg=#262626 guibg=#000000 gui=none
highlight VemTablineTabSelected      cterm=bold ctermfg=255 ctermbg=0   guifg=#242424 guibg=#ffffff gui=bold

" vim: set ts=2 sw=2 tw=78 fdm=marker et :

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
let g:python3_host_prog="/usr/local/bin/python3"
let g:python_host_prog="/usr/local/bin/python"


" Install vim plug if not already
if glob("~/.config/nvim/autoload/plug.vim") ==# ""
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/dotfiles/nvimrc
endif

" Add plugins here
call plug#begin('~/.config/nvim/plugged')

" My plugins
Plug 'beanpuppy/vimroot'

" tools
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

" syntax
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'gabrielelana/vim-markdown'
Plug 'evanleck/vim-svelte'
Plug 'elixir-editors/vim-elixir'
Plug 'lervag/vimtex'
Plug 'cakebaker/scss-syntax.vim'

" editing
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/YankRing.vim'

" display
Plug 'itchyny/lightline.vim'
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
set conceallevel=1
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Fugitive
nnoremap <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>
nnoremap <Leader>b :Gblame<CR>

" qq to record, leader-q to replay
nnoremap <Leader>q @q

" YankRing show
nnoremap <silent>yr :YRShow<CR>

" Helper to replace words under cursor
nnoremap <Leader>r :%s/\<<C-R><C-W>\>//<Left>
nnoremap <Leader>R :%s/\<<C-R><C-W>\>//c<Left><Left>
xnoremap <Leader>r y :%s/\<<C-R>"\>//<Left>
xnoremap <Leader>R y :%s/\<<C-R>"\>//c<Left><Left>

" Nearby find and replace
nnoremap <silent> <Leader>c :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> <Leader>c "sy:let @/=@s<CR>cgn
xnoremap <CR> <Esc>.
nnoremap <CR> gnzz
nnoremap ! ungnzz

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Startify config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_session_dir ='~/.vim/session' " share sessions with normal vim

let g:startify_list_order = [
\ ['   My sessions:'],
\ 'sessions',
\ ['   My most recently used files in the current directory:'],
\ 'dir',
\ ['   My most recently used files'],
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

" Indent lines
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_enabled = 1 " enabled by default
let g:indentLine_conceallevel=1
let g:indentLine_char = "┆" " requires utf-8 in file/terminal
let g:indentLine_concealcursor=""

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

" YankRing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'

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
\     [ 'linterstatus' ],
\     [ 'lineinfo' ],
\     [ 'percent' ],
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
\   'linterstatus': 'LinterStatus',
\ },
\}

" Other
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimroot_enable = 1
let g:rainbow_active = 1
let g:vim_json_syntax_conceal = 0
let g:Illuminate_delay = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType python setlocal sw=4 ts=4 et
  autocmd FileType ruby setlocal sw=2 ts=2 et
  autocmd FileType json setlocal sw=2 ts=2 et
  autocmd FileType yaml setlocal sw=2 ts=2 et
  autocmd FileType javascript setlocal sw=2 ts=2 et
  autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2 et

  " File types
  autocmd BufNewFile,BufRead *.icc set filetype=cpp
  autocmd BufNewFile,BufRead *.pde set filetype=java
  autocmd BufNewFile,BufRead *.coffee-processing set filetype=coffee
  autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile

  autocmd FileType crontab setlocal bkc=yes

  " Auto save session as '__previous__' so we can go back
  autocmd VimLeave * if !empty(expand('%')) | SSave! __previous__ | endif
  " Remove all swap files on exit, if no nvims are open
  autocmd VimLeave * call ClearSwap()

  " Spelling for markdown
  autocmd FileType * set nospell
  autocmd FileType markdown syntax spell toplevel | set spell spelllang=en_au

  " No indent lines for fzf please
  autocmd FileType fzf :IndentLinesDisable

  " Fugitive
  autocmd FileType gitcommit setlocal completefunc=emoji#complete
  autocmd FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  " Unset paste on InsertLeave
  autocmd InsertLeave * silent! set nopaste

  autocmd TextChanged,InsertLeave * silent! GitGutter

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
let g:PaperColor_Theme_Options = {
\  'theme': {
\    'default': {
\      'transparent_background': 1
\    }
\  }
\}

" colourscheme
set background=dark
colorscheme hybrid_material

" Use terminal background
hi Normal ctermbg=none
highlight NonText ctermbg=none

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

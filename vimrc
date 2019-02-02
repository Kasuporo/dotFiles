""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{1
" minimal, lightweight, distractions free, pure editing vimrc
" mainly for writing plaintext/markdown/rst files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We need these folders to exist
call system('mkdir -p ~/.vim/session/' )   " session files
call system('mkdir -p ~/.vim/backup/' )    " backups folder
call system('mkdir -p ~/.vim/undo/' )      " undo folder
call system('mkdir -p ~/.vim/swap/' )      " swap files
call system('mkdir -p ~/.vim/autoload/' )  " autoload folder

" Install vim plug if not already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $DOTFILES/vimrc
endif

" Add plugins here
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sleuth'
Plug 'scrooloose/syntastic'
Plug 'lervag/vimtex'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/limelight.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'joshdick/onedark.vim'
Plug 'pbrisbin/vim-colors-off'

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
set updatetime=250
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
set cmdheight=1
set switchbuf=useopen
set hidden
" make split char a solid line
set fillchars+=vert:\│
" set backups/undos
set backup
set undofile
set backupdir=$HOME/.vim/backup/
set directory=$HOME/.vim/swap/
set undodir=$HOME/.vim/undo/
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
" set conceal
set conceallevel=1
" set modelines
set modeline
set modelines=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif

augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab traverse
nnoremap <silent>tt :tabnew<CR>
nnoremap == gt
nnoremap -- gT

" window traverse
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" buffer traverse
nnoremap <Tab>j :bnext<CR>
nnoremap <Tab>k :bprevious<CR>
" close current buffer and move to previous one
nnoremap <leader>bq :bp <BAR> bd #<CR>

" move 'correctly' on wrapped lines
nnoremap j gj
nnoremap k gk

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k


" Enable folding/unfold with the spacebar
nnoremap <space> za
nnoremap <leader><space> zR

" no highlight
nnoremap // :noh<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change colorscheme
command! Mono :colorscheme off | hi Normal ctermbg=none
command! Colour :colorscheme onedark | hi Normal ctermbg=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim: How it should be {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <PageUp> <nop>
nnoremap <PageDown> <nop>

inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <PageUp> <nop>
inoremap <PageDown> <nop>

vnoremap <Left> <nop>
vnoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <PageUp> <nop>
vnoremap <PageDown> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Rename current file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
nnoremap <leader>rn :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER PLUGINS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Startify config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_session_dir ='~/.vim/session'

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
\ ]

let g:startify_bookmarks = [
  \ { 'v': '~/dotfiles/vimrc' },
  \ { 'n': '~/dotfiles/nvimrc' },
  \ { 'z': '~/dotfiles/zshrc' },
  \ { 'h': '~/dotfiles/hyper.js' },
\ ]

" Limelight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

let g:limelight_default_coefficient = 0.9

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 5

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:goyo_enter()
  Limelight

  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  hi Normal ctermbg=none
  Limelight!

  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width = "70%"
let g:goyo_height = "80%"

" Auto enter goyo
autocmd VimEnter * Goyo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOUR {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colourscheme
colorscheme off

" Use terminal background
hi Normal ctermbg=none
highlight NonText ctermbg=none

" vim: set ts=4 sw=2 tw=78 fdm=marker et :

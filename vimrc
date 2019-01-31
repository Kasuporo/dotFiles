set nocompatible    " required
filetype off        " required

" set the runtime path to include Vundle and initalize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path')

" let Vundle manage vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here

" tools
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-fugitive'
Plugin 'mbbill/undotree'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-startify'
" Plugin 'ludovicchabant/vim-gutentags'
Plugin 'metakirby5/codi.vim'

" editing
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
Plugin 'thirtythreeforty/lessspace.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'vimwiki/vimwiki'
Plugin 'davidhalter/jedi-vim'
Plugin 'godlygeek/tabular'
Plugin 'rust-lang/rust.vim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
" snip stuff
Plugin 'Shougo/deoplete.nvim'
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

" display
Plugin 'joshdick/onedark.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'lervag/vimtex'
Plugin 'Yggdroot/indentline'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" remove all existing autocmds
autocmd!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

" Use deoplete.
let g:deoplete#enable_at_startup = 1

syntax on
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
" make searches case-sensitve if they contain upper-case chars
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set hidden
" make split char a solid line
set fillchars+=vert:\│
" dont make backups
set nobackup
set nowritebackup
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " tpope/vim-sleuth autodetects file indents, so i dont think i need this
  autocmd FileType python set sw=4 ts=4 et
  " autocmd FileType ruby set sw=2 ts=2 et
  " autocmd FileType javascript set sw=2 ts=2 et

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOUR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colourscheme
color onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" Use terminal background
hi Normal ctermbg=none
highlight NonText ctermbg=none

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab traverse
nnoremap == gt
nnoremap -- gT

nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>
" nerd tree + tagbar
nnoremap <leader><Tab> :NERDTreeToggle<CR>:TagbarToggle<CR>

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
" bufexplorer
nnoremap <silent> <Leader>bl :BufExplorerVerticalSplit<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" move 'correctly' on wrapped lines
nnoremap j gj
nnoremap k gk

" fix common typos
if !exists(':W')
    command W w
    command Q q
endif

" save files as sudo
cnoremap w!! w !sudo tee > /dev/null %

" quick quit all
cnoremap qq qall

" edit .vimrc
nnoremap <Leader>rc :e $HOME/.vimrc<CR>

" load current file in firefox
nnoremap <Leader>ff :!firefox %<CR>

" run py script
noremap <Leader>py :!python %<CR>

" show weather report
nnoremap <silent> <Leader>we :! curl -s wttr.in/Sydney \| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"<CR>

" open terminal
nnoremap <Leader>ht :terminal<CR>
nnoremap <Leader>vt :vertical terminal<CR>
" close terminal
tnoremap <esc> <C-\><C-n>:q!<CR>
" make sure no other keys break when terminal closed with esc
set notimeout ttimeout timeoutlen=100

" undotree
set undofile
nnoremap <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>

" Enable folding with the spacebar
nnoremap <space> za

" ctags
nnoremap <leader>. :CtrlPTag<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STARTIFY CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_reuse_window  = 'startify' " Alow ctrlp to use startify window
let g:startify_session_dir='~/.vim/session'

let g:startify_list_order=[
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

" Close Cleanup
let g:startify_session_before_save = [
  \ 'echo "Cleaning up before saving.."',
  \ 'silent! NERDTreeClose',
  \ 'silent! TagbarClose',
\ ]

let g:startify_bookmarks = [
  \ { 'v': '~/dotfiles/vimrc' },
  \ { 'z': '~/dotfiles/zshrc' },
\ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
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
" SHORTCUT TO REFERENCE CURRENT FILE'S PATH IN COMMAND LINE MODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Pyrun execute "!python %"
command! PyrunI execute "!python -i %"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neosnippet#snippets_directory='~/dotfiles/neosnippet'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = '(~˘▾˘)~'

" limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Indent Lines
let g:indentLine_enabled = 1 " enabled by default
let g:indentLine_conceallevel=1
let g:indentLine_char = "┆"

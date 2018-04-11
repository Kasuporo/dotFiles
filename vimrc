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
" editing
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'chaoren/vim-wordmotion'
Plugin 'tpope/vim-surround'
Plugin 'thirtythreeforty/lessspace.vim'
" display
Plugin 'joshdick/onedark.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'lervag/vimtex'
Plugin 'Yggdroot/indentline'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" remove all existing autocmds
autocmd!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" enable file type detection
filetype plugin indent on
" make tab completion for files/buffers act like bash
set wildmode=longest,list
" folding
set fdm=indent
set foldlevel=99
" keep 5 lines below and above the cursor
set scrolloff=5
" if a file is changed outside vim reload it without asking
set autoread

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

  " python
  autocmd FileType python set sw=4 sts=4 et

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " javascript
  autocmd! FileType javascript set sw=2 sts=2 expandtab autoindent smartindent nocindent
augroup END

"""""""""""""""""""""""""""""""""
" COLOUR
"""""""""""""""""""""""""""""""""
" colourscheme
color onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" Use terminal background
hi Normal ctermbg=none
highlight NonText ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab traverse
nnoremap <C-h> gT
nnoremap <C-l> gt
" move 'correctly' on wrapped lines
nnoremap j gj
nnoremap k gk
" fix common typos
if !exists(':W')
    command W w
    command Q q
endif
" map vim-wordmotion prefix to comma, remap comma
nnoremap ,, ,
let g:wordmotion_prefix = ','
" save files as sudo
cnoremap w!! w !sudo tee > /dev/null %
" edit .vimrc
nnoremap <Leader>rc :tabe $HOME/.vimrc<CR>
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
" bufexplorer
nnoremap <silent> <Leader>b :BufExplorer<CR>
let g:bufExplorerDisableDefaultKeyMapping=1
" undotree
set undofile
nnoremap <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>
" Enable folding with the spacebar
nnoremap <space> za

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
nnoremap <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT TO REFERENCE CURRENT FILE'S PATH IN COMMAND LINE MODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" start NERDTree if no file is specified
nnoremap <Leader>nt :NERDTreeToggle<CR>
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd w | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = '(~˘▾˘)~'
" Indent Lines
let g:indentLine_enabled = 1 " enabled by default
let g:indentLine_char = "|"
set conceallevel=1
let g:indentLine_conceallevel=1

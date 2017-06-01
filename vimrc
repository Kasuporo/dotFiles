runtime! archlinux.vim

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
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'mbbill/undotree'
Plugin 'tmhedberg/SimplyFold'
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

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

syntax on
set updatetime=250 " faster gitgutter
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent " 4 space tabs
autocmd FileType html setlocal shiftwidth=2 tabstop=2 " HTML
autocmd FileType c setlocal cindent tabstop=8 noexpandtab shiftwidth=8 " C
set nu " lines
set mouse=a " enable mouse support in terminal
set history=1000 " loadsa history
set hidden " switch buffers without saving
set fillchars+=vert:\│ " make split char a solid line
set backupcopy=yes " copy the file and overwrite the original
set encoding=utf-8

set noswapfile
" save swap, backup, etc to ~/.vim instead
for folder in ['backup', 'swap', 'undo']
    if !isdirectory($HOME.'/.vim/'.folder)
        call mkdir($HOME.'/.vim/'.folder, 'p')
    endif
endfor
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

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
nnoremap <Leader>rc :e $HOME/.vimrc<CR>

" load current file in firefox
nnoremap <Leader>ff :!firefox %<CR>

" lol
nnoremap <F5> :e %<CR>

" reactify XML (eg react-native-svg)
nnoremap <Leader>rf :%s/\(<\/\?\)\(.\)/\1\U\2/g<CR>

" hex helpers
nnoremap <Leader>hd :%! xxd<CR>
nnoremap <Leader>hf :%! xxd -r<CR>

" show weather report
nnoremap <silent> <Leader>we :! curl -s wttr.in/Manchester \| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"<CR>

" bufexplorer
nnoremap <silent> <Leader>b :BufExplorer<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" undotree
set undofile
nnoremap <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>

" YouCompleteMe
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
nnoremap <Leader>g :YcmCompleter GoTo<CR>

" start NERDTree if no file is specified
nnoremap <Leader>nt :NERDTreeToggle<CR>
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd w | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = '(~˘▾˘)~'

" set clipboard to system
set clipboard=unnamedplus

" colourscheme
color onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Enable folding with the spacebar
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

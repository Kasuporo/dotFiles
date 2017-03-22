" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
" let skip_defaults_vim=1

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimplyFold'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Zenburn color config
let g:zenburn_high_Contrast=1
let g:zenburn_force_dark_background=1
" let g:zenburn_transparent=1

set noswapfile
syntax on
set encoding=utf8
let python_highlight_all=1
set nu
set clipboard=unnamed
colors zenburn
set t_Co=256

" NERDTree config
map n :NERDTreeMirrorToggle<ENTER> 
" let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc$', '\~$'] " Ignore files in nerdtree

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

set splitbelow
set splitright

" Enable folding with the spacebar
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


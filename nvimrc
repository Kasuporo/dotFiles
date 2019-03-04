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

" Figure out the system python for neovim - we assume that the neovim python
" server has been installed globally.
let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
let g:python_host_prog=substitute(system("which -a python2 | head -n2 | tail -n1"), "\n", '', 'g')

" Install vim plug if not already
if glob("~/.config/nvim/autoload/plug.vim") ==# ""
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/dotfiles/nvimrc
endif

" Add plugins here
call plug#begin('~/.config/nvim/plugged')

" tools
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'metakirby5/codi.vim'
Plug 'moll/vim-node'
Plug 'w0rp/ale'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'craigemery/vim-autotag'

" editing
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'tomtom/tcomment_vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'rust-lang/rust.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/YankRing.vim'
" code completion
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" display
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'Yggdroot/indentline'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'pacha/vem-tabline'
Plug 'junegunn/limelight.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'TaDaa/vimade'
Plug 'ryanoasis/vim-devicons'
Plug 'RRethy/vim-illuminate'
" themes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'pbrisbin/vim-colors-off'
" ?
Plug 'junegunn/vim-emoji'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab traverse
nnoremap <silent>== gt
nnoremap <silent>-- gT

nnoremap <silent>tt :NERDTreeToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>
" nerd tree + tagbar
nnoremap <Tab><Tab> :NERDTreeToggle<CR>:TagbarToggle<CR>

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
nnoremap <Tab>j :bnext<CR>
nnoremap <Tab>k :bprevious<CR>
" close current buffer and move to previous one
nnoremap <Tab>q :bp <BAR> bd #<CR>

" bufexplorer
nnoremap <silent> <Leader>bl :BufExplorerVerticalSplit<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" vem-tabline
noremap <Tab>h <Plug>vem_move_buffer_left-
noremap <Tab>l <Plug>vem_move_buffer_right-

" move 'correctly' on wrapped lines
nnoremap j gj
nnoremap k gk

" save files as sudo
cnoremap w!! w !sudo tee > /dev/null %

" quick quit all
cnoremap qq qall

" load current file in firefox
nnoremap <Leader>ff :!firefox %<CR>

" undotree
nnoremap <silent> U :UndotreeToggle <BAR> :UndotreeFocus<CR>

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

" easyalign
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" Fzf
nnoremap <leader>f :FZF<CR>
" Also use ctrl-p because I am wayyyyy too used to it.
nnoremap <C-p> :FZF<CR>

" Fugitive
nnoremap <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

" show weather report
nnoremap <silent> <Leader>we :! curl -s wttr.in/Sydney \| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"<CR>

" qq to record, Q to replay
nnoremap Q @q

" The Silver Searcher, if available
"  1. bind to :grep syntax
"  2. create new :Ag syntax
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat^=%f:%l:%c:%m   " file:line:column:message
endif

" Create Ag command
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" bind mm to grep word under cursor - useful even if Ag not installed
nnoremap mm :silent! grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" find todos and fixmes
nnoremap <leader>t :Ag '(FIXME)\\\|(TODO)'<cr>

" Helper to replace words under cursor
nnoremap <Leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>

" YankRing show
nnoremap <silent>yr :YRShow<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Trim :%s/\s*$//g | nohlsearch | exe "normal! g'\""

" Change colorscheme
command! Mono :colorscheme off | hi Normal ctermbg=none

" chmod +x
command! EX
  \  if !empty(expand('%'))
  \|   write
  \|   call system('chmod +x '.expand('%'))
  \|   silent e
  \| else
  \|   echohl WarningMsg
  \|   echo 'Save the file first'
  \|   echohl None
  \| endif

" edit nvimrc
command! EditRC :e ~/dotfiles/nvimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Append modeline after last line in buffer.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
    \ &tabstop, &shiftwidth, &textwidth, &foldmethod, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Change directory to the root of the Git repository
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

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

" <F5> / <F6> | Run script
" ----------------------------------------------------------------------------
function! s:run_this_script(output)
  let head   = getline(1)
  let pos    = stridx(head, '#!')
  let file   = expand('%:p')
  let ofile  = tempname()
  let rdr    = " 2>&1 | tee ".ofile
  let win    = winnr()
  let prefix = a:output ? 'silent !' : '!'
  " Shebang found
  if pos != -1
    execute prefix.strpart(head, pos + 2).' '.file.rdr
  " Shebang not found but executable
  elseif executable(file)
    execute prefix.file.rdr
  elseif &filetype == 'ruby'
    execute prefix.'/usr/bin/env ruby '.file.rdr
  elseif &filetype == 'tex'
    execute prefix.'latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r').rdr
  elseif &filetype == 'dot'
    let svg = expand('%:r') . '.svg'
    let png = expand('%:r') . '.png'
    " librsvg >> imagemagick + ghostscript
    execute 'silent !dot -Tsvg '.file.' -o '.svg.' && '
          \ 'rsvg-convert -z 2 '.svg.' > '.png.' && open '.png.rdr
  else
    return
  end
  redraw!
  if !a:output | return | endif

  " Scratch buffer
  if exists('s:vim_exec_buf') && bufexists(s:vim_exec_buf)
    execute bufwinnr(s:vim_exec_buf).'wincmd w'
    %d
  else
    silent!  bdelete [vim-exec-output]
    silent!  vertical botright split new
    silent!  file [vim-exec-output]
    setlocal buftype=nofile bufhidden=wipe noswapfile
    let      s:vim_exec_buf = winnr()
  endif
  execute 'silent! read' ofile
  normal! gg"_dd
  execute win.'wincmd w'
endfunction
nnoremap <silent> <F5> :call <SID>run_this_script(0)<cr>
nnoremap <silent> <F6> :call <SID>run_this_script(1)<cr>

" Syntax highlighting in code snippets
" ----------------------------------------------------------------------------
function! s:syntax_include(lang, b, e, inclusive)
  let syns = split(globpath(&rtp, "syntax/".a:lang.".vim"), "\n")
  if empty(syns)
    return
  endif

  if exists('b:current_syntax')
    let csyn = b:current_syntax
    unlet b:current_syntax
  endif

  let z = "'" " Default
  for nr in range(char2nr('a'), char2nr('z'))
    let char = nr2char(nr)
    if a:b !~ char && a:e !~ char
      let z = char
      break
    endif
  endfor

  silent! exec printf("syntax include @%s %s", a:lang, syns[0])
  if a:inclusive
    exec printf('syntax region %sSnip start=%s\(%s\)\@=%s ' .
                \ 'end=%s\(%s\)\@<=\(\)%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  else
    exec printf('syntax region %sSnip matchgroup=Snip start=%s%s%s ' .
                \ 'end=%s%s%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  endif

  if exists('csyn')
    let b:current_syntax = csyn
  endif
endfunction

function! s:file_type_handler()
  if &ft =~ 'jinja' && &ft != 'jinja'
    call s:syntax_include('jinja', '{{', '}}', 1)
    call s:syntax_include('jinja', '{%', '%}', 1)
  elseif &ft =~ 'mkd\|markdown'
    for lang in ['ruby', 'yaml', 'vim', 'sh', 'bash:sh', 'python', 'java', 'c',
          \ 'clojure', 'clj:clojure', 'scala', 'sql', 'gnuplot']
      call s:syntax_include(split(lang, ':')[-1], '```'.split(lang, ':')[0], '```', 0)
    endfor

    highlight def link Snip Folded
    setlocal textwidth=78
    setlocal completefunc=emoji#complete
  elseif &ft == 'sh'
    call s:syntax_include('ruby', '#!ruby', '/\%$', 1)
  endif
endfunction

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
\ ]

" Close Cleanup
let g:startify_session_before_save = [
  \ 'echo "Cleaning up before saving.."',
  \ 'silent! NERDTreeClose',
  \ 'silent! TagbarClose',
\ ]

let g:startify_bookmarks = [
  \ { 'v': '~/dotfiles/vimrc' },
  \ { 'n': '~/dotfiles/nvimrc' },
  \ { 'z': '~/dotfiles/zshrc' },
  \ { 'h': '~/dotfiles/hyper.js' },
\ ]

" Deoplete/Neosnippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neosnippet#snippets_directory = '~/dotfiles/neosnippet'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 3
let g:neosnippet#enable_snipmate_compatibility = 1
let g:jedi#show_call_signatures = "2"

inoremap <expr><C-n>  deoplete#mappings#manual_complete()

augroup startup_deoplete
  autocmd!
  autocmd FileType markdown
    \ call deoplete#custom#buffer_option('auto_complete', v:false)
augroup END

imap <expr><TAB>
 \ pumvisible() ? "\<CR>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Expands or completes the selected snippet/item in the popup menu
imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
  \ "\<Plug>(neosnippet_jump_or_expand)" : "\<CR>"

smap <silent><CR> <Plug>(neosnippet_jump_or_expand

" Nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = '(~˘▾˘)~'

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
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  hi Normal ctermbg=none
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

" Indent lines
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_enabled = 1 " enabled by default
let g:indentLine_conceallevel=1
let g:indentLine_char = "┆" " requires utf-8 in file/terminal

" Ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:airline#extensions#ale#enabled = 1 " enable with airline

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'

let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'python': ['flake8'],
\ 'sh': ['shellcheck'],
\}

let g:ale_python_flake8_options = '--ignore=E201,E202,E221,E241,E303,E501,E701'

" YankRing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'

" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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
  \ 'header':  ['fg', 'Comment'] }

" vim-illuminate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
  autocmd FileType javascript setlocal sw=2 ts=2 et
  autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2

  " File types
  au BufNewFile,BufRead *.icc set filetype=cpp
  au BufNewFile,BufRead *.pde set filetype=java
  au BufNewFile,BufRead *.coffee-processing set filetype=coffee
  au BufNewFile,BufRead Dockerfile* set filetype=dockerfile

  " Included syntax
  au FileType,ColorScheme * call <SID>file_type_handler()

  " Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " If in particular window, just tab to main
  autocmd FileType nerdtree noremap <buffer> <Tab> <c-w>l
  autocmd FileType tagbar noremap <buffer> <Tab> <c-w>h

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOUR {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colourscheme
set background=dark
colorscheme hybrid_material

" Use terminal background
hi Normal ctermbg=none
highlight NonText ctermbg=none

" airline
let g:airline_theme='monochrome'
let g:airline_powerline_fonts=0

" vim: set ts=4 sw=2 tw=78 fdm=marker et :

call plug#begin('~/.vim/plugged')

" File and symbols navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

" Autocompletion and snippets
" Plug 'Valloric/YouCompleteMe'
" supertab has configuration problems on Vim 8
" See https://github.com/ervandew/supertab/issues/185
" Plug 'ervandew/supertab'
" Plug 'SirVer/ultisnips'

" Navigation and manipulation
Plug 'gcmt/breeze.vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax
Plug 'cakebaker/scss-syntax.vim'

" Themes
Plug 'ajh17/Spacegray.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Windows
Plug 'vim-scripts/ZoomWin'

call plug#end()

" Make Vim more useful
set nocompatible

filetype plugin indent on

""""""""
" Insert
""""""""

" Configure completion popups
set completeopt=menuone,longest

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Make indentation smarter
set autoindent
set smartindent
set cindent

" Expand tabs to spaces
set expandtab

" Make tabs as wide as four spaces
set tabstop=4
set shiftwidth=4
set shiftround

"""""""""
" Visuals
"""""""""

" Enable syntax highlighting
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Color scheme
colorscheme spacegray
let g:spacegray_underline_search = 1

" Airline theme
let g:airline_theme='badwolf'

" Disable error bells
set noerrorbells

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atIO

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Highlight current line
set cursorline

" Show the (partial) command as it’s being typed
set showcmd

" Enable line numbers
set number

" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Show matching bracket briefly
set showmatch

" Enhance command-line completion
set wildmenu

" Show invisible characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

""""""""
" Search
""""""""

" Add the g flag to search/replace by default
set gdefault

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Don’t reset cursor to start of line when moving around.
set nostartofline

"""""""""""""""""""""""
" Plugin confiuguration
"""""""""""""""""""""""

" Use tree-style listing in netrw
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\.git,\.DS_Store'

" CtrlP
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_max_files = 0

" Ultisnip
" NOTE: <f1> otherwise it overrides <tab> forever
let g:UltiSnipsExpandTrigger="<f1>"
let g:UltiSnipsJumpForwardTrigger="<f1>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:did_UltiSnips_vim_after = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}

"""""""""""""""""""
" Keyboard mappings
"""""""""""""""""""

" Change mapleader
let mapleader=","

" <leader>-. to find a tag
nnoremap <leader>. :CtrlPTag<cr>

" <leader>-k to toggle Tagbar
nnoremap <silent> <leader>k :TagbarToggle<cr>

" <leader-ss> to strip trailing whitespace
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" <leader>-W save a file as root
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" <C-L> to clear the highlighting of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" <C-c> to exit insert mode
inoremap <C-c> <Esc>

" Tabs navigation shortcuts
nnoremap <C-b>  :tabprevious<CR>
inoremap <C-b>  <Esc>:tabprevious<CR>i
nnoremap <C-n>  :tabnext<CR>
inoremap <C-n>  <Esc>:tabnext<CR>i
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap <C-k>  :tabclose<CR>
inoremap <C-k>  <Esc>:tabclose<CR>i

" lazy ':'
map \ :

nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>

""""""""""""""""""""
" Automatic commands
""""""""""""""""""""

if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"""""""
" Other
"""""""

" Set a short timeout delay
" Helps with determining sequence of keys involving escape sequences
set ttimeout
set ttimeoutlen=50

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Optimize for fast terminal connections
set ttyfast

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Automatically reload files if changed outside of Vim and not changed in Vim
set autoread

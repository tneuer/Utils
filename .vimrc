"==========================================================
"=== PLUGINS ==============================================
"==========================================================
"
"===========================
"VUNDLE - vim Plugin manager
"===========================

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'       "vundle - vim plugin manager

Plugin 'scrooloose/nerdcommenter'   "sexy commenting

Plugin 'Yggdroot/indentLine' "indentation lines for loops :)

Plugin 'Valloric/YouCompleteMe' 

Plugin 'jiangMiao/auto-pairs'

Plugin 'notpratheek/Pychimp-vim'

Plugin 'scrooloose/nerdtree'

Plugin 'octol/vim-cpp-enhanced-highlight' "c++ highlighting
"Plugin 'vim-syntastic/syntastic'

"" All of your Plugins must be added before the following line

"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"" Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Install L9 and avoid a Naming conflict if you've already installed a
"" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ


"==================
" === NERDCOMMENTER
"==================

let mapleader = ","

"comment empty lines as well
let g:NERDCommentEmptyLines=0

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'


"===============
"=== INDENT LINE
"===============

let g:indentLine_char = '|'

"===============
"=== Shift lines via shift UP and shift DOWN
"===============

nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

"=================
" COLORS
"=================

" Set solarised color scheme
syntax enable
set t_Co=256
set background=dark
"set background=light
let g:solarized_termcolors=256
"let g:solarized_termtrans=1

" Set highlight colors for brackets/braces/parenthesis matching
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

set colorcolumn=90
highlight ColorColumn ctermbg=darkgray

"=================
" GUI
"=================

"Line Numbers
set number
set relativenumber

" line wrap and other stuff
set linebreak
set wrap
set nolist

" line wrap with indent kept
set breakindent  

" STATUS LINE
" First define new highlight groups
hi User1 ctermbg=none

" Status line configuration

set laststatus=2                "status line permanently on

set statusline=%*               "add personal highlighting
                                "specified in hi User1 ctermbg...
set statusline+=%m              "modified flag
set statusline+=%r              "read only flag
set statusline+=%F              " path
let emptyspace='    '
set statusline+=%{emptyspace}
set statusline+=@%{hostname()}
set statusline+=%y             "filetype
set statusline+=%=              "left/right separator
set statusline+=Col\ %c,\       "cursor column
set statusline+=Lin\ %l/%L  "cursor line/total lines
set statusline+=\ %P        "percent through file 
set showcmd                 "shows which command is active


"=================
" SEARCHING
"=================

" Ignoring case
set ignorecase

" Incremental searching
set incsearch

" Highlight things that we find with the search
set hlsearch

"=================
" VIM GENERAL
"=================

" Enable mouse support in console
set mouse=a

" enable copypasting between sessions
set clipboard=unnamedplus
set showmatch
set matchtime=3

set pastetoggle=<F10>

hi MatchParen cterm=none ctermbg=green ctermfg=blue

" make backspace work 'normally'
set backspace=indent,eol,start 

map <C-t> :NERDTreeToggle<CR>


"=================
" SYNTAX AND TABS
"=================

" Needed for Syntax Highlighting and stuff
"filetype on " doesn't work with vundle
filetype plugin on "needed for plugins: nerdcommenter
filetype indent on "needed by  plugin slim
set grepprg=grep\ -nH\ $*

set runtimepath+=~/.vim/bundle/YouCompleteMe
filetype on

" Who doesn't like autoindent?
set autoindent

" tab configs
set tabstop=2
set expandtab
set shiftwidth=4

" tab and backspace are smart
set smarttab                  

"=================
" Python utilities
"=================

let python_highlight_all=1
syntax on
augroup python
    autocmd!
    autocmd FileType python
                \   syn keyword pythonDecorator self
augroup end
let g:ycm_autoclose_preview_window_after_completion=1

" Create header for python files saved in ~/.pyHeader.template
au BufNewFile *.py 0r ~/.pyHeader.template
autocmd bufnewfile *.py exe "1," . 7 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.py exe "1," . 7 . "g/Creation Date :.*/s//Creation Date : " .strftime("%c")
autocmd Bufwritepre,filewritepre *.py execute "normal ma"
autocmd Bufwritepre,filewritepre *.py exe "1," . 7 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.py execute "normal `a"
au BufRead,BufNewFile *.py colorscheme pychimp


"=================
" C/C++ utlities
"=================

augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c,*.cpp set filetype=c.doxygen
    " Create header for python files saved in ~/.pyHeader.template
    au BufNewFile *.c,*.cpp 0r ~/.cppHeader.template
    autocmd bufnewfile *.c,*.cpp exe "1," . 7 . "g/File Name :.*/s//File Name : " .expand("%")
    autocmd bufnewfile *.c,*.cpp exe "1," . 7 . "g/Creation Date :.*/s//Creation Date : " .strftime("%c")
    autocmd Bufwritepre,filewritepre *.c,*.cpp execute "normal ma"
    autocmd Bufwritepre,filewritepre *.c,*.cpp exe "1," . 7 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
    autocmd bufwritepost,filewritepost *.c,*.cpp execute "normal `a"
augroup END

"=================



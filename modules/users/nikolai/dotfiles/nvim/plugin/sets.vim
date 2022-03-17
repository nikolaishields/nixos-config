filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on
syntax on                   " syntax highlighting

set autoindent              " indent a new line the same amount as the line just typed
set encoding=UTF-8
set cmdheight=1             " Give more space for displaying messages.
set colorcolumn=80
set cursorline              " highlight current cursorline
set expandtab
set guicursor=
set hidden
set hlsearch                " highlight search 
set ignorecase              " case insensitive 
set incsearch
set incsearch               " incremental search
set isfname+=@-@
set mouse=a                 " enable mouse click
set mouse=v                 " middle-click paste with 
set nobackup
set nocompatible            " disable compatibility to old-time vi
set noerrorbells
set noswapfile
set nowrap
set nu
set scrolloff=8
set shiftwidth=4
set shortmess+=c            " Don't pass messages to |ins-completion-menu|.
set showmatch               " show matching 
set signcolumn=yes
set smartindent
set tabstop=4 
set softtabstop=4
set termguicolors
set ttyfast                 " Speed up scrolling in Vim
set undodir=~/.vim/undodir
set undofile
set updatetime=50
set wildmode=longest,list   " get bash-like tab completions
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
"test

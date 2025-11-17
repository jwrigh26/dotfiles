" ============================
" Justin's Vim Setup
" ============================

" --- Escape Mapping ---
inoremap jk <Esc>
inoremap kj <Esc>

" --- Line Numbers ---
set number
set relativenumber

" --- Search Improvements ---
set ignorecase
set smartcase
set incsearch
set hlsearch

" --- Tabs & Indentation ---
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" --- Clipboard ---
" Use system clipboard for copy/paste
set clipboard=unnamedplus

" --- Mouse Support ---
set mouse=a

" --- Quality of Life ---
set nowrap
set cursorline
set showmatch
set wildmenu
set ruler
set termguicolors

" --- Undo Persistence ---
set undofile
set undodir=~/.vim/undo

" --- Better Backspace ---
set backspace=indent,eol,start

" --- Filetype Plugins ---
filetype plugin on
filetype indent on
syntax on


" --- Visual Theme (Arctic Darcula) ---
set background=dark

" You already have termguicolors above, but just in case:
if has('termguicolors')
  set termguicolors
endif

" Base UI
highlight Normal       guifg=#e5e9f0 guibg=#101119
highlight CursorLine   guibg=#1b1f2b
highlight LineNr       guifg=#4c566a guibg=#101119
highlight CursorLineNr guifg=#88c0d0 guibg=#101119
highlight StatusLine   guifg=#e5e9f0 guibg=#2e3440
highlight VertSplit    guifg=#2e3440 guibg=#101119

" Text & Structure
highlight Comment      guifg=#6b7089 gui=italic
highlight Constant     guifg=#8fbcbb
highlight String       guifg=#a3be8c
highlight Identifier   guifg=#88c0d0
highlight Function     guifg=#81a1c1
highlight Statement    guifg=#81a1c1 gui=bold
highlight Keyword      guifg=#81a1c1 gui=bold
highlight Type         guifg=#8fbcbb
highlight PreProc      guifg=#5e81ac
highlight Special      guifg=#5e81ac

" Selection / Search
highlight Visual       guibg=#2e3440
highlight Search       guifg=#000000 guibg=#ebcb8b
highlight IncSearch    guifg=#000000 guibg=#d08770
highlight MatchParen   guifg=#e5e9f0 guibg=#3b4252 gui=bold

" Popup / completion
highlight Pmenu        guifg=#e5e9f0 guibg=#2e3440
highlight PmenuSel     guifg=#000000 guibg=#88c0d0
highlight PmenuSbar    guibg=#3b4252
highlight PmenuThumb   guibg=#5e81ac





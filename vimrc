" ============================
" Justin's Vim Setup
" ============================

" -- Leader Key ---
let mapleader = " "

" --- Escape Mapping ---
inoremap jk <Esc>
inoremap kj <Esc>

" --- Where am I
set laststatus=2
set statusline=%f\ %m\ %r\ %y\ %=Ln:%l/%L\ Col:%c

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

"-- Soft Wrap
set nowrap
"set linebreak
"set breakindent
"set breakindentopt=shift:2
"set showbreak=↳\
set colorcolumn=80


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

" Slight twek to cursorline
highlight CursorLine guibg=#151821

" Arctic Dracula statusline colors
highlight StatusLine   guifg=#69aafc guibg=#0b1720
highlight StatusLineNC guifg=#9cb3cf guibg=#050b10

" ColorColumn
highlight ColorColumn guibg=#0b253a


" ============================
" Plugins
" ============================
call plug#begin('~/.vim/plugged')

" Fuzzy finder core + Vim integration
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

"Linting & formatting
Plug 'dense-analysis/ale'

call plug#end()

" ============================
" ALE (Linting / Formatting)
" ============================

" Use ESLint for JS/TS/React files
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'javascriptreact': ['eslint'],
\ 'typescript': ['eslint'],
\ 'typescriptreact': ['eslint'],
\ }

" Use Prettier (then ESLint --fix) as fixers
let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'javascriptreact': ['prettier', 'eslint'],
\ 'typescript': ['prettier', 'eslint'],
\ 'typescriptreact': ['prettier', 'eslint'],
\ }

" Automatically run fixers on save (optional)
let g:ale_fix_on_save = 0

" Show ALE messages in the status line (simple mode)
let g:ale_echo_cursor = 1

" Keep linting while you type, but not *too* aggressively
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1


" --- Fuzzy Finder Mappings ---
"  Fuzzy search files <Space>p
"  Fuzzy search inside files <Space>f
"  Jump between open buffers <Space>b
"  Reopen recent files <Space>r

" Files in current project (like VS Code's Ctrl+P)
nnoremap <leader>p :Files<CR>

" Ripgrep text search in project
nnoremap <leader>f :Rg<CR>


" Recent files
nnoremap <leader>r :History<CR>

" Save file"
nnoremap <leader>w :w<CR>

" Quit file"
nnoremap <leader>q :q<CR>

" Toggle search highlight"
nnoremap <leader>h :nohlsearch<CR>

" Run linting manually
nnoremap <leader>l :ALELint<CR>

" Run fixers (Prettier + ESLint) on demand
nnoremap <leader>F :ALEFix<CR>

" All Things Buffer

" Simple list + choose
nnoremap <leader>bb :ls<CR>:b
"
" FZF buffers (fuzzy by filename)
nnoremap <leader>bl  :Buffers<CR>

" Cycle buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader><Tab> :b#<CR>
"
" Buffer close no save and close no save force
nnoremap <leader>c :bd<CR>
nnoremap <leader>C :bd!<CR>


" Format current file with npx prettier (uses project config)
" nnoremap <leader>P :!npx prettier --write %<CR>
"
" Plugins
" =======
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp=$MYVIMRTP,$VIMRUNTIME,$MYVIMRTP/after
set rtp+=$MYVIMRTP/bundle/Vundle.vim
call vundle#begin('$MYVIMRTP/bundle/')

Plugin 'VundleVim/Vundle.vim'

Plugin 'Chiel92/vim-autoformat'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat.git'

call vundle#end()
" filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" Move text up/down
" =================
" <Alt-k> - up
" <Alt-j> - down

" Navigate windows
" ================
" <Ctrl-k> - up
" <Ctrl-j> - down
" <Ctrl-h> - left
" <Ctrl-l> - right

" Adjust window size
" ==================
" <C-Up>    - increase height
" <C-Down>  - decrease height
" <C-Right> - increase width
" <C-Left>  - decrease width

" Navigate tabs
" =============
" <Alt-h> - previous
" <Alt-l> - next

" Navigate page
" =============
" ,f - next git gutter hunk
" ,b - previous git gutter hunk

" NERD Tree
" =========
" ,nt - toggle NERDTree

" NERD Commenter
" ==============
" ,c  - toggle comment
" ,lc - left comment
" ,uc - uncomment

" Fugitive
" ========
" ,gb - :Gblame
" ,gs - :Gstatus

" Autoformat
" ==========
" ,t - format file

" Toggle Options
" ==============
" ,n - toggle line number

" <F2>  - toggle paste

" ,rc - edit this file in new tab

"=========================================
source $MYVIMRTP/functions.vim

filetype plugin indent on

scriptencoding utf-8
set encoding=utf-8

"tab complete filenames
set wildmode=longest,list,full
set wildmenu

" display status line
set laststatus=2

" use visual bell instead of beeping
set vb

" incremental search
set incsearch

" highlight search
set hlsearch

" case-insensitive search
set ignorecase
set smartcase

" syntax highlighting
set bg=light
syntax on

" disable folding
set nofoldenable

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" tab complete filenames
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" show tab characters
set list
set listchars=tab:·\ 

" 4 space tabs
set tabstop=4

" show matching brackets
set showmatch
highlight MatchParen cterm=bold ctermbg=none ctermfg=green

" show line numbers
set number

" detect .t files as perl
autocmd! BufNewFile,BufRead *.t set ft=perl

" Return to last edit position when opening files
autocmd! BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\" zz" |
     \ endif
" Exclude git commit message
autocmd! BufReadPost COMMIT_EDITMSG
  \ exe "normal! gg"

"Remember info about open buffers on close
set viminfo^=%

set pastetoggle=<F2>

" Show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd! InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd! InsertLeave * match ExtraWhitespace /\s\+$/

highlight clear SignColumn

let mapleader = ","
let g:mapleader = ","

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

imap jj <Esc>

" toggle options
MapToggle <leader>n number

" edit and reload this file
nnoremap <leader>rc :tabe $MYVIMRC<CR>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Adjust window size
map <C-Up>    :resize +5<CR>
map <C-Down>  :resize -5<CR>
map <C-Right> :vertical resize +5<CR>
map <C-Left>  :vertical resize -5<CR>

" Somehow this allows Alt mappings
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50

" Tab navigation
map <C-h> :tabprevious<CR>
map <C-l> :tabnext<CR>
imap <C-h> <esc>:tabprevious<CR>
imap <C-l> <esc>:tabnext<CR>

" dont use Q for Ex mode
nnoremap Q :q
nnoremap q :q
nnoremap wq :wq

vnoremap . :normal .<CR>

" make tab in v mode ident code
xmap <tab> >gv
xmap <s-tab> <gv

" make space indent code
xmap <space> :s/^/ /gi<Enter>:let @/ = "TODO"<Enter> gv
xmap <backspace> :s/^\s//gi<Enter>:let @/ = "TODO"<Enter> gv

" make tab in normal mode ident code
nmap <tab> i<tab><esc>
nmap <s-tab> ^i<bs><esc>

" make space in normal mode insert space
nnoremap <space> i<space><esc>l

" make backspace in normal mode delete
nnoremap <backspace> hx

" Enter newline
nmap <enter> i<cr><esc>

" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>

" NERD Tree
" open NERDTree if no file specified
autocmd! vimenter * if !argc() | NERDTree | only | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.swo$', '\.swp$', '\.ipython', '\.pyc$', '\.pytest_cache', '__pycache__', 'node_modules']
" toggle NERDTRee
" nmap <leader>nt :NERDTreeToggle<CR>

" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings=0
let g:NERDCommentWholeLinesInVMode=1
let g:NERDTreeMapQuit='Q'

map <leader>c  <plug>NERDCommenterToggle
map <leader>lc <plug>NERDCommenterAlignLeft
map <leader>uc <plug>NERDCommenterUncomment

" GitGutter mapping
nmap <leader>f <plug>GitGutterNextHunk
nmap <leader>b <plug>GitGutterPrevHunk
nmap <leader>g :GitGutterBufferToggle<CR>

" Auto formatting
nmap <leader>t :Autoformat<CR>

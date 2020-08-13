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
Plugin 'ngmy/vim-rubocop'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'vim-ruby/vim-ruby'
Plugin 'elixir-editors/vim-elixir'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Plugin 'vim-perl/vim-perl'

call vundle#end()
" filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" Search
" ======
" ,o - open file with fzf
" ,s - search with ripgrep and fzf

" Navigate tabs
" =============
" H - previous
" L - next
" < - move left
" > - move right
" ,# - switch to tab #1-9
" ,tn - open new tab
" ,to - make only tab

" GitGutter
" =============
" ,f - next git gutter hunk
" ,b - previous git gutter hunk
" ,gg - toggle gutter

" NERD Tree
" =========
" ,nt - toggle NERDTree

" NERD Commenter
" ==============
" ,cc  - toggle comment
" ,lc - left comment
" ,uc - uncomment

" Fugitive
" ========
" ,gb - :Gblame
" ,gs - :Gstatus

" Autoformat
" ==========
" ,tt - format file

" RuboCop
" =======
" ,ru - run rubocop

" Toggle Options
" ==============
" ,nu - toggle line number
" ,p - toggle paste

" ,rc - edit this file in new tab

"=========================================
source $MYVIMRTP/functions.vim

filetype plugin indent on

scriptencoding utf-8
set encoding=utf-8

" display status line
set laststatus=2

" use visual bell instead of beeping
set vb

" display column ruler
set textwidth=120
set colorcolumn=100
highlight ColorColumn ctermbg=0

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
highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta

" show line numbers
set number

" Return to last edit position when opening files
autocmd! BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\" zz" |
     \ endif
" Exclude git commit message
autocmd! BufReadPost COMMIT_EDITMSG
  \ exe "normal! gg"

" Remember info about open buffers on close
set viminfo^=%

" custom tabline
set tabline=%!MyTabLine()

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
MapToggle <leader>nu number
MapToggle <leader>p paste

" edit and reload this file
nnoremap <leader>rc :tabe $MYVIMRC<CR>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk

" fuzzy finder fzf
nnoremap <leader>o :Files 
nnoremap <leader>s :Rg 

" Smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" Adjust window size
" map <C-Up>    :resize +5<CR>
" map <C-Down>  :resize -5<CR>
" map <C-Right> :vertical resize +5<CR>
" map <C-Left>  :vertical resize -5<CR>

" Somehow this allows Alt mappings
" let c='a'
" while c <= 'z'
"   exec "set <A-".c.">=\e".c
"   exec "imap \e".c." <A-".c.">"
"   let c = nr2char(1+char2nr(c))
" endw
" set timeout ttimeoutlen=50

" Tab navigation
" map <C-h> :tabprevious<CR>
" map <C-l> :tabnext<CR>
" imap <C-h> <esc>:tabprevious<CR>
" imap <C-l> <esc>:tabnext<CR>
nnoremap H gT
nnoremap L gt
nnoremap <silent> < :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> > :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>tn :tabnew<space>
nnoremap <leader>to :tabo<cr>

" dont use Q for Ex mode
nnoremap Q :q
nnoremap q :q

vnoremap . :normal .<CR>

" retain visual selection after indenting
vnoremap > >gv
vnoremap < <gv

" make tab in v mode ident code
" xmap <tab> >gv
" xmap <s-tab> <gv

" make space indent code
" xmap <space> :s/^/ /gi<Enter>:let @/ = "TODO"<Enter> gv
" xmap <backspace> :s/^\s//gi<Enter>:let @/ = "TODO"<Enter> gv

" make tab in normal mode ident code
" nmap <tab> i<tab><esc>
" nmap <s-tab> ^i<bs><esc>

" make space in normal mode insert space
" nnoremap <space> i<space><esc>l

" make backspace in normal mode delete
" nnoremap <backspace> hx

" Enter newline
" nmap <enter> i<cr><esc>

" Ack
" ignore specific directories in rails apps
nnoremap <leader>ra :Ack! --ignore-dir=log --ignore-dir=coverage --ignore-dir=tmp<space>

" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>

" NERD Tree
" open NERDTree if no file specified
autocmd! vimenter * if !argc() | NERDTree | only | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.git', '\.swo$', '\.swp$', '\.ipython', '\.pyc$', '\.pytest_cache', '__pycache__', 'node_modules', '_build', 'deps']
let g:NERDTreeMapQuit='Q'
" toggle NERDTRee
nmap <leader>nt :NERDTreeToggle<CR>

" NERD Commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDCommentWholeLinesInVMode = 1

map <leader>cc  <plug>NERDCommenterToggle
" map <leader>cl <plug>NERDCommenterAlignLeft
" map <leader>cu <plug>NERDCommenterUncomment

" GitGutter mapping
nmap <leader>gf <plug>(GitGutterNextHunk)
nmap <leader>gb <plug>(GitGutterPrevHunk)
nmap <leader>gg :GitGutterBufferToggle<CR>

" Auto formatting
noremap <leader>tt :Autoformat<CR>
let g:formatters_eruby = ['htmlbeautifier']
let g:formatters_ruby = ['rubocop', 'rbeautify', 'prettier']
let g:formatters_javascript = ['prettier', 'eslint_local', 'jsbeautify_javascript', 'jscs', 'standard_javascript', 'xo_javascript']

let g:formatdef_htmlbeautifier = '"htmlbeautifier -b1"'
let g:formatdef_perltidy = '"perltidy -pro=/opt/dev/perltidyrc -q "'
let g:formatdef_rubocop = "'rubocop --auto-correct -c /opt/dev/rubocop.yml -o /dev/null -s '.bufname('%').' | sed -n 2,\$p'"

" Vim RuboCop
let g:vimrubocop_config = '/opt/dev/rubocop.yml'

" Plugins
" =======
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim'

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

" System clipboard
" ================
" ,d - cut to clipboard
" ,y - copy to clipboard
" ,p - paste from clipboard

" NERD Tree
" =========
" ,nt - toggle NERDTree

" NERD Commenter
" ==============
" ,c  - toggle comment
" ,cc - double comment left align
" ,uc - uncomment

" Tagbar
" ======
" ,tb - toggle tagbar

" Fugitive
" ========
" ,gb - :Gblame
" ,gs - :Gstatus

" ,t - perltidy

" ,ln - toggle line number
" ,ic - toggle ignorecase

" <F2>  - toggle paste
" <F3>  - perltidy, podtidy
" <F4>  - perl -c, perlcritic, podchecker
" <F5>  - execute perl
" <F6>  - prove
" <F9>  - perldoc
" <F12> - toggle mouse

" ,rc - edit this file in new tab

"=========================================
" source ~/.vim/functions.vim

" Pathogen
" execute pathogen#infect()

filetype plugin indent on
"filetype plugin on

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

" magic search
" nnoremap / /\v

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

" autoindent
autocmd FileType perl,python set autoindent|set smartindent
inoremap # X<BS>#

" 4 space tabs
set tabstop=4|set shiftwidth=4|set softtabstop=4
autocmd FileType python set expandtab

" show matching brackets
autocmd FileType perl,python set showmatch
highlight MatchParen cterm=bold ctermbg=none ctermfg=green

" show line numbers
autocmd FileType perl,python set number

" check perl code with :make
" autocmd FileType perl set makeprg=perl\ -Ilib\ -c\ %\ $*
" autocmd FileType perl set errorformat=%f:%l:%m
" autocmd FileType perl set autowrite

" detect .t files as perl
" autocmd! BufNewFile,BufRead *.t set ft=perl

" Return to last edit position when opening files (You want this!)
autocmd! BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\" zz" |
     \ endif
" Exclude git commit message
autocmd! BufReadPost COMMIT_EDITMSG
  \ exe "normal! gg"

"Remember info about open buffers on close
set viminfo^=%

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

let mapleader = ","
let g:mapleader = ","

" toggle options
" MapToggle <leader>ln number
" MapToggle <leader>ic ignorecase
" MapToggle <leader>ro readonly

" edit and reload this file
nnoremap <leader>rc :tabe $MYVIMRC<CR>
autocmd! bufwritepost .vimrc source $MYVIMRC

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

" Clipboard
" xmap <silent> <leader>d d: call system("xclip -i -selection clipboard", getreg("\""))<CR>
" xmap <silent> <leader>y y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
" nmap <silent> <leader>p :call setreg("\"",system("xclip -o -selection clipboard"))<CR>gP

" Fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>

" NERD Tree
" open NERDTree if no file specified
autocmd! vimenter * if !argc() | NERDTree | only | endif
" toggle NERDTRee
map <leader>nt :NERDTreeToggle<CR>
" Close NERDTree if it is the last window
" autocmd! bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.swp$']

" NERD commenter options/mappings
let NERDCreateDefaultMappings=0
let NERDCommentWholeLinesInVMode=1
let NERDTreeMapQuit='Q'

map <leader>c  <plug>NERDCommenterToggle
map <leader>lc <plug>NERDCommenterAlignLeft
map <leader>uc <plug>NERDCommenterUncomment

" GitGutter mapping
nmap <leader>f <plug>GitGutterNextHunk
nmap <leader>b <plug>GitGutterPrevHunk

" xmllint
" nmap <silent> <leader>xml mf :%!xmllint --format --recover - 2>/dev/null<Enter> `fzz

" my perl includes pod
" let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
" let perl_extended_vars = 1

au FileType python setlocal formatprg=autopep8\ -
au Filetype python nnoremap ,t :let t = winsaveview()<CR>:%!autopep8 -<CR>:w<CR>:call winrestview(t)<CR>

set pastetoggle=<F2>
" nnoremap <F3> mf :%!perltidy -q<Enter> :%!podtidy -v<Enter> `fzz
" imap <F3> <esc><F3>
" xmap <leader>t :!perltidy -q<Enter>
" nmap <F4> :!reset;perl -Ilib -c %; perlcritic %; podchecker %<CR>
" imap <F4> <esc><F4>

" nmap <F5> :!reset;perl -Ilib %<CR>
" imap <F5> <esc><F5>

" nmap <F9> :!perldoc %<CR>
" imap <F9> <esc><F9>

" Show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd! InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd! InsertLeave * match ExtraWhitespace /\s\+$/

highlight clear SignColumn

" ~/.vimrc    ::   Paul Tarjan <vimrc@paulisageek.com>

set rtp=~/.vim,$VIMRUNTIME
set autoindent
"set backupcopy=yes  " to keep mac creator codes
"set backupdir=~/.vim/backup
set bs=2
set clipboard=unnamed
set encoding=utf-8
set hlsearch
set ignorecase smartcase
set incsearch
set nocompatible
set noerrorbells
set vb t_vb=
set ruler
set scrolloff=2
set shell=/bin/sh
set showcmd
set showmatch
set switchbuf=useopen
if version >= 700
  set switchbuf+=usetab
  set showtabline=2
  set nofsync
endif
"set smartindent
set shiftwidth=2
set et
set smarttab
set ttyfast
set wildmenu
set wmh=0   " these disable the one line that vim shows by
set wmw=0   " default for minimised
set wrap
set fillchars=stl:_,stlnc:-,vert:\|,fold:\ ,diff:-
set swapsync=
set history=1000
"set mouse=a
set hidden
set title
set tabpagemax=15
let mapleader = ","
set wildignore+=*.o,*.obj,.git,.svn,.hg,*.gif,*.png,*.jpg,*.zip,*.tgz,*.tar.gz,*.tar.bz2,*.bmp,*.swf,*.eps,*.tiff,*.pdf,*.ps,*.ai,*.avi,*.ico,*.psd,*.docx,*.doc
set nofoldenable

" Vundle
" Make sure you do this first: 
"
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Then on a new system do
"
"   vim +PluginInstall +qall
"

set nocompatible
filetype off


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Git wrapper
Plugin 'tpope/vim-fugitive'
" The directory on the left
Plugin 'scrooloose/nerdtree'
" Easy surounding
Plugin 'tpope/vim-surround'
" Control P
Plugin 'kien/ctrlp.vim'
" Status line
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" Better comments
Plugin 'scrooloose/nerdcommenter'
" Better JS
Plugin 'pangloss/vim-javascript'
" Syntax checking
Plugin 'scrooloose/syntastic'
" Nicer QuickFix
Plugin 'tpope/vim-unimpaired'
" Sensible defaults
Plugin 'tpope/vim-sensible'
" Better Ruby
Plugin 'vim-ruby/vim-ruby'
" Better Go
Plugin 'fatih/vim-go'
" Jumping around the file
Plugin 'easymotion/vim-easymotion'
" Highlight Whitespace
Plugin 'ntpeters/vim-better-whitespace'

"" Autocomplete
"Plugin 'ervandew/supertab'
"" Automatically open autocomplete thing
"Plugin 'AutoComplPop'
" Autocomplete
"Plugin 'Valloric/YouCompleteMe'
" Javascript Autocomplete
"Plugin 'marijnh/tern_for_vim'

call vundle#end()
filetype plugin indent on
syntax on

colorscheme daaku

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" These screw up ionic files so badly
let g:syntastic_html_checkers = ['']
" I only want to use this one linter, not scss
let g:syntastic_scss_checkers = ['scss_lint']
" I like all
let g:syntastic_javascript_checkers = ['jscs', 'jshint', 'eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_ruby_rubocop_exec = '/Users/pt/bin/rubocop.sh'
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}

" YCM
autocmd CompleteDone * pclose
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1

" Often mis typed commands
command! Q  q
command! W  w
command! Wq wq
command! WQ wq
map Q :q<CR>

" Remap ` to ' to use column in mark
nnoremap ' `
nnoremap ` '

" Tabs
nmap <silent> <C-y> :tabnew<cr>
imap <silent> <C-y> <ESC>:tabnew<cr>
nmap <silent> ,, :tabprevious<CR>
nmap <silent> .. :tabnext<CR>

" Edit another file in the same directory as the current file, use: ,e
if has("unix")
  map ,e :tabe <C-R>=expand("%:p:h") . "/" <CR>
else
  map ,e :tabe <C-R>=expand("%:p:h") . "\\" <CR>
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
augroup END

" Ruby Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" files in /tmp, like crontabs need this
autocmd BufReadPost /tmp/* set backupcopy=yes

" python world is 4 spaces
au BufNewFile,BufRead *.py setlocal shiftwidth=4

" try to select a better html mode based on file contents
fun! s:SelectHTML()
  let n = 0
  while n < 50 && n < line("$")
    " check for jinja
    if getline(n) =~ '{%\s*\(extends\|block\|comment\|ssi\|if\|for\|blocktrans\)\>'
      set ft=htmljinja
      return
    endif
    " check for php
    if getline(n) =~ '<?php'
      set ft=php
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun
autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()

" disable automatic folding in php
let g:DisableAutoPHPFolding = 1

set expandtab

" search full path for tags
set tags=tags;/

" colour scheme
"syntax enable
"set background=dark
"colorscheme solarized

" PHP comments
set comments=s1:/*,mb:*,ex:*/

" Ryan's crazy jk crazy escape
inoremap jk <esc>
inoremap <esc> <nop>

" Enter command mode by pressing ; instead of :
noremap ; :

" Window nav
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" jk should scroll by actual lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" Strip trailing whitespace
autocmd FileType c,cpp,java,php,javascript,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

set tabstop=2

" http://stackoverflow.com/questions/7797593/highlighting-more-than-80-characters-with-a-non-standard-colorscheme
highlight OverLength ctermbg=red ctermfg=white guibg=#59292
set textwidth=80

" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Control p
" Only search to current working dir
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_cmd = 'CtrlPMixed'

" line up params
set cindent
set cino=(0<Enter>

" http://blog.mattcrampton.com/post/86216925656/move-vim-swp-files
" Make sure to run 
" mkdir -p ~/.vim/{backup_files,swap_files,undo_files}
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" <mwang>
nnoremap <leader>p  :setl paste!<CR>:setl paste?<CR>
nnoremap <leader>s  :setl spell!<CR>:setl spell?<CR>
nnoremap <leader>v  <C-w>v
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <C-Left>
cnoremap <C-f> <C-Right>
cnoremap <C-d> <Delete>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>

" Fugitive - Leader mappings.
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gl :Glog<CR><CR><CR>:copen<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gh :Gbrowse<CR>
" </mwang>

" ~/.vimrc    ::   Naitik Shah <naitik.shah@yahoo.com>

set rtp=~/.vim,$VIMRUNTIME
set autoindent
"set backupcopy=yes  " to keep mac creator codes
"set backupdir=~/.vim/backup
set bs=2
set clipboard=unnamed
set directory=~/.vim/swaps
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

" pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on

colorscheme daaku

" CWD Sensitive Tags
" let &tags=system("~/.vim/bin/find-tags")

" GUI Font
if has("gui_gtk")
  set guifont=Monospace\ 11
elseif has("macunix")
  if has("gui_running")
    set go-=T
    set lines=37
    set columns=151
    set guifont=Menlo:h13
  endif
endif

" Often mis typed commands
command! Q  q
command! W  w
command! Wq wq
command! WQ wq
map Q :q<CR>

" Remap ` to ' to use column in mark
nnoremap ' `
nnoremap ` '

" QuickFix
map <silent> <C-n> :cn<CR>
map <silent> <C-p> :cp<CR>

" Spell Check
map <silent> <S-s> :set spell!<CR>

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

" Clear Search Hdark
nmap <silent> <C-h> :silent noh<CR>

" Word-Wrap Mode
map <f9> :set textwidth=72 | normal }j<CR>

" Hilight 80+ cols
map ,8 /\%>80v.\+<CR>

" Strip Trailing White-Space
map <C-c> :%s/\s\+$//<CR>

" Tag List
" nmap <silent> T :TlistToggle<CR>

" Nerd Tree
nmap <silent> F :NERDTreeToggle<CR>

" Align Shortcuts :: <space>, =, //, :
map <f4> :Align w=  <CR>
map <f5> :Align w= =<CR>
map <f6> :Align w= //<CR>
map <f7> :Align w= :<CR>
map ,a :Align w=<space>

" To tell what syntax highlighting group *that* is!
map <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"map <silent> ,f :FufFile<cr>

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

" custom file detects syntax files
augroup filetypedetect
  au BufNewFile,BufRead *.phpt set filetype=php
augroup END

" files in /tmp, like crontabs need this
autocmd BufReadPost /tmp/* set backupcopy=yes

" python world is 4 spaces
au BufNewFile,BufRead *.py setlocal shiftwidth=4

" clojure
let g:vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let g:vimclojure#ParenRainbow=1           " Rainbow parentheses'!

" try to select a better mode based on file contents
fun! s:SelectTXT()
  let n = 1
  while n < 50 && n < line("$")
    " check for django
    if getline(n) =~ '{%\s*\(extends\|block\|comment\|ssi\|if\|for\|blocktrans\)\>'
      set ft=django
      return
    endif
    let n = n + 1
  endwhile
endfun
autocmd BufNewFile,BufRead *.txt  call s:SelectTXT()

" also acceptable
au BufNewFile,BufRead *.json	set filetype=javascript

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

" git commit
au BufRead,BufNewFile COMMIT_EDITMSG call SplitGitShow()
function! SplitGitShow()
  let mode = "show"
  call cursor(1,1)
  let reset_line = search('^# *(use "git reset ')
  if reset_line != 0
  endif
    let matches = matchlist(getline("."), '# *(use "git reset \(HEAD\^\?1\?\) ')
    if len(matches) > 1 && len(matches[1])
      let mode = "cached"
      let base = matches[1]
    endif
  vnew
  set filetype=git
  set buftype=nofile
  if mode == "show"
    silent read !git show
  elseif mode == "cached"
    execute "silent read !git diff --cached " . base
  else
    silent read !echo "oops"
  endif
  normal ggdd
  execute "normal \<C-w>\h"
  normal %s/Reviewers: /Reviewers: jcain, rhe, naitik, caseymrm/
  normal gg
endfunction

" FB STUFF
if hostname() =~# "^[a-z][a-z]*[0-9][0-9]*\.snc[0-9]\.facebook\.com$"
  let g:on_dev = 1
else
  let g:on_dev = 0
endif

if g:on_dev
  source /home/engshare/admin/scripts/vim/biggrep.vim
  source /home/engshare/admin/scripts/vim/php-doc.vim
  noremap <C-\> :TBGW<CR>
endif

" ___________________
" ptarjan's additions
" ___________________
"

set expandtab

" search full path for tags
set tags=tags;/

" colour scheme
"syntax enable
"set background=dark
"colorscheme solarized
nmap <silent> ,f :FufFileWithCurrentBufferDir<cr>
nmap <silent> ,b :FufBuffer<cr>

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

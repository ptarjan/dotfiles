" ~/.vimrc    ::   Paul Tarjan <vimrc@paulisageek.com>

" ============================================================================
" BASIC SETTINGS
" ============================================================================

set nocompatible
set rtp=~/.vim,$VIMRUNTIME

" Leader key
let mapleader = ","

" Display
set ruler
set showcmd
set showmatch
set title
set number
set scrolloff=2
set wrap
set fillchars=stl:_,stlnc:-,vert:\|,fold:\ ,diff:-

" Search
set hlsearch
set incsearch
set ignorecase smartcase

" Indentation and formatting
set autoindent
set cindent
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab

" Behavior
set bs=2
set clipboard=unnamed
set encoding=utf-8
set hidden
set ttyfast
set wildmenu
set history=1000
set nofoldenable
set textwidth=120

" UI
set noerrorbells
set vb t_vb=
set t_BE=

" Tabs and windows
set switchbuf=useopen
set wmh=0
set wmw=0
set tabpagemax=15
if version >= 700
  set switchbuf+=usetab
  set showtabline=2
  set nofsync
endif

" Files and backups
set backupdir=~/.vim/backup_files/
set directory=~/.vim/swap_files/
set undodir=~/.vim/undo_files/

" Tags and completion
set tags=tags;/
set comments=s1:/*,mb:*,ex:*/

" Wildignore
set wildignore+=*.o,*.obj,.git,.svn,.hg,*.gif,*.png,*.jpg,*.zip,*.tgz,*.tar.gz,*.tar.bz2,*.bmp,*.swf,*.eps,*.tiff,*.pdf,*.ps,*.ai,*.avi,*.ico,*.psd,*.docx,*.doc,*/node_modules/*

" ============================================================================
" PLUGIN MANAGEMENT (VUNDLE)
" ============================================================================
" Make sure you do this first:
"   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Then on a new system do:
"   vim +PluginInstall +qall

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

" File navigation
Plugin 'scrooloose/nerdtree'

" Editing
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-sensible'
Plugin 'easymotion/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ConradIrwin/vim-bracketed-paste'

" Syntax and linting
Plugin 'w0rp/ale'
Plugin 'neoclide/coc.nvim'

" Languages - JavaScript/TypeScript
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }

" Languages - Ruby
Plugin 'vim-ruby/vim-ruby'

" Languages - Go
Plugin 'fatih/vim-go'

" Languages - C++
Plugin 'rhysd/vim-clang-format'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Languages - Other
Plugin 'saltstack/salt-vim'

" Search
Plugin 'mileszs/ack.vim'
Plugin 'mhinz/vim-grepper'

" Color schemes
Bundle 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on
syntax on

" ============================================================================
" PLUGIN CONFIGURATIONS
" ============================================================================

" ALE
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_pattern_options = {'\.\(cc\|h\)$': {'ale_enabled': 0}}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'vue': ['eslint']
\}
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['prettier'],
\    'vue': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier'],
\    'python' : ['autopep8', 'reorder-python-imports', 'trim_whitespace', 'remove_trailing_lines'],
\}

" COC
autocmd CompleteDone * pclose

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard | grep -v node_modules', 'find %s -type f']
let g:ctrlp_cmd = 'CtrlPMixed'

" FZF
set rtp+=/usr/local/opt/fzf
nnoremap <C-P> :FZF<CR>

" Fugitive
let g:github_enterprise_urls = ['https://git.corp.stripe.com']

" Ruby
let g:ruby_indent_access_modifier_style="indent"
let g:DisableAutoPHPFolding = 1

" Makeprg
set makeprg=scripts/bin/typecheck

" ============================================================================
" COLORS AND UI
" ============================================================================

syntax enable
set background=dark
colorscheme solarized

" ============================================================================
" CUSTOM FUNCTIONS
" ============================================================================

" Try to select a better html mode based on file contents
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

" ============================================================================
" KEY MAPPINGS
" ============================================================================

" Fix common typos
command! Q  q
command! W  w
command! Wq wq
command! WQ wq
map Q :q<CR>

" Easier command mode
noremap ; :

" Quick escape
inoremap jk <esc>

" Remap ` to ' to use column in mark
nnoremap ' `
nnoremap ` '

" Better j/k - scroll by actual lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Tab management
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Edit file in same directory
if has("unix")
  map ,e :tabe <C-R>=expand("%:h") . "/" <CR>
else
  map ,e :tabe <C-R>=expand("%:h") . "\\" <CR>
endif

" CTags navigation
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Leader mappings - General
nnoremap <leader>p :setl paste!<CR>:setl paste?<CR>
nnoremap <leader>s :setl spell!<CR>:setl spell?<CR>
nnoremap <leader>v <C-w>v
nnoremap <leader>l :echo line(".") + 1<CR>
nnoremap <leader>t :silent make\|redraw!\|cw<CR>

" Leader mappings - Git (Fugitive)
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gl :Glog<CR><CR><CR>:copen<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gh :Gbrowse<CR>

" Leader mappings - Language specific
nnoremap <leader>a :!rubocop -a %<CR>
nnoremap <leader>d A<CR>import pdb; pdb.set_trace()<C-c>
nnoremap <leader>D A<CR>import pdb; pdb.set_trace()<C-c>
nnoremap <leader>r ibaogang.song justin ann.rajan kelechi.dike gabriel.silk<C-c>

" Plugin mappings - Grepper
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" Command line emacs-style mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Delete>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>

" ============================================================================
" AUTOCOMMANDS
" ============================================================================

" Jump to last cursor position when opening a file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
augroup END

" Strip trailing whitespace on save
autocmd FileType c,cpp,java,php,javascript,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" QuickFix window management
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l* lwindow

" Files in /tmp (like crontabs) need this
autocmd BufReadPost /tmp/* set backupcopy=yes

" ============================================================================
" LANGUAGE-SPECIFIC SETTINGS
" ============================================================================

" C/C++
autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp set shiftwidth=4

" Python
au BufNewFile,BufRead *.py setlocal shiftwidth=4

" Ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd BufNewFile,BufRead *.rbi set syntax=ruby

" TypeScript
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

" YAML
autocmd Filetype yaml setlocal tabstop=2 ai

" HTML
autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()

" Jenkins
au BufNewFile,BufRead Jenkinsfile setf groovy

" ~/.vimrc    ::   Paul Tarjan <vimrc@paulisageek.com>

" ============================================================================
" GENERAL SETTINGS
" ============================================================================

set nocompatible
set rtp=~/.vim,$VIMRUNTIME
set encoding=utf-8

" Indentation
set autoindent
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab
set cindent

" Search
set hlsearch
set incsearch
set ignorecase smartcase

" UI
set ruler
set showcmd
set showmatch
set scrolloff=2
set wildmenu
set wmh=0   " these disable the one line that vim shows by
set wmw=0   " default for minimised
set wrap
set fillchars=stl:_,stlnc:-,vert:\|,fold:\ ,diff:-
set title
set ttyfast
if version >= 700
  set switchbuf+=usetab
  set showtabline=2
  set nofsync
endif

" Behavior
set bs=2
set clipboard=unnamed
set switchbuf=useopen
set hidden
set history=1000
set tabpagemax=15
set nofoldenable
set textwidth=120
set tags=tags;/

" Bells
set noerrorbells
set vb t_vb=

" Shell
set shell=/bin/sh

" File patterns to ignore
set wildignore+=*.o,*.obj,.git,.svn,.hg,*.gif,*.png,*.jpg,*.zip,*.tgz,*.tar.gz,*.tar.bz2,*.bmp,*.swf,*.eps,*.tiff,*.pdf,*.ps,*.ai,*.avi,*.ico,*.psd,*.docx,*.doc,*/node_modules/*

" Backup and swap files
" Make sure to run: mkdir -p ~/.vim/{backup_files,swap_files,undo_files}
set backupdir=~/.vim/backup_files/
set directory=~/.vim/swap_files/
set undodir=~/.vim/undo_files/

" Comments
set comments=s1:/*,mb:*,ex:*/

" Turn off bracketed paste
set t_BE=

" Leader key
let mapleader = ","


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

" Plugin manager
Plugin 'gmarik/Vundle.vim'

" Git integration
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

" File navigation
Plugin 'scrooloose/nerdtree'

" Editing enhancements
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/nerdcommenter'
Plugin 'easymotion/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ConradIrwin/vim-bracketed-paste'

" Search tools
Plugin 'mileszs/ack.vim'
Plugin 'mhinz/vim-grepper'

" Syntax & Linting
Plugin 'w0rp/ale'

" Autocomplete
Plugin 'neoclide/coc.nvim'

" Language support - JavaScript/TypeScript
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }

" Language support - Ruby
Plugin 'vim-ruby/vim-ruby'

" Language support - Go
Plugin 'fatih/vim-go'

" Language support - C/C++
Plugin 'rhysd/vim-clang-format'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Language support - Salt
Plugin 'saltstack/salt-vim'

" Color schemes
Bundle 'altercation/vim-colors-solarized'

" Commented out plugins
" Plugin 'kien/ctrlp.vim'
" Plugin 'FelikZ/ctrlp-py-matcher'
" Plugin 'junegunn/fzf'
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" Plugin 'scrooloose/syntastic'
" Plugin 'jpo/vim-railscasts-theme'
" Plugin 'zeis/vim-kolor'
" Bundle "gilligan/vim-lldb"
" Plugin 'ervandew/supertab'
" Plugin 'AutoComplPop'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'marijnh/tern_for_vim'
" Plugin 'prabirshrestha/async.vim'
" Plugin 'prabirshrestha/vim-lsp'
" Plugin 'prabirshrestha/asyncomplete.vim'
" Plugin 'prabirshrestha/asyncomplete-buffer.vim'
" Plugin 'yami-beta/asyncomplete-omni.vim'

call vundle#end()
filetype plugin indent on
syntax on


" ============================================================================
" PLUGIN CONFIGURATIONS
" ============================================================================

" --- FZF ---
set rtp+=/usr/local/opt/fzf

" --- ALE (Asynchronous Lint Engine) ---
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
"let g:ale_fix_on_save = 1

" --- YouCompleteMe ---
autocmd CompleteDone * pclose
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1

" --- Control P ---
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard | grep -v node_modules', 'find %s -type f']
let g:ctrlp_cmd = 'CtrlPMixed'

" --- GitHub Enterprise ---
let g:github_enterprise_urls = ['https://git.corp.stripe.com']

" --- PHP ---
let g:DisableAutoPHPFolding = 1

" --- Make ---
set makeprg=scripts/bin/typecheck


" ============================================================================
" COLOR SCHEME AND APPEARANCE
" ============================================================================

syntax enable
set background=dark
colorscheme solarized


" ============================================================================
" AUTOCOMMANDS
" ============================================================================

" Jump to last cursor position when opening a file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
augroup END

" Ruby settings
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
let g:ruby_indent_access_modifier_style="indent"
autocmd BufNewFile,BufRead *.rbi set syntax=ruby

" Python settings
au BufNewFile,BufRead *.py setlocal shiftwidth=4

" YAML settings
autocmd Filetype yaml setlocal tabstop=2 ai

" C/C++ settings
autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp set shiftwidth=4
" autocmd BufWrite *.cc :! ./tools/scripts/format_cxx.sh %

" TypeScript settings
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

" HTML file type detection
autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()

" Jenkins
au BufNewFile,BufRead Jenkinsfile setf groovy

" Files in /tmp need this
autocmd BufReadPost /tmp/* set backupcopy=yes

" Strip trailing whitespace on save
autocmd FileType c,cpp,java,php,javascript,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" QuickFix auto-open
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l* lwindow


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

" --- Command mode shortcuts ---
" Enter command mode with semicolon
noremap ; :

" Fix common typos
command! Q  q
command! W  w
command! Wq wq
command! WQ wq
map Q :q<CR>

" --- Navigation ---
" Remap ` to ' to use column in mark
nnoremap ' `
nnoremap ` '

" jk should scroll by actual lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" --- Tab management ---
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
" Alternative tab navigation
nnoremap th :tabnext<CR>
nnoremap tl :tabprev<CR>
nnoremap tn :tabnew<CR>

" --- Insert mode shortcuts ---
" Ryan's crazy jk escape
inoremap jk <esc>
" inoremap <esc> <nop>

" --- Command line editing ---
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Delete>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>

" --- Leader mappings ---

" File editing
if has("unix")
  map ,e :tabe <C-R>=expand("%:h") . "/" <CR>
else
  map ,e :tabe <C-R>=expand("%:h") . "\\" <CR>
endif

" Utility toggles
nnoremap <leader>p :setl paste!<CR>:setl paste?<CR>
nnoremap <leader>s :setl spell!<CR>:setl spell?<CR>
nnoremap <leader>v <C-w>v

" Code navigation
nnoremap <leader>jd :YcmCompleter GoTo<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Fuzzy file finder
nnoremap <C-P> :FZF<CR>

" Git (Fugitive)
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gl :Glog<CR><CR><CR>:copen<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gh :Gbrowse<CR>

" Search (Grepper)
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" Build/Type checking
nnoremap <leader>t :silent make\|redraw!\|cw<CR>

" Language-specific shortcuts
nnoremap <leader>l :echo line(".") + 1<CR>
nnoremap <leader>a :!rubocop -a %<CR>
nnoremap <leader>D A<CR>import pdb; pdb.set_trace()<C-c>
nnoremap <leader>d A<CR>import pdb; pdb.set_trace()<C-c>
nnoremap <leader>r ibaogang.song justin ann.rajan kelechi.dike gabriel.silk<C-c>


" ============================================================================
" COMMENTED OUT CONFIGURATIONS
" ============================================================================

" --- Syntastic (replaced by ALE) ---
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_html_checkers = ['']
"let g:syntastic_scss_checkers = ['scss_lint']
"let g:syntastic_javascript_checkers = ['jscs', 'jshint', 'eslint']
"let g:syntastic_ruby_checkers = ['rubocop']
"let g:syntastic_ruby_rubocop_exec = '/Users/pt/bin/rubocop.sh'
"let g:syntastic_eruby_ruby_quiet_messages =
"    \ {'regex': 'possibly useless use of a variable in void context'}

" --- vim-lsp (replaced by coc.nvim) ---
" au User lsp_setup call lsp#register_server({
"       \ 'name': 'sorbet',
"       \ 'cmd': {server_info->[&shell, &shellcmdflag, 'sorbet/scripts/typecheck_devel --lsp']},
"       \ 'initialization_options': {"diagnostics": "true"},
"       \ 'whitelist': ['ruby'],
"       \ })
" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')
"
" call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
"     \ 'name': 'buffer',
"     \ 'whitelist': ['*'],
"     \ 'blacklist': ['go'],
"     \ 'completor': function('asyncomplete#sources#buffer#completor'),
"     \ }))
" set omnifunc=syntaxcomplete#Complete
" call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
" 		\ 'name': 'omni',
" 		\ 'whitelist': ['*'],
" 		\ 'blacklist': ['c', 'cpp', 'html'],
" 		\ 'completor': function('asyncomplete#sources#omni#completor')
" 		\ }))

" --- FZF advanced mappings ---
" nnoremap <C-p> :FZF<CR>
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" --- Other commented debugging shortcuts ---
" nnoremap <leader>D A<CR>require 'pry'; binding.pry<C-c>
" nnoremap <leader>D ^irequire 'pry'; binding.pry<CR><C-c>k$
" nnoremap <leader>d A<CR>stopInDebugger();<C-c>

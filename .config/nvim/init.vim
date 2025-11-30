" ============================================================================
" Neovim Configuration (init.vim)
" ============================================================================
" Use existing vim configuration instead of duplicating settings

" Use vim's runtime paths and plugin directories
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" Source the main .vimrc configuration file
source ~/.vimrc

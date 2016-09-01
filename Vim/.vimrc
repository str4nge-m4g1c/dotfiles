set nocompatible              " be iMproved, required
set encoding=utf-8	      " change encoding, specifically for NERDTree
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=C:/Users/s72381/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('C:/Users/s72381/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
" Plugin 'valloric/youcompleteme' " needs to be compiled
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'altercation/vim-colors-solarized'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
" Plugin 'mattn/emmet-vim'
" Plugin 'easymotion/vim-easymotion'
" Plugin 'majutsushi/tagbar'
" Plugin 'tpope/vim-fugitive'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" Key Bindings 
map <C-n> :NERDTreeToggle<CR>
" nmap <F8> :TagbarToggle<CR> " This is the mapping for the tagbar plugin

" Notes plugin configuration
:let g:notes_directories = ['/d/OneDrive - IAG/Notes/']

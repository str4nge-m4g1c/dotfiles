set nocompatible              " be iMproved, required
set encoding=utf-8	      " change encoding, specifically for NERDTree
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' 				" Package manager for VIM
Plugin 'scrooloose/nerdtree'				" Tree explorer navigation (Shortcut: CRTL+n)
Plugin 'Xuyuanp/nerdtree-git-plugin'			" Git integration for NERDTree
Plugin 'christoomey/vim-tmux-navigator'			" Navigate between the VIM panels (CRTL+left/right/up/down arrow)
Plugin 'kien/ctrlp.vim'					" Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plugin 'tpope/vim-surround'				" Text surround
Plugin 'terryma/vim-multiple-cursors'			" Sublime like multi cursor functions
Plugin 'scrooloose/syntastic'				" Syntax highlighting
Plugin 'tpope/vim-fugitive'				" Git wrapper for VIM
Plugin 'tpope/vim-eunuch'				" Simple file commands
Plugin 'bling/vim-airline'
" Plugin 'valloric/youcompleteme' 			" Code completion for VIM --- needs to be compiled before it can work
" Plugin 'mattn/emmet-vim'				" Code snippets for web development
" Plugin 'easymotion/vim-easymotion'			" Easy movement in VIM
" Plugin 'majutsushi/tagbar'				" Dont really know what this does
Plugin 'chase/vim-ansible-yaml'       " Additional support for Ansible in VIM
" Plugin 'MicahElliott/Rocannon'      " Vim for Ansible playbooks: omni-completion, abbreviations, syntax, folding, K-docs, and colorscheme



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

" NERDTree plugin configuration
map <C-y> :NERDTreeToggle<CR>

" TagBar plugin configuration
" nmap <F8> :TagbarToggle<CR> " This is the mapping for the tagbar plugin

" CtrlP plugin configuration
let g:ctrlp_map = '<c-p>'   
let g:ctrlp_cmd = 'CtrlP'


" Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at

"     http://www.apache.org/licenses/LICENSE-2.0

" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
"

" --------------- General ----------------------------

" Use Vim mode, not vi mode
set nocompatible

" Enable file type detection
filetype plugin indent on

" Enable colour syntax highlighting
syntax enable

" Set the shell to use
set shell=/usr/bin/bash

" Change the working directory to the one containing the file which was opened
" or selected
set autochdir

" Filenames for the tag command
set tags=./tags;$HOME,./ctags;$HOME,./.vimtags;$HOME

" Do not wrap lines longer than the window's width
set nowrap

" Set how many character to scroll sidewise
set sidescroll=1

" Move to the previous/next line when press at the beginning/end of one
set whichwrap=h,l

" Disable the use of the mouse
set mouse=

" Redraw only when we need to
set lazyredraw

" Set the leader key
let mapleader = ','

" Display line numbers at the left of the screen
set number

" Indentation options
set smarttab
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2

" highlight current line
set cursorline

" highlight search
set incsearch
set hlsearch

set laststatus=2

" --------------- Plugins ----------------------------

call plug#begin('~/.vim/plugged')


Plug 'scrooloose/nerdtree'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Golang
Plug 'fatih/vim-go'
Plug 'nsf/gocode'

" Add plugins to &runtimepath
call plug#end()


" --------------- Customization ----------------------------

" let g:airline#extensions#tabline#enabled = 2
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = '|'
" let g:airline_left_sep = ' '
" let g:airline_left_alt_sep = '|'
" let g:airline_right_sep = ' '
" let g:airline_right_alt_sep = '|'
" let g:airline_theme= 'molokai'


" --------------- Theme ----------------------------------

" set background=dark
" colorscheme material-theme
color dracula
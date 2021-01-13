" this allows pathogen plugin to be in its own submodule
runtime bundle/pathogen/autoload/pathogen.vim

filetype off
call pathogen#infect()
filetype plugin indent on

" default swap file location
set directory=~/tmp//,.

" identation
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" buffer search
set hls " highlight search
set incsearch " incremental search
set ignorecase " ignore case ...
set smartcase " ... but only if there is no uppercase letters
set showmatch " quickly jump cursor to matching bracket

set linebreak " won't split a word

set encoding=utf-8
set t_Co=256
colorscheme ir_black
set number
set title
set showcmd

let mapleader = ","
nnoremap <silent> <Leader><Space> :noh<Cr>
nnoremap <Leader>c :CtrlP<Cr>
inoremap jj <Esc>
" save file
nnoremap <Leader>s :w<Cr>

" most common vertical movement in wrapped lines
" for other commands, prepend 'g' ex. g$
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" buffers
nnoremap <C-N> :bnext<Cr>

nnoremap <F2> :call BlogPost()<Cr>
" run a spellchecker
nnoremap <F3> :call SetSpell()<Cr>
nnoremap <F4> :call SetFoldMethod()<Cr>
nmap <leader>m <Plug>FocusModeToggle

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>v :source $MYVIMRC<cr>
" easy copy to clipboard from Vim
vnoremap Y "+y

" my filetypes
au BufNewFile,BufRead *.j2 setf htmljinja

" GUI options
if has("gui_running")
    set lines=40
    set columns=84 " 80 + 4 lines that 'numbers' uses
    set guifont=Monospace\ 12
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
endif

function! BlogPost()
    set ft=markdown
    set tw=62
    %s/“/"/ge
    %s/”/"/ge
    %s/’/'/ge
endfunction

function! SetSpell()
    if &spell
        set nospell
        echo "No spell checking"
    else
        set spell
        echo "Spell checking"
    endif
endfunction

function! SetFoldMethod()
    if &foldmethod == "manual"
        set foldmethod=indent
        echo "Foldmethod: indent"
    else
        set foldmethod=manual
        echo "Foldmethod: manual"
    endif
endfunction

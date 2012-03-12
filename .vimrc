" this allows pathogen plugin to be in its own submodule
runtime bundle/pathogen/autoload/pathogen.vim

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" default swap file location
set directory=~/tmp//,.

" identation
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" search
set hls " highlight search
set incsearch " incremental search
set ignorecase " ignore case ...
set smartcase " ... but only if there is no uppercase letters
set showmatch " quickly jump cursor to matching bracket

" wrapped lines
"set wrap
"set textwidth= 78
set linebreak " won't split a word
"set list " will show hidden characters

set encoding=utf-8
set t_Co=256
colorscheme ir_black
set number
set title
set showcmd

let mapleader = ","
nnoremap <silent> <Leader><Space> :noh<Cr>
inoremap jj <Esc>
" save file with Ctrl+S in GUI
nmap <C-S> :w<Cr>

" most common vertical movement in wrapped lines
" for other commands, prepend 'g' ex. g$
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" buffers
nnoremap <C-N> :bnext<Cr>

" add '(x)' at the beginning of the todo's line
map <F2> 0xxxi(+)<Esc>j0
" run a spellchecker
map <F3> :call SetSpell()<Cr>
map <F4> :call SetFoldMethod()<Cr>

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

function SetSpell()
    if &spell
        set nospell
        echo "No spell checking"
    else
        set spell
        echo "Spell checking"
    endif
endfunction

function SetFoldMethod()
    if &foldmethod == "manual"
        set foldmethod=indent
        echo "Foldmethod: indent"
    else
        set foldmethod=manual
        echo "Foldmethod: manual"
    endif
endfunction

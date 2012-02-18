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
colorscheme phd
set number
set title " show title
set showcmd

let mapleader = ","
nnoremap <silent> <Leader><Space> :noh<Cr>
inoremap jj <Esc>
" save file with Ctrl+S
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
set guioptions-=m " remove menu bar
set guioptions-=T " remove toolbar
set guifont=Monospace\ 12

" this is tricy because it resizes the window when 
" Vim is started from a terminal
"set lines=40
"set columns=84 " 80 + 4 lines that 'numbers' uses

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

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
colorscheme gruvbox
set background=dark
set number
set title
set showcmd

" most common vertical movement in wrapped lines
" for other commands, prepend 'g' ex. g$
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

inoremap jj <Esc>

" buffers and clipboards
nnoremap <C-N> :bnext<Cr>
vnoremap Y "+y

let mapleader = ","
nnoremap <silent> <Leader><Space> :noh<Cr>
nnoremap <Leader>c :CtrlP<Cr>
nnoremap <Leader>s :w<Cr>

nnoremap <F1>       :call BlogPost()<Cr>
nnoremap <F3>       :call SetSpell()<Cr>
nnoremap <F4>       :call SetFoldMethod()<Cr>
nmap     <leader>c  <Plug>FocusModeToggle
nnoremap <leader>m  :call KBFollowLink()<Cr>
nnoremap <leader>ev :vsplit $MYVIMRC<Cr>
nnoremap <leader>v  :source $MYVIMRC<Cr>

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

" All KB functions assume one is in the right KB folder
function! KBFollowLink()
    " search for a 12-digit ID in the current line
    let note_id = matchstr(getline('.'), '\d\{12}')
    if note_id != ""
        let filename = system("find . -name '*".note_id.".md'")
        execute "edit ".filename
        return 0
    endif

    " if you can't find an ID, search for a hashtag in the current line
    let tag = matchstr(getline('.'), '#\S\+')
    if tag != ""
        execute "vimgrep /" . tag . "/j *.md"
        execute "copen"
        return 0
    endif
endfunction

function! KBWhatLinksToHere()
    let note_id = matchstr(expand('%:t'), '\d\{12}')
    if note_id != ""
        execute "silent! vimgrep /" . note_id . "/j *.md"
        if len(getqflist()) != 0
            execute "copen"
        else
            echo "No other notes link to this note."
        endif
    else
        echo "Can't find the note ID in the name of the file."
    endif
endfun

augroup kbgroup
    autocmd!
    if exists("$KB_HOME")
        execute 'autocmd BufRead,BufNewFile "'.$KB_HOME.'/*" setlocal completefunc=KBComplete'
    endif
augroup END

fun! KBComplete(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        " is it a tag? #
        let start = match(line, '#')
        if start >= 0
            return start
        endif
        " is it an ID? [[
        let start = match(line, '@')
        if start >= 0
            return start
        endif
        return -3 " Negative return values: -3 To cancel silently and leave completion mode.
    else
        if a:base =~ '@' " match note IDs ...
            " match excluding the @ character and match anywhere in the line
            let matchstring = a:base[1:]
            let filename = '.noteids'
        elseif a:base =~ '#' " ... or match tags
            " match from the beginning including '#'
            let matchstring = '^' . a:base
            let filename = '.notetags'
        else " no match
            return []
        endif

        let res = []
        for line in readfile(filename)
            if line =~ matchstring
                call add(res, line)
            endif
        endfor
        return res
    endif
endfun

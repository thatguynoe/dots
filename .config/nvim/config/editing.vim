" Change mousescroll speed.
set mousescroll=ver:2,hor:2

set expandtab       " Use spaces, not tabs.
set tabstop=4       " Sets tabbing to 4 spaces.
set softtabstop=4   " A tab key indents 4 spaces.
set shiftwidth=4    " Sets normal mode tabbing to 4 spaces.

" Set smarter indentation.
set smartindent

" Turn off autoindentation.
filetype indent off

" Disable automatic comment insertion.
autocmd FileType * setlocal formatoptions-=cro

" Set spellchecker language.
set spelllang=en_us

" Enable folding.
set foldmethod=indent
set foldlevel=99

" Allow incrementing of letters.
set nrformats+=alpha

" Automatically remove trailing whitespace on save and reset cursor position.
function TrimWhiteSpace()
    let cursor_pos = getpos(".")
    %s/\s\+$//e
    call cursor(cursor_pos[1], cursor_pos[2])
endfunction

autocmd BufWritePre * call TrimWhiteSpace()

" Disable swap files.
set noswapfile

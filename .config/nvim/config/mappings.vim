" Remap leader.
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Exit terminal mode.
tnoremap <Esc> <C-\><C-n>

" Mapping for quitting quickly (and unmap Q for Ex mode).
nnoremap <silent> Q :qa!<cr>

" Keep selection after tabbing and remap <TAB> to tab.
vnoremap > >gv
vnoremap < <gv

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

nnoremap <Tab> >>
nnoremap <S-Tab> <<

" Easier navigation of continuous lines.
nnoremap <C-A-j> gj
nnoremap <C-A-k> gk

" Spellchecker mapping.
nnoremap <silent> <Leader>o :set spell!<cr>

" Mappings to navigate buffers.
nnoremap <silent> <Leader>b :ls<cr>:buffer<Space>
nnoremap <silent> <Leader>d :bdelete!<cr>

" Replace all mapping.
nnoremap <Leader>r :%s//g<Left><Left>

" Save mapping.
nnoremap <silent> <Leader>w :update<cr>

" Execute the compiler script.
nnoremap <silent> <Leader>f :update <bar> silent !compiler "%"<cr>

" Open output.
nnoremap <silent> <Leader>j :silent !opout "%"<cr>

" Easier navigation of splits.
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Easier resizing of splits.
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>

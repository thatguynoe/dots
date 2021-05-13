" Update and compile code in terminal.
nnoremap <buffer> <silent> <Leader>f :update <bar> !compiler "%" <cr>

" Execute code in terminal.
nnoremap <buffer> <silent> <Leader>j :10sp <bar> terminal ./"%:r".out <cr>
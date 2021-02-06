" Update and compile code in terminal.
nnoremap <buffer> <silent> <Leader>f :!compiler "%" <cr>

" Execute code in terminal.
nnoremap <buffer> <silent> <Leader>j :10sp <bar> terminal ./"%:r".out <cr>

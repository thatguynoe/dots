" Update and compile code in terminal.
nnoremap <buffer> <silent> <Leader>f :update <bar> !compiler "%" <cr>

" Execute code in terminal.
nnoremap <buffer> <silent> <Leader>j :call TerminalExec('./' . expand("%:r") . '.out')<cr>

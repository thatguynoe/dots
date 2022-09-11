" Update and execute code in terminal.
nnoremap <buffer> <silent> <Leader>f :update <bar> call TerminalExec('compiler ' . expand("%"))<cr>

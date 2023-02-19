" Runs a script that cleans out tex build files after exiting a tex file.
autocmd BufDelete,VimLeave *.tex silent! !texclear "%"

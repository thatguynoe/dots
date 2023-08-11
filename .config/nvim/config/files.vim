" Ensure files are read as what I want.
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff

" Ignore some filetypes.
set wildignore+=*.out,*.exe,*.pdf,*.doc*,*.aux

" Enable ZenMode by default for mutt and markdown writing.
autocmd VimEnter /tmp/neomutt*,*.md :ZenMode
autocmd BufRead,BufNewFile /tmp/neomutt*,*.md nnoremap <silent> ZZ :close <bar> x!<cr>

" When shortcut files are updated, update shortcuts with new material.
autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Automatically recompile suckless software on save.
autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/ ; sudo make install
autocmd BufWritePost ~/.local/src/st/config.h !cd ~/.local/src/st/ ; sudo make install
autocmd BufWritePost ~/.local/src/dmenu/config.h !cd ~/.local/src/dmenu/ ; sudo make install
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/ ; sudo make clean install && { killall -q dwmblocks ; setsid -f dwmblocks }

" Automatically source init.vim on save.
augroup reload_vimrc
    autocmd!
    autocmd! BufWritePost ~/.config/nvim/config/*.vim source $MYVIMRC | redraw! | redrawstatus!
augroup END

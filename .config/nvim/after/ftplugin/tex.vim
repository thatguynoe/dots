" Clean out tex build files after exiting a tex file using latexmk.
autocmd BufDelete,VimLeave *.tex silent! !latexmk -c "%"

" Mapping to replace only within math environments.
function! MathReplace(find, replace)
    execute 's/' . a:find . '/\=vimtex#syntax#in_mathzone() ? "' . a:replace . '" : submatch(0)/g'
endfunction

vnoremap <Leader>R :call MathReplace()<Left>

" Use omni as a completion source.
lua << END
require('cmp').setup.buffer({
 sources = {
   { name = 'nvim_lsp' },
   { name = 'luasnip' },
   { name = 'omni' },
   { name = 'buffer', keyword_length = 5 }
 }
})
END

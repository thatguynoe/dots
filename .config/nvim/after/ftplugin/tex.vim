" Runs a script that cleans out tex build files after exiting a tex file.
autocmd BufDelete,VimLeave *.tex silent! !texclear "%"

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

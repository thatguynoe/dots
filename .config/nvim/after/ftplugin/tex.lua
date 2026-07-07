-- Clean out tex build files after exiting a tex file using latexmk.
vim.api.nvim_create_autocmd({ 'BufDelete', 'VimLeave' }, {
  pattern = '*.tex',
  command = 'silent! !latexmk -c "%"',
})

-- Mapping to replace only within math environments.
local function math_replace(find, replace)
  vim.cmd(
    's/' .. find .. '/\\=vimtex#syntax#in_mathzone() ? "' .. replace .. '" : submatch(0)/g'
  )
end

-- Create a command so we don't pollute _G.
vim.api.nvim_buf_create_user_command(0, 'MathReplace', function(opts)
  math_replace(opts.fargs[1], opts.fargs[2])
end, { nargs = '+', range = true })

vim.keymap.set('v', '<Leader>R', ':MathReplace ', { buffer = true })

-- Use omni as a completion source.
require('cmp').setup.buffer({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'omni' },
    { name = 'buffer', keyword_length = 5 },
  },
})

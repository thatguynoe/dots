-- Toggle a terminal.
vim.keymap.set('n', '<Leader>t', '<cmd>ToggleTerm<cr>', { silent = true })

require('toggleterm').setup({
  size = 10,
  shade_terminals = false,
})

local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', opts)
  vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', opts)
  vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', opts)
  vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', opts)
end

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = set_terminal_keymaps,
})

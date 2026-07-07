require('oil').setup({
  columns = { { 'icon', add_padding = false } },
  float = { border = 'single', max_width = 0.8, max_height = 0.7 },
  confirmation = { border = 'single' },
  progress = { border = 'single' },
  ssh = { border = 'single' },
  keymaps_help = { border = 'single' },
})

vim.keymap.set('n', '<C-N>', function() require('oil').toggle_float() end, { silent = true })
vim.keymap.set('n', '<C-n>', function() require('oil').toggle_float('.') end, { silent = true })

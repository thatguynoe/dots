require('zen-mode').setup({
  window = {
    backdrop = 1,
    width = 84,
    height = 0.85,
  },

  plugins = {
    options = {
      -- turn off the statusline in zen mode
      laststatus = 0,
    },
    twilight = { enabled = false },
  },
})

-- Enter ZenMode.
vim.keymap.set('n', '<Leader>g', '<cmd>ZenMode<cr>', { silent = true })

-- Enable ZenMode by default for mutt and markdown writing.
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = { '/tmp/neomutt*', '*.md' },
  command = 'ZenMode',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '/tmp/neomutt*', '*.md' },
  callback = function()
    vim.keymap.set('n', 'ZZ', '<cmd>close <bar> x!<cr>', { buffer = true, silent = true })
  end,
})

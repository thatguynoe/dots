-- Change mousescroll speed.
vim.opt.mousescroll = 'ver:2,hor:2'

-- Use spaces, not tabs.
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Set smarter indentation.
vim.opt.smartindent = true

-- Turn off autoindentation.
-- vim.cmd('filetype indent off')

-- Disable automatic comment insertion.
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = '*',
--   callback = function()
--     vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
--   end,
-- })

-- Set spellchecker language.
vim.opt.spelllang = 'en_us'

-- Enable folding.
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

-- Allow incrementing of letters.
vim.opt.nrformats:append('alpha')

-- Automatically remove trailing whitespace on save and reset cursor position.
local function trim_whitespace()
  local view = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = trim_whitespace,
})

-- Disable swap files.
vim.opt.swapfile = false

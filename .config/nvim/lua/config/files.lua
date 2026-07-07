-- Ensure files are read as what I want.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '/tmp/calcurse*', '~/.calcurse/notes/*' },
  callback = function() vim.bo.filetype = 'markdown' end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.ms', '*.me', '*.mom', '*.man' },
  callback = function() vim.bo.filetype = 'groff' end,
})

-- Ignore some filetypes.
vim.opt.wildignore:append({ '*.out', '*.exe', '*.pdf', '*.doc*', '*.aux', '*.synctex.gz' })

-- When shortcut files are updated, update shortcuts with new material.
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'bm-files', 'bm-dirs' },
  command = '!shortcuts',
})

-- Automatically recompile suckless software on save.
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand('~') .. '/.local/src/dwm/config.h',
  command = '!cd ~/.local/src/dwm/ ; sudo make install',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand('~') .. '/.local/src/st/config.h',
  command = '!cd ~/.local/src/st/ ; sudo make install',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand('~') .. '/.local/src/dmenu/config.h',
  command = '!cd ~/.local/src/dmenu/ ; sudo make install',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand('~') .. '/.local/src/dwmblocks/config.h',
  command = '!cd ~/.local/src/dwmblocks/ ; sudo make clean install && { killall -q dwmblocks ; setsid -f dwmblocks >/dev/null 2>&1 }',
})

-- Automatically source init.lua on save.
local reload_group = vim.api.nvim_create_augroup('reload_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = reload_group,
  pattern = vim.fn.expand('~') .. '/.config/nvim/lua/config/*.lua',
  callback = function()
    vim.cmd('source ' .. vim.env.MYVIMRC)
    vim.cmd('redraw!')
  end,
  nested = true,
})

-- Automatically refresh snippets when editing.
local reload_snippets_group = vim.api.nvim_create_augroup('reload_snippets', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = reload_snippets_group,
  pattern = vim.fn.expand('~') .. '/.config/nvim/snippets/*.lua',
  callback = function()
    require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets/' })
  end,
})

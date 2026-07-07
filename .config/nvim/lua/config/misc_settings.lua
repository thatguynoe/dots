-- Enables global clipboard.
vim.opt.clipboard:append('unnamedplus')

-- Enable mouse support.
vim.opt.mouse = 'nvc'

-- Disable netrw (using oil.nvim instead).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Automatically disable search highlighting.
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    vim.opt.hlsearch = vim.tbl_contains({ 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
  end
end, vim.api.nvim_create_namespace('auto_hlsearch'))

-- Disable several language providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

-- Sync terminal background with colorscheme.
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then return end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

vim.api.nvim_create_autocmd('UILeave', {
  callback = function() io.write('\027]111\027\\') end,
})

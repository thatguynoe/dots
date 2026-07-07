-- Trigger a highlight in the appropriate direction when pressing these keys.
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

-- Modify colors.
vim.api.nvim_create_augroup('qs_colors', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'qs_colors',
  callback = function()
    vim.api.nvim_set_hl(0, 'QuickScopePrimary', { fg = '#5fffff', bold = true })
    vim.api.nvim_set_hl(0, 'QuickScopeSecondary', { fg = '#259e3d', bold = true })
  end,
})

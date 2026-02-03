lua << END
require("gruvbox").setup({
  italic = { strings = false },
  transparent_mode = true,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Markdown-specific heading highlights
    vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#fb4934', bg = '', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#fabd2f', bg = '', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = '#b8bb26', bg = '', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = '#8ec07c', bg = '', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = '#83a598', bg = '', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = '#d3869b', bg = '', bold = true })
  end,
})
END

colorscheme gruvbox

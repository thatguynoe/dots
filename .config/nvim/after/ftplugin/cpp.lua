-- Update, compile, and execute code in the terminal.
vim.keymap.set('n', '<Leader>f', '<cmd>update <bar> TermExec cmd="compiler %"<cr>', { buffer = true, silent = true })

local function is_mfem_buffer()
  return vim.fn.search([[#include\s\+"mfem\.hpp"]], 'nw') > 0
    or vim.fn.search([[using\s\+namespace\s\+mfem]], 'nw') > 0
end

local function set_mfem_indentation()
  if is_mfem_buffer() then
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 3
    vim.bo.tabstop = 3
  end
end

local function style_mfem()
  if is_mfem_buffer() and vim.fn.filereadable('.astylerc') == 1 then
    vim.cmd('!astyle --options=.astylerc "%"')
  end
end

-- Set indentation for the current buffer immediately.
set_mfem_indentation()

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.cpp', '*.hpp' },
  callback = set_mfem_indentation,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.cpp', '*.hpp' },
  callback = function()
    pcall(style_mfem)
  end,
})

-- Remap leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Exit terminal mode.
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Quit quickly (and unmap Q for Ex mode).
vim.keymap.set('n', 'Q', '<cmd>qa!<cr>', { silent = true })

-- Keep selection after tabbing.
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Easier navigation of continuous lines.
vim.keymap.set('n', '<C-A-j>', 'gj')
vim.keymap.set('n', '<C-A-k>', 'gk')

-- Spellchecker.
vim.keymap.set('n', '<Leader>o', ':set spell!<cr>', { silent = true })

-- Navigate between buffers.
vim.keymap.set('n', '<Leader>b', ':ls<cr>:buffer ', { silent = true })
vim.keymap.set('n', '<Leader>d', '<cmd>bdelete!<cr>', { silent = true })

-- Replace all.
vim.keymap.set('n', '<Leader>r', ':%s//g<Left><Left>')

-- Save file.
vim.keymap.set('n', '<Leader>w', '<cmd>update<cr>', { silent = true })

-- Execute the compiler script.
vim.keymap.set('n', '<Leader>f', '<cmd>update <bar> silent !compiler "%"<cr>', { silent = true })

-- Open output.
vim.keymap.set('n', '<Leader>j', '<cmd>silent !opout "%"<cr>', { silent = true })

-- Easier navigation of splits.
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')

-- Easier resizing of splits.
vim.keymap.set('n', '<Up>', '<C-w>+')
vim.keymap.set('n', '<Down>', '<C-w>-')
vim.keymap.set('n', '<Left>', '<C-w><')
vim.keymap.set('n', '<Right>', '<C-w>>')

-- Unmappings
pcall(vim.keymap.del, 'i', '<C-s>')

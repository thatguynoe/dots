-- Update and execute code in the terminal.
vim.keymap.set('n', '<Leader>f', '<cmd>update <bar> TermExec cmd="compiler %"<cr>', { buffer = true, silent = true })

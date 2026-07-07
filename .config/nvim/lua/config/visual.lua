-- Set cursor 4 lines away from the edges of the screen.
vim.opt.scrolloff = 4

-- Show relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Set sign column in number column.
vim.opt.signcolumn = 'no'

-- Set title.
vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)'

-- Enable linebreaking at words, not characters.
vim.opt.linebreak = true

-- Set horizontal splits to automatically open to the right and below.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Case-insensitive search unless capital letters are used.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Plugin hooks (must be defined BEFORE vim.pack.add)
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if kind ~= 'install' and kind ~= 'update' then return end

  -- Update treesitter
  if name == 'nvim-treesitter' then
    vim.cmd('TSUpdate')
  end

  -- Build jsregexp for LuaSnip
  if name == 'LuaSnip' then
    local dir = vim.fn.stdpath('data') .. '/site/pack/core/opt/LuaSnip'
    vim.fn.system({ 'make', '-C', dir, 'install_jsregexp' })
  end

  -- Compile telescope-fzf-native
  if name == 'telescope-fzf-native.nvim' then
    local dir = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
    vim.fn.system({ 'make', '-C', dir })
  end
end })

local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

-- Install and load all plugins
vim.pack.add({
  -- LSP & completion
  gh('neovim/nvim-lspconfig'),
  gh('hrsh7th/nvim-cmp'),
  gh('hrsh7th/cmp-nvim-lsp'),
  gh('hrsh7th/cmp-omni'),
  gh('hrsh7th/cmp-buffer'),
  cb('FelipeLema/cmp-async-path'),
  gh('jmbuhr/otter.nvim'),
  gh('kdheepak/cmp-latex-symbols'),
  { src = gh('L3MON4D3/LuaSnip'), version = vim.version.range('2.x') },
  gh('saadparwaiz1/cmp_luasnip'),

  -- Treesitter
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },

  -- Telescope
  gh('nvim-lua/plenary.nvim'),
  { src = gh('nvim-telescope/telescope.nvim'), version = 'master' },
  gh('nvim-telescope/telescope-fzf-native.nvim'),

  -- UI & editing
  gh('nvim-tree/nvim-web-devicons'),
  gh('stevearc/oil.nvim'),
  gh('lervag/vimtex'),
  gh('akinsho/toggleterm.nvim'),
  gh('nvim-lualine/lualine.nvim'),
  gh('jreybert/vimagit'),
  gh('tpope/vim-surround'),
  gh('folke/zen-mode.nvim'),
  gh('unblevable/quick-scope'),
  gh('ellisonleao/gruvbox.nvim'),
})

-- Configure plugins
require('config.plugins.nvim_cmp')
require('config.plugins.treesitter')
require('config.plugins.telescope')
require('config.plugins.vimtex')
require('config.plugins.toggleterm')
require('config.plugins.quickscope')
require('config.plugins.gruvbox')
require('config.plugins.lualine')
require('config.plugins.magit')
require('config.plugins.zenmode')
require('config.plugins.otter')
require('config.plugins.oil')
require('devicons-override')

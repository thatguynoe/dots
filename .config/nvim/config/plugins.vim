call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

Plug 'neovim/nvim-lspconfig'                                              " neovim LSP
Plug 'hrsh7th/nvim-cmp'                                                   " neovim autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-omni'                                                   " neovim omnicompletion
Plug 'hrsh7th/cmp-buffer'                                                 " neovim buffer completion
Plug 'L3MON4D3/LuaSnip', { 'tag': 'v2.*', 'do': 'make install_jsregexp' } " snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }             " syntax highlighting

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }               " file finder
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'lervag/vimtex'                                                      " better LaTeX support
Plug 'akinsho/toggleterm.nvim', { 'tag' : '*' }                           " comfy terminal
Plug 'nvim-lualine/lualine.nvim'                                          " statusline
Plug 'jreybert/vimagit'                                                   " git integration
Plug 'tpope/vim-surround'                                                 " better delimiter manipulation
Plug 'folke/zen-mode.nvim'                                                " distraction free editing
Plug 'unblevable/quick-scope'                                             " better line navigation
Plug 'psliwka/vim-smoothie'                                               " smooth scrolling
Plug 'ellisonleao/gruvbox.nvim'                                           " colorscheme

call plug#end()

source $XDG_CONFIG_HOME/nvim/config/plugins/nvim_cmp.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/treesitter.lua
source $XDG_CONFIG_HOME/nvim/config/plugins/nvim_telescope.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/vimtex.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/toggleterm.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/lualine.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/magit.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/zenmode.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/quickscope.vim
source $XDG_CONFIG_HOME/nvim/config/plugins/smoothie.vim

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

" NVIM CMP:
" Set completeopt to have a better completion experience.
set completeopt=menuone,noinsert,noselect

" TREESITTER:
lua << END
require("nvim-treesitter.configs").setup {
  ensure_installed = { "vim", "vimdoc", "c", "cpp", "lua", "python", "html" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  markdown_fenced_languages = { "c", "cpp", "python", "bash=sh" }
}
END

" NVIM TELESCOPE
nnoremap <silent> <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <Leader>fb <cmd>Telescope buffers<cr>

lua << END
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "pdf",
      "png",
      "docx",
      "doc",
      "mscz",
      "mp3",
      "xlsx",
      "jpeg"
    }
  }
}
END

" VIMTEX:
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 0
let g:vimtex_compiler_latexmk = { 'options' : [ '-synctex=0' ] }
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_env_toggle_math_map = {
    \ '$': 'equation*',
    \ '$$': 'equation*',
    \ '\(': '$',
    \}

" TOGGLETERM:
" Toggle a terminal.
nnoremap <silent> <Leader>t :ToggleTerm<cr>

lua << END
require("toggleterm").setup {
  size = 10,
  shade_terminals = false,
}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
END

" LUALINE:
" Disables -- INSERT -- and similar text in the command line.
set noshowmode

lua << END
-- Display 'MI' when both tab and spaces are used for indenting the current buffer.
function MixedIndent()
  local space_indent = vim.fn.search([[\v^ +]], 'nw') > 0
  local tab_indent = vim.fn.search([[\v^\t+]], 'nw') > 0
  local mixed = (space_indent and tab_indent)
                 or vim.fn.search([[\v^(\t+ | +\t)]], 'nw') > 0
  return mixed and 'MI' or ''
end

-- Display what 'spelllang' is set to when spellchecking is active.
function Spell()
  if not vim.wo.spell then
    return ''
  end
  return vim.api.nvim_get_option('spelllang')
end

require("lualine").setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
    section_separators = '',
    component_separators = '│'
  },
  sections = {
    lualine_c = {
       { 'filename', path = 1 },
       { Spell }
    },
    lualine_z = { 'location', MixedIndent },
  }
}
END

" MAGIT:
" Open magit.
nnoremap <silent> <Leader>m :Magit<cr>

" ZENMODE:
lua << END
  require("zen-mode").setup {
    window = {
      backdrop = 1,
      width = 80,
      height = 0.85,
    },

    -- Keep transparency
    on_open = function(win)
      vim.cmd[[highlight ZenBg guibg=NONE]]
    end,
  }
END

" Enter ZenMode.
nnoremap <silent> <Leader>g :ZenMode<cr>

" Enable ZenMode by default for mutt and markdown writing.
autocmd VimEnter /tmp/neomutt*,*.md :ZenMode
autocmd BufRead,BufNewFile /tmp/neomutt*,*.md nnoremap <silent> ZZ :close <bar> x!<cr>

" QUICKSCOPE:
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Modify colors.
augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#5fffff' gui=bold
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#259e3d' gui=bold
augroup END

" SMOOTHIE:
" Even smoother settings.
let g:smoothie_update_interval = 30
let g:smoothie_base_speed = 50

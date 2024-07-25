" Disables -- INSERT -- and similar text in the command line.
set noshowmode

" Enable a global statusline.
set laststatus=3

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
  },
  extensions = {
    'toggleterm'
  }
}
END

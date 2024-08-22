" Disables -- INSERT -- and similar text in the command line.
set noshowmode

" Enable a global statusline.
set laststatus=3

lua << END
-- Display 'MI' when both tab and spaces are used for indenting the current buffer.
function MixedIndent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
     return 'MI:'..mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:'..tab_indent
  else
    return 'MI:'..space_indent
  end
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
    theme = 'transparent',
    section_separators = '',
    component_separators = '',
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

-- Disables -- INSERT -- and similar text in the command line.
vim.opt.showmode = false

-- Enable a global statusline.
vim.opt.laststatus = 3

-- Make the statusline transparent.
vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })

-- Display 'MI' when both tab and spaces are used for indenting the current buffer.
-- Cached to avoid scanning the entire buffer on every statusline redraw.
local mixed_indent_cache = {}

local function compute_mixed_indent()
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
    return 'MI:' .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:' .. tab_indent
  else
    return 'MI:' .. space_indent
  end
end

vim.api.nvim_create_autocmd({ 'BufWritePost', 'TextChanged', 'BufEnter' }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    mixed_indent_cache[buf] = compute_mixed_indent()
  end,
})

-- Clean up cache when buffers are deleted.
vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(ev)
    mixed_indent_cache[ev.buf] = nil
  end,
})

local function MixedIndent()
  return mixed_indent_cache[vim.api.nvim_get_current_buf()] or ''
end

-- Display what 'spelllang' is set to when spellchecking is active.
local function Spell()
  if not vim.wo.spell then
    return ''
  end
  return vim.bo.spelllang
end

require('lualine').setup({
  options = {
    theme = 'transparent',
    section_separators = '',
    component_separators = '',
  },

  sections = {
    lualine_c = {
      { 'filename', path = 1 },
      { Spell },
    },
    lualine_z = { 'location', MixedIndent },
  },

  extensions = {
    'toggleterm',
    'oil',
  },
})

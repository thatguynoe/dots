local HOME = os.getenv('HOME')

-- Load snippets from the ~/.config/nvim/snippets/ directory for the corresponding language
require('luasnip.loaders.from_lua').lazy_load({
  paths = { HOME .. '/.config/nvim/snippets' },
})

-- Command to open the snippet file that belongs to the language you are editing
vim.api.nvim_create_user_command('SnippetsEdit', function()
  vim.cmd('e ~/.config/nvim/snippets/' .. vim.bo.filetype .. '.lua')
end, {})

local ls = require('luasnip')

ls.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  store_selection_keys = '<c-s>',

  -- Updates dynamic snippets as you type
  updateevents = 'TextChanged,TextChangedI',
  region_check_events = 'CursorMoved',
  delete_check_events = 'TextChanged',
})

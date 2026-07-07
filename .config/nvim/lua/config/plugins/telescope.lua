vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', { silent = true })
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<cr>', { silent = true })
vim.keymap.set('n', '<Leader>s', '<cmd>Telescope spell_suggest<cr>', { silent = true })

require('telescope').setup({
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    file_ignore_patterns = {
      '%.[Dd]ocx?$',
      '%.base$',
      '%.eps$',
      '%.jpe?g$',
      '%.mkv$',
      '%.mp[34]$',
      '%.mscz$',
      '%.o$',
      '%.pdf$',
      '%.png$',
      '%.svg$',
      '%.synctex%.gz$',
      '%.xlsx$',
      '%.zip$',
      '^%.git/[^h]',
    },
  },
})

require('telescope').load_extension('fzf')

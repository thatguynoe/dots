nnoremap <silent> <Leader>ff :Telescope find_files<cr>
nnoremap <silent> <Leader>fb :Telescope buffers ignore_current_buffer=true sort_mru=true<cr>
nnoremap <silent> <Leader>s :Telescope spell_suggest<cr>

lua << END
require('telescope').setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    file_ignore_patterns = {
      "%.pdf",
      "%.eps",
      "%.png",
      "%.jpe?g",
      "%.[Dd]ocx?",
      "%.mscz",
      "%.mp[34]",
      "%.xlsx",
      "%.base",
      "%.o",
      "%.zip",
      "^%.git/[^h]"
    },
    color_devicons = false,
  }
})
END

lua << END
require("oil").setup({
  float = { border = "single", max_width = 0.8, max_height = 0.7 },
  confirmation = { border = "single" },
  progress = { border = "single" },
  ssh = { border = "single" },
  keymaps_help = { border = "single" },
})
END

nnoremap <silent> <C-N> :lua require('oil').toggle_float()<cr>
nnoremap <silent> <C-n> :lua require('oil').toggle_float('.')<cr>

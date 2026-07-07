vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_forward_search_on_start = 0
vim.g.vimtex_view_zathura_use_synctex = 1
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_indent_enabled = 0

vim.g.vimtex_env_toggle_math_map = {
  ['$'] = 'equation*',
  ['$$'] = 'equation*',
  ['\\('] = '$',
}

vim.g.vimtex_toc_config = {
  name = 'Table of Contents',
  layer_status = {
    label = 0,
    include = 0,
  },
}

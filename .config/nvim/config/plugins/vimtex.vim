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

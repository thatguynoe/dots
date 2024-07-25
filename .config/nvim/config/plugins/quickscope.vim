" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Modify colors.
augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#5fffff' gui=bold
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#259e3d' gui=bold
augroup END

" Enables global clipboard.
set clipboard+=unnamedplus

" Enable mouse support.
set mouse=nvc

" Configure netrw.
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Automatically disable search highlighting.
lua << END
  vim.on_key(function(char)
    if vim.fn.mode() == "n" then
      vim.opt.hlsearch = vim.tbl_contains({ "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    end
  end, vim.api.nvim_create_namespace "auto_hlsearch")
END

" Disable python 3 and perl providers.
let g:loaded_python3_provider = 0
let g:loaded_perl_provider = 0

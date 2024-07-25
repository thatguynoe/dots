lua << END
  require("zen-mode").setup {
    window = {
      backdrop = 1,
      width = 80,
      height = 0.85,
    },

    plugins = {
      options = {
        -- turn off the statusline in zen mode
        laststatus = 0,
      },
    },

    -- Keep transparency
    on_open = function(win)
      vim.cmd[[highlight ZenBg guibg=NONE]]
    end,
  }
END

" Enter ZenMode.
nnoremap <silent> <Leader>g :ZenMode<cr>

" Enable ZenMode by default for mutt and markdown writing.
autocmd VimEnter /tmp/neomutt*,*.md :ZenMode
autocmd BufRead,BufNewFile /tmp/neomutt*,*.md nnoremap <silent> ZZ :close <bar> x!<cr>

require("nvim-treesitter.configs").setup {
  ensure_installed = { "vim", "vimdoc", "c", "cpp", "lua", "python", "html" },
  highlight = {
    enable = true,
  },
  indent = {
    disable = true,
    enable = { "lua" },
  },
  markdown_fenced_languages = { "c", "cpp", "python", "bash=sh" }
}

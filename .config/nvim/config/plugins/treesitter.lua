require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash", "c", "cpp", "html", "latex",
    "lua", "markdown", "markdown_inline",
    "python", "vim", "vimdoc"
  },
  highlight = {
    enable = true,
    disable = { "latex" }
  },
  indent = {
    disable = true,
    enable = { "lua" },
  },
  markdown_fenced_languages = { "bash=sh", "c", "cpp", "python" }
}

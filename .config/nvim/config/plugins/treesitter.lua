local ts = require('nvim-treesitter')

-- Install core parsers at startup
ts.install({
  "bash", "c", "cpp", "html", "doxygen", "latex", "lua", "markdown",
  "markdown_inline", "python", "vim", "vimdoc", "yaml"
})

local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

local ignore_filetypes = {
  'checkhealth',
}

local ignore_hl_filetypes = {
  'tex',
}

local allow_indent_filetypes = {
  'lua',
}

-- Auto-install parsers and enable highlighting on FileType
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  desc = 'Enable treesitter highlighting and indentation',
  callback = function(event)
    if vim.tbl_contains(ignore_filetypes, event.match) then
      return
    end

    local lang = vim.treesitter.language.get_lang(event.match) or event.match
    local buf = event.buf

    -- Start highlighting immediately (works if parser exists)
    if not vim.tbl_contains(ignore_hl_filetypes, event.match) then
      pcall(vim.treesitter.start, buf, lang)
    end

    -- Enable treesitter indentation
    if vim.tbl_contains(allow_indent_filetypes, event.match) then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    -- Install missing parsers (async, no-op if already installed)
    ts.install({ lang })
  end,
})

-- Set CmpItem colors in the completion window
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

local luasnip = require('luasnip')
local cmp = require('cmp')

local cmp_kinds = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = '  ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = ' ',
  Struct = '  ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

cmp.setup({
  -- Disable completion in comments
  enabled = function()
    return not require('cmp.config.context').in_syntax_group('Comment')
  end,

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'latex_symbols', option = { strategy = 1 } },
    { name = 'async_path' },
    { name = 'buffer', keyword_length = 5 },
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind

      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        omni = '[Omni]',
        buffer = '[Buffer]',
      })[entry.source.name]

      return vim_item
    end,
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered({
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    }),
    documentation = cmp.config.window.bordered({
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    }),
  },

  sorting = {
    comparators = {
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.order,
    },
  },

  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-k>'] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { 'i', 's' }),
  },
})

-- Global diagnostic configuration
local sev = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = {
    text = {
      [sev.ERROR] = '',
      [sev.WARN] = '',
      [sev.INFO] = '',
      [sev.HINT] = '',
    },
    numhl = {
      [sev.ERROR] = 'DiagnosticError',
      [sev.WARN] = 'DiagnosticWarn',
      [sev.INFO] = 'DiagnosticInfo',
      [sev.HINT] = 'DiagnosticHint',
    },
  },
})

-- Override floating window borders globally (once)
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts)
  opts = opts or {}
  opts.border = opts.border or 'single'
  return orig_open_floating_preview(contents, syntax, opts)
end

-- Buffer-local LSP keymaps via LspAttach autocmd
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufopts = { buffer = ev.buf, silent = true }
    local ts_builtin = require('telescope.builtin')

    -- Diagnostic mappings
    vim.keymap.set('n', '<Leader>a', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.setqflist, bufopts)

    -- LSP mappings
    vim.keymap.set('n', 'grd', ts_builtin.lsp_definitions, bufopts)
    vim.keymap.set('n', 'gri', ts_builtin.lsp_implementations, bufopts)
    vim.keymap.set('n', 'grt', ts_builtin.lsp_type_definitions, bufopts)
    vim.keymap.set('n', 'grr', ts_builtin.lsp_references, bufopts)
    vim.keymap.set('n', 'gO', ts_builtin.lsp_document_symbols, bufopts)
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Server configurations
for _, lsp in ipairs({ 'bashls', 'pyright' }) do
  vim.lsp.config[lsp] = {
    capabilities = capabilities,
  }
end

vim.lsp.config['clangd'] = {
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--offset-encoding=utf-16',
  },
}

vim.lsp.config['texlab'] = {
  capabilities = vim.tbl_extend('force', vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
      hover = { contentFormat = { 'plaintext' } },
      completion = { completionItem = { documentationFormat = { 'plaintext' } } },
    },
  }),
}

vim.lsp.enable({ 'bashls', 'pyright', 'clangd', 'texlab' })

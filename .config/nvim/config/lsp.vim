" Set CmpItem colors in the completion window
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! link CmpItemKindMethod CmpItemKindFunction
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link CmpItemKindProperty CmpItemKindKeyword
highlight! link CmpItemKindUnit CmpItemKindKeyword

lua << END
local luasnip = require("luasnip")
local cmp = require("cmp")
local telescope = require("telescope.builtin")

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
    return not require("cmp.config.context").in_syntax_group("Comment")
  end,

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'async_path' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'otter' }
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind

      -- Source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        omni = "[Omni]",
        buffer = "[Buffer]",
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
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    }),
    documentation = cmp.config.window.bordered({
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
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
    end, { "i", "s" }),
    ['<C-j>'] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
          luasnip.jump(-1)
      end
    end, { "i", "s" }),
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { "i", "s" }),
  },
})

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- Enable virtual text
  vim.diagnostic.config({ virtual_text = {current_line = true} })

  -- Diagnostic mappings
  vim.keymap.set('n', '<Leader>a', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<Leader>e', vim.diagnostic.setqflist, bufopts)

  -- LSP mappings
  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gR', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gI', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gA', vim.lsp.buf.code_action, bufopts)

  -- Override floating window borders globally
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts)
    opts = opts or {}
    opts.border = opts.border or "single"
    return orig_util_open_floating_preview(contents, syntax, opts)
  end

  -- Highlight line number instead of having icons in sign column
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
        [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
      },
    },
  })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'pyright' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

require('lspconfig').clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

require('lspconfig').texlab.setup {
  on_attach = on_attach,
  capabilities = vim.tbl_extend('force', vim.lsp.protocol.make_client_capabilities(), ({
    textDocument = {
      hover = { contentFormat = { "plaintext" } },
      completion = { completionItem = { documentationFormat = { "plaintext" } } }
    }
  })),
}
END

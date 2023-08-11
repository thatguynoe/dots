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

lua << EOF
  local luasnip = require("luasnip")
  local cmp = require("cmp")

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
    enabled = function()
      -- Disable completion in comments
      return not require("cmp.config.context").in_syntax_group("Comment")
    end,

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
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    sorting = {
        comparators = {
            cmp.config.compare.recently_used,
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
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer', keyword_length = 5 }
    }
  })

  local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    -- No virtual text for diagnostics
    vim.diagnostic.config({
      virtual_text = false
    })

    -- Open diagnostic, and go to next and previous diagnostics
    vim.keymap.set('n', '<Leader>a', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, bufopts)

    -- LSP Mappings
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'texlab' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
EOF

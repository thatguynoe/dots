lua << EOF
  local luasnip = require("luasnip")
  local cmp = require("cmp")

  cmp.setup({
    enabled = function()
      -- Disable completion in comments
      return not require("cmp.config.context").in_syntax_group("Comment")
    end,

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
      { name = 'luasnip' }
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

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'texlab' }
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

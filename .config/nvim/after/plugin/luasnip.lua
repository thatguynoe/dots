local luasnip = require "luasnip"

luasnip.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- Updates dynamic snippets as you type
    updateevents = "TextChanged,TextChangedI",
}

-- luasnip.parser.parse_snippet(<text>, <VS****> style snippet>)
luasnip.add_snippets(nil, {
    tex = {
        -- LaTeX specific snippets go here.
        luasnip.parser.parse_snippet("b", "\\begin{$1}\n    $0\n\\end{$1}"),
    },

    markdown = {
        -- Markdown specific snippets go here.
        luasnip.parser.parse_snippet("**", "**$1** $0"),
        luasnip.parser.parse_snippet("*", "*$1* $0"),
    },
})

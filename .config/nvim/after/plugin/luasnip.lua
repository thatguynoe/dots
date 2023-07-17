HOME = os.getenv("HOME")

-- load snippets from the ~/.config/nvim/snippets/ directory for the corresponding language
require("luasnip/loaders/from_snipmate").lazy_load({
    path = {HOME .. "/.config/nvim/snippets"}
})

-- command to open the snippet file that belongs to the language you are editing
vim.cmd([[
function SnippetsEdit()
    execute ":e ~/.config/nvim/snippets/" . &filetype . ".snippets"
endfunction
command! SnippetsEdit call SnippetsEdit()
]])

local ls = require("luasnip")

ls.config.set_config({
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    store_selection_keys = "<c-s>",

    -- Updates dynamic snippets as you type
    updateevents = "TextChanged,TextChangedI",
    region_check_events = "CursorMoved",
    delete_check_events = "TextChanged"
})

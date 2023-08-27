local ls = require("luasnip")

return {
    -- Bold text
    s({ trig = "**", name = "Bold", dscr = "Insert bold text" },
      fmt("**{}** {}", { i(1), i(0) })
    ),

    -- Italic text
    s({ trig = "*", name = "Italic", dscr = "Insert italic text" },
      fmt("*{}* {}", { i(1), i(0) })
    ),
}

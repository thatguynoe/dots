local ls = require("luasnip")

local helpers = require('luasnip_helper_funcs')
local get_visual = helpers.get_visual

local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
    -- Begin/end environment
    s({ trig = "bb", name = "\\begin ... \\end block", dscr = "Expands 'bb' into a block" },
      fmta(
         [[
           \begin{<>}
               <>
           \end{<>}
         ]],
         { i(1, "environment"), d(2, get_visual), rep(1) }
      )
    ),

    -- Fraction
    s({ trig = "ff", name = "Fraction", dscr = "Insert a fraction" },
      fmta("\\frac{<>}{<>}", { i(1), i(2) }),
      { condition = in_mathzone }
    ),

    -- Integral
    s({ trig = "ii", name = "Integral", dscr = "Insert an integral" },
      fmta("\\int_<>^<> <>", {
          c(1, {
            t(""),
            fmta("{<>}", { i(1) })
          }),
          c(2, {
            t(""),
            fmta("{<>}", { i(1) })
          }),
          i(0)
        }
      ),
      { condition = in_mathzone }
    ),

    -- Math text
    s({ trig = "tt", name = "Text", dscr = "Insert text in a math environment" },
      fmta("\\text{<>}", { d(1, get_visual) }),
      { condition = in_mathzone }
    ),

    -- Bold text
    s({ trig = "bf", name = "Bold", dscr = "Insert bold text" },
      fmta("\\textbf{<>}", { d(1, get_visual) })
    ),

    -- Italic text
    s({ trig = "it", name = "Italic", dscr = "Insert italic text" },
      fmta("\\textit{<>}", { d(1, get_visual) })
    ),

    -- Slanted text
    s({ trig = "sl", name = "Slanted", dscr = "Insert slanted text" },
      fmta("\\textsl{<>}", { d(1, get_visual) })
    ),

    -- Small caps text
    s({ trig = "sc", name = "Small caps", dscr = "Insert small caps text" },
      fmta("\\textsc{<>}", { d(1, get_visual) })
    ),
}

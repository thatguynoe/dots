local otter = require("otter")

otter.setup({
	set_filetype = true,
})

local languages = { "bash", "c", "cpp", "python" }

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.md" },
	callback = function()
    otter.activate(languages, true, false)
	end,
})

require("nvchad.options")

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.diagnostic.config({
	virtual_text = false,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
		-- require("lint").try_lint("cspell")
	end,
})
-- o.foldmethod = "indent"

require("luasnip").filetype_extend("javascript", { "javascriptreact" })
require("luasnip").filetype_extend("javascript", { "html" })
require("luasnip").filetype_extend("python", { "django" })

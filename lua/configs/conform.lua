local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		python = { "isort", "black" },
		cpp = { "astyle" },
		c = { "astyle" },
		cs = { "csharpier" },
		go = { "goimports", "goimports-reviser", "gofmt" },
		php = { "php_cs_fixer" },
	},

	format_on_save = {
		timeout_ms = 5000,
		lsp_fallback = true,
	},
}

require("conform").setup(options)

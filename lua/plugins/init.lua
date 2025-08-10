return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = {
			size = 20, -- You can adjust this to your liking
			open_mapping = [[<c-\>]], -- The key mapping to open the terminal
			direction = "float", -- Set the direction to float
			float_opts = {
				border = "curved", -- You can set the border style ('single', 'double', 'rounded', 'solid', 'shadow')
				winblend = 7, -- Set the transparency level (0-100)
			},
		},
		lazy = false,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
	},
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			-- dap.setup()
			dapui.setup()
			-- javascript google chrome
			dap.adapters.chrome = {
				type = "executable",
				command = "node",
				args = { os.getenv("HOME") .. "/.local/share/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
			}

			dap.configurations.javascriptreact = { -- change this to javascript if needed
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
			}
			dap.configurations.typescriptreact = { -- change to typescript if needed
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
			}

			-- dap-ui
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- keymaps
			vim.keymap.set("n", "<F5>", dap.continue(), {})
			vim.keymap.set("n", "<F10>", dap.step_over(), {})
			vim.keymap.set("n", "<F11>", dap.step_into(), {})
			vim.keymap.set("n", "<F12>", dap.step_out(), {})
			vim.keymap.set("n", "<Leader>tb", dap.toggle_breakpoint(), {})
			vim.keymap.set("n", "<Leader>sb", dap.set_breakpoint(), {})
			vim.keymap.set("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")), {})
			vim.keymap.set("n", "<Leader>dr", dap.repl.open(), {})
			vim.keymap.set("n", "<Leader>dl", dap.run_last(), {})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("configs.conform")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"html",
				"cssls",
				"tsserver",
				"tailwindcss",
				-- "eslint",
				"pyre",
				"ruff_lsp",
				"gopls",
				"golangci_lint_ls",
				"templ",
				"clangd",
				"lua-language-server",
				"stylua",
				"typescript-language-server",
				"tailwindcss-language-server",
				"html-lsp",
				"css-lsp",
				"prettierd",
				"gopls",
				"golangci-lint-langserver",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"go",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"mbbill/undotree",
		lazy = false,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = true, -- "Name" codes like Blue or blue
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "background", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = true, -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false,
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
		opts = {},
		lazy = false,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			{
				---Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = "gcc",
					---Block-comment toggle keymap
					block = "gbc",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = "gc",
					---Block-comment keymap
					block = "gb",
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					above = "gcO",
					---Add comment on the line below
					below = "gco",
					---Add comment at the end of line
					eol = "gcA",
				},
				---Enable keybindings
				---NOTE
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				---Function to call before (un)comment
				pre_hook = nil,
				-- pre_hook = require("nvim_ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				---Function to call after (un)comment
				post_hook = nil,
			},
		},
		lazy = false,
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		opts = {},
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
	-- lazy.nvim:
	-- {
	-- 	"smoka7/multicursors.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"smoka7/hydra.nvim",
	-- 	},
	-- 	opts = {},
	-- 	cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
	-- 	keys = {
	-- 		{
	-- 			mode = { "v", "n" },
	-- 			"<Leader>m",
	-- 			"<cmd>MCstart<cr>",
	-- 			desc = "Create a selection for selected text or word under the cursor",
	-- 		},
	-- 	},
	-- },
	{
		"lewis6991/impatient.nvim",
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				lua = { "luacheck" },
				markdown = { "vale" },
				-- python = { "pylint" },
				cpp = { "cpplint", "cppcheck", "clangtidy" },
				make = { "checkmake" },
			}
		end,
	},
}

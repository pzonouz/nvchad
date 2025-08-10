-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "djlsp",
  "tailwindcss",
  "gopls",
  "golangci_lint_ls",
  "templ",
  "clangd",
  "marksman",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- C#
lspconfig.omnisharp.setup({
  settings = {
    omnisharp = {
      useModernNet = true, -- Optional: Use modern .NET SDK
    },
  },
  cmd = { "/usr/bin/omnisharp" }, -- Replace with your OmniSharp executable path
  filetypes = { "cs" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern("*.sln", "*.csproj")(fname) or lspconfig.util.path.dirname(fname)
  end,
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

--emmet
lspconfig.emmet_language_server.setup({
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
  },
  lspconfig.pyright.setup({
    filetypes = { "python" },
  }),

  --emmet
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
})

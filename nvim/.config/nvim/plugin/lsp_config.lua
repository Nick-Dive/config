--require'lspconfig'.terraform_lsp.setup{}
require'lspconfig'.lua_ls.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyright.setup{}

--This is should be after lsp setup
require("lsp_lines").setup()
vim.keymap.set(
  "",
  "<Leader>L",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)

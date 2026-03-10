return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({ "eslint", "lua_ls", "nixd", "ruff", "ty" })
  end,
}

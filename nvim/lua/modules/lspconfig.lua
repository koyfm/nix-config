return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
    vim.lsp.enable("lua_ls")
  end,
}

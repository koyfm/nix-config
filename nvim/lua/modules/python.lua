return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
  end
}

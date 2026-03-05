return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.lsp.enable("copilot")
    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
  end
}

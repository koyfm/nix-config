return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
    vim.lsp.enable("lua_ls")
  end
}

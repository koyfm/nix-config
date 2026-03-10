require("config")

local spec = {}

if _G["telescopeNativeFzf"] then
  table.insert(spec, { "nvim-telescope/telescope-fzf-native.nvim", enabled = true })
end

if _G["disableMason"] then
  table.insert(spec, { "williamboman/mason-lspconfig.nvim", enabled = false })
  table.insert(spec, { "williamboman/mason.nvim", enabled = false })
end

table.insert(spec, { import = "modules" })

require("lazy").setup({
  spec = spec,
})

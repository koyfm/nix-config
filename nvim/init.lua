require("config")

local spec = {}

if _G["disableMason"] then
  table.insert(spec, { "williamboman/mason-lspconfig.nvim", enabled = false })
  table.insert(spec, { "williamboman/mason.nvim", enabled = false })
end

table.insert(spec, { import = "modules" })

require("lazy").setup({
  spec = spec,
})

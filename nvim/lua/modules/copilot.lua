return {
  "zbirenbaum/copilot.lua",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  }
}

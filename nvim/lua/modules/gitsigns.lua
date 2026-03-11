return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Git hunk")
      map("n", "<leader>gr", gitsigns.reset_hunk, "Reset Git hunk")
      map("n", "<leader>gS", gitsigns.stage_buffer, "Stage Git buffer")
      map("n", "<leader>gR", gitsigns.reset_buffer, "Reset Git buffer")
      map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Git hunk")
      map("n", "<leader>gi", gitsigns.preview_hunk_inline, "Preview Git hunk inline")
      map("n", "<leader>gb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame Git line")
      map("n", "<leader>gd", gitsigns.diffthis, "Diff this Git file")
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Git hunk text object")
    end,
  },
}

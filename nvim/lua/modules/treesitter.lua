return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          if not pcall(vim.treesitter.start) then
            return
          end

          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"

          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      local function map(t, k, to, desc)
        if t == "select" then
          vim.keymap.set({ "x", "o" }, k, function()
            require("nvim-treesitter-textobjects.select").select_textobject(to, "textobjects")
          end, { desc = desc })
        elseif t == "goto_next" then
          vim.keymap.set({ "n", "x", "o" }, k, function()
            require("nvim-treesitter-textobjects.move").goto_next(to, "textobjects")
          end, { desc = desc })
        elseif t == "goto_previous" then
          vim.keymap.set({ "n", "x", "o" }, k, function()
            require("nvim-treesitter-textobjects.move").goto_previous(to, "textobjects")
          end, { desc = desc })
        end
      end

      map("select", "aa", "@parameter.outer", "parameter")
      map("select", "ia", "@parameter.inner", "inner parameter")
      map("select", "am", "@function.outer", "function")
      map("select", "im", "@function.inner", "inner function")
      map("select", "ac", "@class.outer", "class")
      map("select", "ic", "@class.inner", "inner class")

      map("goto_next", "]a", "@parameter.outer", "Next parameter")
      map("goto_previous", "[a", "@parameter.outer", "Previous parameter")
      map("goto_next", "]m", "@function.outer", "Next function")
      map("goto_previous", "[m", "@function.outer", "Previous function")
    end,
  },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      -- https://github.com/nvim-lualine/lualine.nvim/issues/1322
      component_separators = '|',
    },
    sections = {
      lualine_c = {
        {
          'buffers',
          show_filename_only = true
        }
      }
    }
  }
}

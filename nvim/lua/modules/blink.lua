return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<Tab>'] = {
        'select_next',
        function()
          return require("sidekick").nes_jump_or_apply()
        end,
        'fallback',
      },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },
    cmdline = {
      keymap = {
        ['<Tab>'] = { 'show', 'accept' },
      },
      completion = {
        ghost_text = { enabled = true },
        menu = { auto_show = true },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}

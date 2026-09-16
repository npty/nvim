-- user/plugins_always.lua
-- Plugins that load at startup in every environment

return {
  -- Core plugins that enhance Vim functionality
  'tpope/vim-fugitive', -- Git integration
  'tpope/vim-rhubarb', -- GitHub integration

  -- Navigation and editing improvements
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Better text objects

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- Other always-loaded plugins from your config
  'ojroques/vim-oscyank',
  'rust-lang/rust.vim',
  '0xmovses/move.vim',
}

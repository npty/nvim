-- user/plugins_always.lua
-- Plugins that should load in both regular Neovim and VSCode

return {
  -- Core plugins that enhance Vim functionality in any environment
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive', -- Git integration
  'tpope/vim-rhubarb', -- GitHub integration

  -- Navigation and editing improvements useful in any environment
  'gpanders/editorconfig.nvim', -- EditorConfig support
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
  -- Mini.nvim modules that are useful in any environment
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Only load the modules that make sense in any environment
      require('mini.ai').setup { n_lines = 500 } -- Better text objects
    end,
  },

  -- Other always-loaded plugins from your config
  'ojroques/vim-oscyank',
  'rust-lang/rust.vim',
  '0xmovses/move.vim',
}

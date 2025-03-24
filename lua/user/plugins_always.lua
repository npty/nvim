-- user/plugins_always.lua
-- Plugins that should load in both regular Neovim and VSCode

return {
  -- Core plugins that enhance Vim functionality in any environment
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive', -- Git integration
  'tpope/vim-rhubarb', -- GitHub integration

  -- Navigation and editing improvements useful in any environment
  'gpanders/editorconfig.nvim', -- EditorConfig support
  'kylechui/nvim-surround', -- Surround text objects

  -- Minimal text editing enhancements that don't require UI
  'windwp/nvim-autopairs', -- Auto-pair brackets, quotes, etc.
  'wakatime/vim-wakatime',

  -- Mini.nvim modules that are useful in any environment
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Only load the modules that make sense in any environment
      require('mini.ai').setup { n_lines = 500 } -- Better text objects
      require('mini.surround').setup() -- Surround functionality
    end,
  },

  -- TreeSitter for better syntax highlighting and text objects
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'javascript',
        'typescript',
        'tsx',
        'json',
        'rust',
        'solidity',
        'toml',
        'diff',
        'html',
        'lua',
        'markdown',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby', 'javascript', 'typescript', 'rust', 'json', 'markdown', 'yaml' } },
    },
  },

  -- TreeSitter text objects for better code navigation
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- Other always-loaded plugins from your config
  {
    'sheerun/vim-polyglot',
  },
  'ojroques/vim-oscyank',
  'rust-lang/rust.vim',
  '0xmovses/move.vim',
}

-- user/plugins_vscode.lua
-- Plugins that should only load in VSCode

return {
  -- VSCode-specific integrations
  -- These are typically minimal since VSCode handles most functionality

  -- Mini modules that help in VSCode but don't duplicate VSCode functionality
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Only load modules that make sense in VSCode and don't conflict
      require('mini.ai').setup { n_lines = 500 } -- Text objects enhancement
      require('mini.surround').setup() -- Surround functionality that can work in VSCode
    end,
  },

  -- Any other VSCode-specific plugins you might want to add
  -- Usually this list will be quite small since VSCode provides most functionality
}

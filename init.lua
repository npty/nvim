-- Load environment variables
local env = require 'custom/env'
env.load_env()
env.check_required_env()

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set up environment variables
vim.env.MYVIMRC = vim.fn.expand '~/.config/nvim/init.lua'
-- Limit the size of typescript server
vim.env.TSS_MAX_MEMORY = env.get_env 'TSS_MAX_MEMORY' or '4096'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Plugins that should load regardless of environment
  { import = 'user.plugins_always' },

  -- Plugins that should only load in regular Neovim (not in VSCode)
  {
    import = 'user.plugins_notvscode',
    cond = function()
      return not vim.g.vscode
    end,
  },

  -- Plugins to load only in VSCode
  {
    import = 'user.plugins_vscode',
    cond = function()
      return vim.g.vscode
    end,
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- After lazy setup, configure plugins only outside VSCode
if not vim.g.vscode then
  require 'config.options'
  -- Set colorscheme
  vim.cmd.colorscheme 'neofusion'

  -- Setup all plugins
  require('custom.post_setup').setup()

  require('config.keymaps').setup()
end

if vim.g.vscode then
  require('custom.setup_vscode').setup()
end

-- Support code snippet for markdown
vim.g.markdown_fenced_languages = { 'json', 'javascript', 'typescript', 'rust', 'bash=sh' }

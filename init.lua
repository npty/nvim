-- Load environment variables
require('custom.env').load_env()
require('custom.env').check_required_env()
local env = require 'custom.env'

vim.env.MYVIMRC = vim.fn.expand '~/.config/nvim/init.lua'

require 'config.options'

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

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
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
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
  -- Set colorscheme
  vim.cmd.colorscheme 'neofusion'

  -- Setup all plugins
  require('custom.post_setup').setup()
end

if vim.g.vscode then
  require('custom.setup_vscode').setup()
end

require('config.keymaps').setup()

-- Support code snippet for markdown
vim.g.markdown_fenced_languages = { 'json', 'javascript', 'typescript', 'rust', 'bash=sh' }

-- Toggle Completion
local cmp_toggle_flag = true
function _G.toggle_completion()
  if cmp_toggle_flag then
    require('cmp').setup.buffer { enabled = false }
    print 'Completion disabled'
  else
    require('cmp').setup.buffer { enabled = true }
    print 'Completion enabled'
  end
  cmp_toggle_flag = not cmp_toggle_flag
end

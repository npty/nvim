-- custom/post_setup.lua
-- This file contains configurations that should be run after plugins are loaded

local M = {}

function M.setup()
  -- Only execute these configurations outside of VSCode
  if vim.g.vscode then
    return
  end

  -- Configure Octo.nvim
  -- require('octo').setup {
  --   suppress_missing_scope = {
  --     projects_v2 = true,
  --   },
  -- }

  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.move',
    command = 'set filetype=move',
  })

  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.prisma',
    command = 'set filetype=prisma',
  })
end

return M

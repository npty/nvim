local M = {}

function M.setup()
  -- Keymaps for normal mode
  -- Set leader key (should be done early in your init.lua before loading plugins)
  -- vim.g.mapleader = ' '
  -- vim.g.maplocalleader = ' '

  -- Clear highlights on search when pressing <Esc> in normal mode
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic keymaps
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode with Esc Esc
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Disable arrow keys in normal mode
  vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- NvimTree Toggle
  vim.api.nvim_set_keymap('n', '<C-m>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

  -- Split management
  vim.api.nvim_set_keymap('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true })

  -- Tab management
  vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })

  -- Insert mode escape
  vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

  -- Git browser
  vim.api.nvim_set_keymap('n', '<leader>gh', ':GBrowse<CR>', { noremap = true, silent = true })

  -- Toggle completion
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
  vim.api.nvim_set_keymap('n', '<leader>tc', ':lua toggle_completion()<CR>', { noremap = true, silent = true })

  -- Toggle Diff View
  vim.api.nvim_set_keymap('n', '<leader>dv', ':DiffviewOpen<CR>', { noremap = true, silent = true })

  -- Osc Yank
  vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
  vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
  vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')

  -- Folding
  vim.keymap.set('n', '<leader>A', '<cmd>set foldmethod?^foldmethod<CR>', { desc = 'set or clear the current foldmethod' })

  -- Add missing imports
  vim.api.nvim_set_keymap(
    'n',
    '<leader>ai',
    '<cmd>lua vim.lsp.buf.code_action({context = {only = {"source.addMissingImports"}}, apply = true})<CR>',
    { noremap = true, silent = true }
  )

  -- Clear notifications
  vim.keymap.set('n', '<leader>nd', function()
    require('notify').dismiss { silent = true, pending = true }
    vim.cmd 'Noice dismiss' -- Clear noice notifications
  end, { desc = 'Clear notifications' })

  -- Toggle aerial
  vim.keymap.set('n', '<leader>l', '<cmd>AerialToggle!<CR>')

  -- Twilight
  vim.api.nvim_set_keymap('n', '<leader>tw', ':Twilight<CR>', { noremap = true, silent = true })

  -- Set the keymaps with larger resize steps
  vim.api.nvim_set_keymap('n', '<C-w>>', '10<C-w>>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-w><', '10<C-w><', { noremap = true })

  -- Noice history
  vim.keymap.set('n', '<leader>nh', ':Noice history<CR>', { desc = 'Noice History' })
  vim.keymap.set('n', '<leader>nd', ':Noice dismiss<CR>', { desc = 'Dismiss All' })

  -- Theme switcher
  vim.keymap.set('n', '<leader>th', '<cmd>Telescope colorscheme enable_preview=true<CR>', { desc = 'Theme switcher' })

  -- Treesitter context
  vim.keymap.set('n', '[c', function()
    require('treesitter-context').go_to_context()
  end, { silent = true, desc = 'Go to context' })

  -- Reload nvim config
  vim.keymap.set('n', '<leader>sr', ':Lazy reload *<CR>', { silent = true, desc = 'Reload config' })

  -- Avante
  vim.api.nvim_set_keymap('n', '<leader>aX', ':AC<CR>', { noremap = true, silent = true, desc = 'Clear Avante conversation' })
  vim.api.nvim_set_keymap('n', '<leader>ac', ':AvanteClear<CR>', { noremap = true, silent = true, desc = 'Clear Avante conversation' })

  -- Nvim Spectre Keymaps
  vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = 'Toggle Spectre',
  })
  vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = 'Search current word',
  })
  vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = 'Search current word',
  })
  vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = 'Search on current file',
  })

  -- Auto suggestion function signature
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { silent = true })
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { silent = true })
end

return M

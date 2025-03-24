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
  vim.keymap.set('n', '<C-m>', function()
    Snacks.explorer()
  end, { desc = 'Toggle Explorer' })
  -- Open explorer focused on current file
  vim.keymap.set('n', '<leader>E', function()
    Snacks.explorer.reveal()
  end, { desc = 'Explorer (Current File)' })

  -- Split management
  vim.api.nvim_set_keymap('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true })

  -- Tab management
  vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })

  -- Insert mode escape
  vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

  -- Trouble keymaps
  local trouble_keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  }

  for _, keymap in ipairs(trouble_keys) do
    vim.keymap.set('n', keymap[1], keymap[2], { desc = keymap.desc })
  end

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

  -- ========================================
  -- Snacks.notifier Keymaps
  -- ========================================

  -- Check if Snacks.notifier is available
  local snacks_available, snacks = pcall(require, 'snacks')
  if snacks_available then
    -- Show notification history (overrides Noice history)
    vim.keymap.set('n', '<leader>nh', function()
      snacks.notifier.show_history()
    end, { desc = '[N]otification [H]istory' })

    -- Clear all notifications (overrides the Noice dismiss)
    vim.keymap.set('n', '<leader>nd', function()
      -- Loop through all active notifications and hide them
      local history = snacks.notifier.get_history()
      for _, notif in ipairs(history) do
        if not notif.hidden then
          snacks.notifier.hide(notif.id)
        end
      end
    end, { desc = '[N]otification [D]ismiss All' })

    -- Filter notifications by level
    vim.keymap.set('n', '<leader>ne', function()
      snacks.notifier.show_history { filter = 'error' }
    end, { desc = '[N]otification [E]rrors Only' })

    vim.keymap.set('n', '<leader>nw', function()
      snacks.notifier.show_history { filter = 'warn' }
    end, { desc = '[N]otification [W]arnings Only' })

    -- Create a test notification (useful for testing styles)
    vim.keymap.set('n', '<leader>nt', function()
      snacks.notifier.notify("This is a test notification with ID 'test'", 'info', {
        title = 'Test Notification',
        id = 'test',
      })
    end, { desc = '[N]otification [T]est' })

    -- Update the test notification (demonstrates replacing notifications)
    vim.keymap.set('n', '<leader>nu', function()
      snacks.notifier.notify('This notification replaced the previous test notification', 'warn', {
        title = 'Updated Notification',
        id = 'test', -- Same ID as the test notification to replace it
      })
    end, { desc = '[N]otification [U]pdate Test' })
  end

  -- Toggle aerial
  vim.keymap.set('n', '<leader>l', '<cmd>AerialToggle!<CR>')

  -- Twilight
  vim.api.nvim_set_keymap('n', '<leader>tw', ':Twilight<CR>', { noremap = true, silent = true })

  -- Set the keymaps with larger resize steps
  vim.api.nvim_set_keymap('n', '<C-w>>', '10<C-w>>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-w><', '10<C-w><', { noremap = true })

  -- Noice history
  -- vim.keymap.set('n', '<leader>nh', ':Noice history<CR>', { desc = 'Noice History' })
  -- vim.keymap.set('n', '<leader>nd', ':Noice dismiss<CR>', { desc = 'Dismiss All' })

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

  -- Snacks picker
  --
  vim.keymap.set('n', '<leader>sh', function()
    Snacks.picker.help()
  end, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', function()
    Snacks.picker.keymaps()
  end, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', function()
    Snacks.picker.files()
  end, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', function()
    Snacks.picker.pickers()
  end, { desc = '[S]earch [S]elect Pickers' })
  vim.keymap.set('n', '<leader>sw', function()
    Snacks.picker.grep_word()
  end, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', function()
    Snacks.picker.grep { live = true }
  end, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', function()
    Snacks.picker.diagnostics()
  end, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', function()
    Snacks.picker.resume()
  end, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>rf', function()
    Snacks.picker.recent()
  end, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>', function()
    Snacks.picker.buffers()
  end, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>dg', function()
    Snacks.picker.git_diff()
  end, { desc = 'Git Diff (Hunks)' })
  vim.keymap.set('n', '<leader>gl', function()
    Snacks.picker.git_log()
  end, { desc = 'Git Log' })

  -- Slightly advanced example - current buffer search
  vim.keymap.set('n', '<leader>/', function()
    -- Snacks implementation of current buffer fuzzy find
    Snacks.picker.lines {
      layout = {
        preset = 'vscode', -- similar to dropdown in telescope
      },
    }
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- Searching in open files
  vim.keymap.set('n', '<leader>s/', function()
    Snacks.picker.grep_buffers {
      prompt = 'Live Grep in Open Files', -- equivalent to prompt_title
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- LSP KEYBINDINGS
  -- This function will be used in your LspAttach autocmd
  local function setup_lsp_keymaps(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Replace Telescope LSP functions with Snacks
    map('gd', function()
      -- Configure lsp_definitions to immediately jump when there's only one result
      Snacks.picker.lsp_definitions {
        unique_lines = true,
      }
    end, '[G]oto [D]efinition')
    map('gr', function()
      Snacks.picker.lsp_references()
    end, '[G]oto [R]eferences')
    map('gI', function()
      Snacks.picker.lsp_implementations()
    end, '[G]oto [I]mplementation')
    map('<leader>D', function()
      Snacks.picker.lsp_type_definitions()
    end, 'Type [D]efinition')
    map('<leader>ds', function()
      Snacks.picker.lsp_symbols()
    end, '[D]ocument [S]ymbols')
    map('<leader>ws', function()
      Snacks.picker.lsp_workspace_symbols()
    end, '[W]orkspace [S]ymbols')

    -- Keep the same non-picker LSP bindings
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Keep the rest of your LSP setup (document highlighting, etc.)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end

  -- Use this function in your LspAttach autocmd to set up the keymaps:
  --
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = setup_lsp_keymaps,
  })

  -- Additional useful Snacks keymaps you might want to add:
  vim.keymap.set('n', '<leader>u', function()
    Snacks.picker.undo()
  end, { desc = 'Undo History' })
  vim.keymap.set('n', '<leader>m', function()
    Snacks.picker.marks()
  end, { desc = 'Jump to Mark' })
  vim.keymap.set('n', '<leader>gb', function()
    Snacks.picker.git_branches()
  end, { desc = 'Git Branches' })
end

return M

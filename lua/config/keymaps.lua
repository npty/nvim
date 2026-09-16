local M = {}

function M.setup()
  -- Keymaps for normal mode
  -- Set leader key (should be done early in your init.lua before loading plugins)
  -- vim.g.mapleader = ' '
  -- vim.g.maplocalleader = ' '

  -- Snacks is optional here: if it is missing (disabled or failed to install) the
  -- snacks keymaps are skipped instead of aborting the rest of setup.
  local has_snacks, snacks = pcall(require, 'snacks')

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

  -- Save
  vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })

  if has_snacks then
    -- File Explorer
    vim.keymap.set('n', '<C-m>', function()
      snacks.explorer()
    end, { desc = 'Toggle Explorer' })
    -- Open explorer focused on current file
    vim.keymap.set('n', '<leader>E', function()
      snacks.explorer.reveal()
    end, { desc = 'Explorer (Current File)' })

    -- Lazygit
    vim.keymap.set('n', '<leader>gg', function()
      snacks.lazygit()
    end, { desc = 'Toggle Lazygit' })

    -- Terminal
    vim.keymap.set('n', '<leader>tt', function()
      snacks.terminal()
    end, { desc = 'Toggle Terminal' })

    -- Git
    vim.keymap.set('n', '<leader>bl', function()
      snacks.git.blame_line()
    end, { desc = 'Git Blame Line' })
  end

  -- Split management
  vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { desc = 'Vertical Split' })
  vim.keymap.set('n', '<leader>hs', ':split<CR>', { desc = 'Horizontal Split' })

  local function navigate_pane(direction, tmux_direction)
    local current_win = vim.api.nvim_get_current_win()
    vim.cmd('wincmd ' .. direction)

    if vim.api.nvim_get_current_win() ~= current_win then
      return
    end

    local ok, tmux = pcall(require, 'custom.tmux')
    if not ok then
      return
    end

    local command = tmux.command('select-pane -' .. tmux_direction)
    if command then
      vim.fn.system(command)
    end
  end

  local function navigate_terminal_pane(direction, tmux_direction)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
    vim.schedule(function()
      navigate_pane(direction, tmux_direction)
    end)
  end

  -- Pane focus: Neovim's windows get the key first, tmux only if no window was left to move to.
  for _, pane in ipairs {
    { dir = 'h', tmux = 'L', desc = 'Move to left pane' },
    { dir = 'j', tmux = 'D', desc = 'Move to lower pane' },
    { dir = 'k', tmux = 'U', desc = 'Move to upper pane' },
    { dir = 'l', tmux = 'R', desc = 'Move to right pane' },
  } do
    vim.keymap.set('n', '<C-' .. pane.dir .. '>', function()
      navigate_pane(pane.dir, pane.tmux)
    end, { desc = pane.desc })
    vim.keymap.set('t', '<C-' .. pane.dir .. '>', function()
      navigate_terminal_pane(pane.dir, pane.tmux)
    end, { desc = pane.desc })
  end

  -- Tab management
  vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { desc = 'New Tab' })

  -- Insert mode escape
  vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape Insert Mode' })

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
  vim.keymap.set('n', '<leader>gh', ':GBrowse<CR>', { desc = 'Git Browse' })

  -- Osc Yank
  vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
  vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
  vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')

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

  if has_snacks then
    -- Show notification history
    vim.keymap.set('n', '<leader>nh', function()
      snacks.notifier.show_history()
    end, { desc = '[N]otification [H]istory' })

    -- Clear all notifications
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
  end

  -- Set the keymaps with larger resize steps
  vim.api.nvim_set_keymap('n', '<C-w>>', '10<C-w>>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-w><', '10<C-w><', { noremap = true })

  -- Treesitter context. '[c' belongs to the class textobject, so the context jump
  -- sits on the free sibling '[C'.
  vim.keymap.set('n', '[C', function()
    require('treesitter-context').go_to_context()
  end, { silent = true, desc = 'Go to context' })

  -- Auto suggestion function signature
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, { silent = true, desc = 'Signature Help' })
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { silent = true })

  -- Snacks picker
  --
  if has_snacks then
    vim.keymap.set('n', '<leader>sh', function()
      snacks.picker.help()
    end, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', function()
      snacks.picker.keymaps()
    end, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      snacks.picker.files()
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', function()
      snacks.picker.pickers()
    end, { desc = '[S]earch [S]elect Pickers' })
    vim.keymap.set('n', '<leader>sw', function()
      snacks.picker.grep_word()
    end, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', function()
      snacks.picker.grep { live = true }
    end, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>st', function()
      snacks.picker.grep { live = true, ft = { 'ts' } }
    end, { desc = '[S]earch by [G]rep Typescript' })
    vim.keymap.set('n', '<leader>sj', function()
      snacks.picker.grep { live = true, ft = { 'json' } }
    end, { desc = '[S]earch by [G]rep JSON' })
    vim.keymap.set('n', '<leader>sd', function()
      snacks.picker.diagnostics()
    end, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', function()
      snacks.picker.resume()
    end, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>rf', function()
      snacks.picker.recent()
    end, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', function()
      snacks.picker.buffers()
    end, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>dg', function()
      snacks.picker.git_diff()
    end, { desc = 'Git Diff (Hunks)' })
    vim.keymap.set('n', '<leader>gl', function()
      snacks.picker.git_log()
    end, { desc = 'Git Log' })

    -- Slightly advanced example - current buffer search
    vim.keymap.set('n', '<leader>/', function()
      -- Snacks implementation of current buffer fuzzy find
      snacks.picker.lines {
        layout = {
          preset = 'vscode', -- similar to dropdown in telescope
        },
      }
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Searching in open files
    vim.keymap.set('n', '<leader>s/', function()
      snacks.picker.grep_buffers {
        prompt = 'Live Grep in Open Files', -- equivalent to prompt_title
      }
    end, { desc = '[S]earch [/] in Open Files' })
  end

  -- LSP KEYBINDINGS
  -- This function will be used in your LspAttach autocmd
  local function setup_lsp_keymaps(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Replace Telescope LSP functions with Snacks
    if has_snacks then
      map('gd', function()
        -- Configure lsp_definitions to immediately jump when there's only one result
        snacks.picker.lsp_definitions {
          unique_lines = true,
        }
      end, '[G]oto [D]efinition')
      map('gr', function()
        snacks.picker.lsp_references()
      end, '[G]oto [R]eferences')
      map('gI', function()
        snacks.picker.lsp_implementations()
      end, '[G]oto [I]mplementation')
      map('<leader>D', function()
        snacks.picker.lsp_type_definitions()
      end, 'Type [D]efinition')
      map('<leader>ds', function()
        snacks.picker.lsp_symbols()
      end, '[D]ocument [S]ymbols')
    end

    -- Keep the same non-picker LSP bindings
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Keep the rest of your LSP setup (document highlighting, etc.)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
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

  if has_snacks then
    vim.keymap.set('n', '<leader>u', function()
      snacks.picker.undo()
    end, { desc = 'Undo History' })
    vim.keymap.set('n', '<leader>m', function()
      snacks.picker.marks()
    end, { desc = 'Jump to Mark' })
    vim.keymap.set('n', '<leader>gb', function()
      snacks.picker.git_branches()
    end, { desc = 'Git Branches' })
  end
end

return M

-- General vim options, global variables, and environment variables

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.g.loaded_perl_provider = 0

-- Setup font for neovide
vim.o.guifont = 'PragmataProMonoLiga Nerd Font:h16:#e-subpixelantialias:#h-none'

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Ignore files for better memory usage
vim.opt.wildignore:append {
  'node_modules/*',
  'dist/*',
  'build/*',
  '*.min.js',
  '*.d.ts',
  '*/node_modules/*',
  '*/.git/*',
  '*/target/*',
  '*/dist/*',
  '*/build/*',
}

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time to optimize find files
vim.opt.updatetime = 500
vim.opt.redrawtime = 1500
vim.opt.hidden = true

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- -- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = 'screen'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldenable = false
vim.wo.foldlevel = 99

vim.g.rust_fold = 1

--- 'enable modeline'
vim.opt.modeline = true
vim.opt.modelines = 5

-- Filetypes kept free of visible diagnostics. Entries marked `treesitter` also
-- have treesitter stopped for the buffer.
local quiet_diagnostic_filetypes = {
  typescript = {},
  typescriptreact = {},
  markdown = { treesitter = true },
  yaml = { treesitter = true },
}

local function quiet_diagnostics(bufnr)
  local quiet = quiet_diagnostic_filetypes[vim.bo[bufnr].filetype]
  if not quiet then
    return
  end

  vim.diagnostic.enable(false, { bufnr = bufnr })

  if quiet.treesitter then
    vim.api.nvim_buf_call(bufnr, function()
      pcall(vim.treesitter.stop)
    end)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_call(bufnr, function()
          pcall(vim.treesitter.stop)
        end)
      end
    end)
  end
end

vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'LspAttach', 'DiagnosticChanged' }, {
  desc = 'Keep TS/Markdown/YAML buffers free of visible diagnostics',
  callback = function(args)
    quiet_diagnostics(args.buf)
  end,
})

if vim.fn.executable('pbcopy') == 1 and vim.fn.executable('pbpaste') == 1 then
  vim.g.clipboard = {
    name = 'macOS',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = false,
  }
else
  -- Use tmux as a fallback clipboard provider only when Neovim can reach the
  -- current tmux socket.
  local tmux = require('custom.tmux')
  local tmux_load_buffer = tmux.command('load-buffer -w -')
  local tmux_save_buffer = tmux.command('save-buffer -')

  if tmux_load_buffer and tmux_save_buffer then
    vim.g.clipboard = {
      name = 'tmux',
      copy = {
        ['+'] = tmux_load_buffer,
        ['*'] = tmux_load_buffer,
      },
      paste = {
        ['+'] = tmux_save_buffer,
        ['*'] = tmux_save_buffer,
      },
      cache_enabled = true,
    }
  end
end

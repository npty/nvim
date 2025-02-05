-- Load environment variables
require('custom.env').load_env()
local env = require 'custom.env'

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- Limit the size of typescript server
vim.env.TSS_MAX_MEMORY = env.get_env 'TSS_MAX_MEMORY' or '4096'

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
--  Schedule the setting after `UiEnter` because it can increase startup-time.
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
}

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time to optimize find files
vim.opt.updatetime = 500
vim.opt.timeoutlen = 500
vim.opt.redrawtime = 1500
vim.opt.hidden = true
vim.opt.wildignore = vim.opt.wildignore + {
  '*/node_modules/*',
  '*/.git/*',
  '*/target/*',
  '*/dist/*',
  '*/build/*',
}

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

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
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
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive',
  'tpope/vim-markdown',
  'sheerun/vim-polyglot',
  'ojroques/vim-oscyank',
  'rust-lang/rust.vim',
  'gpanders/editorconfig.nvim',
  'nvim-pack/nvim-spectre',
  'prettier/vim-prettier',
  -- 'github/copilot.vim',
  'sindrets/diffview.nvim',
  '0xmovses/move.vim',
  'ThePrimeagen/vim-be-good',
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
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
    },
  },

  { -- Treesitter textobjects for better code navigation
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['as'] = '@statement.outer',
              ['is'] = '@statement.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']c'] = '@class.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[c'] = '@class.outer',
            },
          },
        },
      }
    end,
  },

  { -- Enhanced UI for messages, cmdline and popups
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      notify = {
        -- Set notify as the backend for vim.notify
        enabled = true,
        view = 'notify',
        opts = {
          background_colour = '#000000',
        },
      },
    },
  },

  { -- Show code context at the top of the buffer
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 3,
        patterns = {
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
          },
          typescript = {
            'class_declaration',
            'abstract_class_declaration',
            'interface_declaration',
            'function_declaration',
          },
          rust = {
            'impl_item',
            'struct',
            'enum',
            'function',
          },
        },
      }
    end,
  },
  -- Add code companions for deepseek
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          deepseek = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                url = 'https://api.deepseek.com',
                api_key = env.get 'DEEPSEEK_API_KEY',
              },
            })
          end,
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = 'https://ollama.npty.online',
              },
              headers = {
                ['Content-Type'] = 'application/json',
              },
              parameters = {
                sync = true,
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = 'deepseek' },
          inline = { adapter = 'deepseek' },
          agent = { adapter = 'ollama' },
        },
      }
    end,
  },
  -- 'neoclide/coc.nvim',
  {
    'folke/twilight.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'aserowy/tmux.nvim',
    config = function()
      return require('tmux').setup()
    end,
  },
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },
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
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        suppress_missing_scope = {
          projects_v2 = true,
        },
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
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- configuration goes here
      --- type lc.lang
      lang = 'typescript',
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        color = {
          suggestion_color = '#C1FFC1',
          cterm = 244,
        },
      }
    end,
  },
  'nvim-tree/nvim-tree.lua',
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,
    opts = {
      open_mapping = [[<c-\>]],
      shade_terminals = true,
      shading_factor = -80,
      float_opts = {
        border = 'curved',
        winblend = 3,
        highlights = {
          border = 'Normal',
          background = 'NormalFloat',
        },
      },
    },
  },
  {
    'yetone/avante.nvim',
    build = 'make',
    lazy = false,
    version = false,
    init = function()
      -- Set up highlights
      vim.api.nvim_set_hl(0, 'MiniPickNormal', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { bg = '#3c3836', fg = '#ebdbb2' })
      vim.api.nvim_set_hl(0, 'MiniPickPrompt', { link = 'Title' })
      vim.api.nvim_set_hl(0, 'MiniPickBorder', { link = 'FloatBorder' })
      vim.api.nvim_set_hl(0, 'MiniPickPreview', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'MiniPickSelection', { bg = '#504945' })
    end,
    opts = {
      -- add any opts here
      provider = 'openai',
      file_selector = {
        provider = 'mini.pick',
        mini_pick = {
          options = {
            use_icons = true,
          },
        },
      },
      auto_suggestions_provider = 'openai', -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      openai = {
        endpoint = 'https://api.deepseek.com/v1',
        model = 'deepseek-chat',
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
        -- optional
        api_key_name = 'DEEPSEEK_API_KEY', -- default OPENAI_API_KEY if not set
      },
      vendors = {
        groq = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'deepseek-r1-distill-llama-70b',
        },
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage Hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset Hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = 'Blame Line' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'Diff This' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'Diff This ~' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle Deleted' })
      end,
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',

    event = 'VeryLazy',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--ignore',
            '--no-heading',
            '--with-filename',
            '--smart-case',
            '--line-number',
            '--column',
          },
          file_sorter = require('telescope.sorters').get_fuzzy_file,
          generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
          file_ignore_patterns = {
            'node_modules',
            '.git',
            'target',
            'dist',
          },
          cache_picker = {
            num_pickers = 5,
            limit_entries = 1000,
          },
        },
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        pickers = {
          find_files = {
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '--glob',
              '!**/.git/*',
              '--glob',
              '!**/node_modules/*',
              '--glob',
              '!**/dist/*',
              '--glob',
              '!**/target/*',
              '--smart-case',
            },
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          aerial = {
            -- How to format the symbols
            format_symbol = function(symbol_path, filetype)
              if filetype == 'json' or filetype == 'yaml' then
                return table.concat(symbol_path, '.')
              else
                return symbol_path[#symbol_path]
              end
            end,
            -- Available modes: symbols, lines, both
            show_columns = 'both',
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'aerial')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        ts_ls = {},

        solidity_ls = {},

        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
                -- Configure Python path to your system-wide Python
                pythonPath = '/usr/bin/python3',
                -- Diagnostic settings
                diagnosticSeverityOverrides = {
                  reportMissingImports = 'warning',
                  reportMissingModuleSource = 'warning',
                },
              },
            },
          },
        },

        move_analyzer = {},

        eslint = {},

        tailwindcss = {},

        jsonls = {},

        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
          },
        },

        marksman = {},

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier', stop_after_first = true },
        typescript = { 'prettier', stop_after_first = true },
        typescriptreact = { 'prettier', stop_after_first = true },
        rust = { 'rustfmt', lsp_format = 'fallback' },
        html = { 'prettier', stop_after_first = true },
        markdown = { 'prettier', stop_after_first = true },
        yaml = { 'prettier', stop_after_first = true },
        json = { 'prettier', stop_after_first = true },
        shell = { 'shfmt', lsp_format = 'fallback' },

        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        prettier = {
          -- This tells prettier to look for a local config file
          prepend_args = { '--config-precedence', 'prefer-file' },
          cwd = function(ctx)
            return vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h')
          end,
        },
        injected = {
          options = {
            -- Set individual option values
            ignore_errors = true,
            lang_to_ext = {
              bash = 'sh',
              json = 'json',
              javascript = 'js',
              markdown = 'md',
              python = 'py',
              rust = 'rs',
              typescript = 'ts',
              typescriptreact = 'tsx',
            },
            lang_to_formatters = {},
          },
        },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-c>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'supermaven' },
          { name = 'buffer' },
        },
      }
    end,
  },
  --
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    lazy = false,
  },
  { 'diegoulloao/neofusion.nvim', priority = 1000, config = true, lazy = false },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
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
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby', 'javascript', 'typescript', 'rust', 'json', 'markdown', 'yaml' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
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

require('custom.env').check_required_env()

-- vim.g.copilot_assume_mapped = true
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- -- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = 'screen'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require('nvim-tree').setup {
  view = {
    width = 50,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  -- Disable notifications if they're bothering you
  notify = {
    threshold = vim.log.levels.ERROR, -- Only show error level notifications
  },
}
-- require('bufferline').setup {}
vim.api.nvim_set_keymap('n', '<C-m>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Vertical split
vim.api.nvim_set_keymap('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true })

-- Horizontal split
vim.api.nvim_set_keymap('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
--
-- This line creates a mapping in insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- vim.api.nvim_set_keymap('i', '<M-f>', '<Right>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<M-b>', '<Left>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<M-p>', '<Up>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<M-n>', '<Down>', { noremap = true, silent = true })
--
-- Git Browse
vim.api.nvim_set_keymap('n', '<leader>gh', ':GBrowse<CR>', { noremap = true, silent = true })

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

vim.api.nvim_set_keymap('n', '<leader>tc', ':lua toggle_completion()<CR>', { noremap = true, silent = true })

-- Toggle Diff View
vim.api.nvim_set_keymap('n', '<leader>dv', ':DiffviewOpen<CR>', { noremap = true, silent = true })

-- GP Which Key
require('which-key').add {
  -- VISUAL mode mappings
  -- s, x, v modes are handled the same way by which_key
  {
    mode = { 'v' },
    nowait = true,
    remap = false,
    { '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = 'ChatNew tabnew' },
    { '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'ChatNew vsplit' },
    { '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", desc = 'ChatNew split' },
    { '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
    { '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
    { '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
    { '<C-g>g', group = 'generate into new ..' },
    { '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
    { '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
    { '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
    { '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },
    { '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
    { '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
    { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
    { '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
    { '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
    { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
    { '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
    { '<C-g>w', group = 'Whisper' },
    { '<C-g>wa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append' },
    { '<C-g>wb', ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = 'Whisper Prepend' },
    { '<C-g>we', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
    { '<C-g>wn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
    { '<C-g>wp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
    { '<C-g>wr', ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = 'Whisper Rewrite' },
    { '<C-g>wt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
    { '<C-g>wv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
    { '<C-g>ww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
    { '<C-g>x', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },
  },

  -- NORMAL mode mappings
  {
    mode = { 'n' },
    nowait = true,
    remap = false,
    { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
    { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
    { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
    { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
    { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
    { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
    { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
    { '<C-g>g', group = 'generate into new ..' },
    { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
    { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
    { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
    { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
    { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
    { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
    { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
    { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
    { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
    { '<C-g>w', group = 'Whisper' },
    { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
    { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
    { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
    { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
    { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
    { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
    { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
    { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
    { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
    { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
  },

  -- INSERT mode mappings
  {
    mode = { 'i' },
    nowait = true,
    remap = false,
    { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
    { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
    { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
    { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
    { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
    { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
    { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
    { '<C-g>g', group = 'generate into new ..' },
    { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
    { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
    { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
    { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
    { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
    { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
    { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
    { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
    { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
    { '<C-g>w', group = 'Whisper' },
    { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
    { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
    { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
    { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
    { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
    { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
    { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
    { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
    { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
    { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
  },
}

-- Osc Yank
vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
vim.keymap.set('n', '<leader>cc', '<leader>c_', { remap = true })
vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')

-- Folding
vim.keymap.set('n', '<leader>A', '<cmd>set foldmethod?^foldmethod<CR>', { desc = 'set or clear the current foldmethod' })
vim.g.rust_fold = 1

-- color scheme
vim.cmd.colorscheme 'tokyonight-storm'

--- 'enable modeline'
vim.opt.modeline = true
vim.opt.modelines = 5

-- Add missing imports
vim.api.nvim_set_keymap(
  'n',
  '<leader>ai',
  '<cmd>lua vim.lsp.buf.code_action({context = {only = {"source.addMissingImports"}}, apply = true})<CR>',
  { noremap = true, silent = true }
)

-- Trying to fix OSCYank issue in tmux
vim.g.clipboard = {
  name = 'tmux',
  copy = {
    ['+'] = 'tmux load-buffer -w -',
    ['*'] = 'tmux load-buffer -w -',
  },
  paste = {
    ['+'] = 'tmux save-buffer -',
    ['*'] = 'tmux save-buffer -',
  },
  cache_enabled = true,
}

-- Lua indentation
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
  end,
})

-- Reload nvim config
function ReloadConfig()
  -- Clear and reload all Lua modules
  for name, _ in pairs(package.loaded) do
    if name:match '^user' or name:match '^plugins' then
      package.loaded[name] = nil
    end
  end

  -- Re-initialize lazy.nvim
  require('lazy').sync()

  -- Reload your main configuration file
  dofile(vim.env.MYVIMRC)

  -- Notify the user
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end

-- Support code snippet for markdown
vim.g.markdown_fenced_languages = { 'json', 'javascript', 'typescript', 'rust', 'bash=sh' }

-- Disable Enter to toggle the nvim-tree
-- vim.api.nvim_set_keymap('n', '<CR>', '<CR>', { noremap = true })

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

-- For Supermaven suggestion
vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#E6E6FA' })

-- Setup For Aerial
require('aerial').setup {
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end,
}

require('notify').setup {
  background_colour = '#000000',
  merge_duplicates = true,
}

require('nvim-tree').setup {
  view = {
    width = 50,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  on_attach = function(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
    vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
    vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'Copy Name')
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts 'Copy Relative Path')
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts 'Copy Absolute Path')
  end,
}

-- Clear notifications
vim.keymap.set('n', '<leader>nd', function()
  require('notify').dismiss { silent = true, pending = true }
  vim.cmd 'Noice dismiss' -- Clear noice notifications
end, { desc = 'Clear notifications' })

-- You probably also want to set a keymap to toggle aerial
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

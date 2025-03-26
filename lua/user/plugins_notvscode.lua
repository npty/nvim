-- ~/.config/nvim/lua/user/plugins_notvscode.lua
-- Plugins for regular Neovim only (not in VSCode)
--
require('./custom.env').load_env()

return {
  -- UI enhancements (only make sense in regular Neovim)
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'diegoulloao/neofusion.nvim',
    priority = 1000,
    config = true,
    lazy = false,
    opts = {
      transparent_mode = true,
    },
  },

  {
    'folke/snacks.nvim',
    opts = {
      notifier = {},
      picker = {
        sources = {
          files = {
            ignored = true, -- Show ignored files (false by default)
            hidden = true, -- Show hidden files
            exclude = {
              'node_modules',
              '.git',
              'target',
              'dist',
              '%.svg$',
              '.*cache.*%.json$',
              '%.lock$',
            },
          },
          grep = {
            -- Configure grep to match your telescope vimgrep_arguments
            args = {
              '--color=never',
              '--ignore',
              '--no-heading',
              '--with-filename',
              '--smart-case',
              '--line-number',
              '--column',
            },
          },
          explorer = {
            tree = true, -- Show files in a tree view
            watch = true, -- Watch for file changes
            diagnostics = true, -- Show diagnostics
            git_status = true, -- Show git status
            git_untracked = false, -- Show untracked files
            -- UI configuration
            focus = 'list', -- Focus the file list instead of the input when opening
            auto_close = false, -- Don't auto-close when focusing another window
            jump = { close = false }, -- Don't close explorer when jumping to a file
            -- Format configuration
            formatters = {
              file = { filename_only = true }, -- Only show filename, not full path
              severity = { pos = 'right' }, -- Show diagnostics on the right
            },
            -- Filtering & sorting
            matcher = {
              sort_empty = false, -- Don't sort when filter is empty
              fuzzy = false, -- Don't use fuzzy matching
            },
            -- Layout configuration
            layout = {
              preset = 'sidebar', -- Use sidebar layout
              preview = false, -- Don't show preview initially
            },
            -- Key mappings for the explorer
            win = {
              list = {
                keys = {
                  -- Navigation
                  ['<BS>'] = 'explorer_up', -- Go up a directory
                  ['l'] = 'confirm', -- Open file/directory
                  ['h'] = 'explorer_close', -- Close directory
                  ['.'] = 'explorer_focus', -- Focus current file in explorer
                  -- File operations
                  ['a'] = 'explorer_add', -- Add new file/directory
                  ['d'] = 'explorer_del', -- Delete file/directory
                  ['r'] = 'explorer_rename', -- Rename file/directory
                  ['c'] = 'explorer_copy', -- Copy file
                  ['m'] = 'explorer_move', -- Move file
                  ['o'] = 'explorer_open', -- Open with system application
                  ['P'] = 'toggle_preview', -- Toggle preview
                  ['y'] = { 'explorer_yank', mode = { 'n', 'x' } }, -- Yank filepath
                  ['p'] = 'explorer_paste', -- Paste file
                  ['u'] = 'explorer_update', -- Update/refresh view
                  -- Navigation and filters
                  ['<c-c>'] = 'tcd', -- Change directory
                  ['<leader>/'] = 'picker_grep', -- Grep in directory
                  ['<c-t>'] = 'terminal', -- Open terminal in directory
                  ['I'] = 'toggle_ignored', -- Toggle ignored files
                  ['H'] = 'toggle_hidden', -- Toggle hidden files
                  ['Z'] = 'explorer_close_all', -- Close all directories
                  -- Diagnostics & git navigation
                  [']g'] = 'explorer_git_next', -- Next git change
                  ['[g'] = 'explorer_git_prev', -- Previous git change
                  [']d'] = 'explorer_diagnostic_next', -- Next diagnostic
                  ['[d'] = 'explorer_diagnostic_prev', -- Previous diagnostic
                },
              },
            },
          },
        },
        -- Use vim.ui.select implementation
        ui_select = true,

        -- Configure the fuzzy matching
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          sort_empty = true,
          filename_bonus = true,
          cwd_bonus = true,
        },
      },
      explorer = {
        replace_netrw = true,
      },
    },
  },

  -- Status line (doesn't work in VSCode)
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Additional mini modules for non-VSCode environment
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Mini pick for file selection
      local height = math.floor(vim.o.lines * 0.7)
      local width = math.floor(vim.o.columns * 0.7)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      require('mini.pick').setup {
        window = {
          config = {
            height = height,
            width = width,
            row = row,
            col = col,
            border = 'rounded',
          },
        },
      }
    end,
  },

  -- File explorer and navigation
  -- 'nvim-tree/nvim-tree.lua',

  -- LSP and completion (doesn't make sense in VSCode)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
  },

  -- Auto-completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
  },

  -- Formatting
  {
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

  -- Telescope for fuzzy finding (UI-dependent)
  -- {
  --   'nvim-telescope/telescope.nvim',
  --   event = 'VimEnter',
  --   branch = '0.1.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --     { 'nvim-telescope/telescope-ui-select.nvim' },
  --     { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  --   },
  -- },

  -- Debugging tools
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'mxsdev/nvim-dap-vscode-js',
    },
  },

  -- UI enhancements
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
  },

  -- Enhanced UI for messages, cmdline and popups
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --     'rcarriga/nvim-notify',
  --   },
  -- },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Code context at the top of the buffer
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
  },

  -- Terminal integration
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

  -- Which key to show keybindings
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Code AI tools
  {
    'yetone/avante.nvim',
    build = 'make',
    lazy = false,
    version = false,
    init = function()
      vim.api.nvim_set_hl(0, 'MiniPickNormal', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { bg = '#3c3836', fg = '#ebdbb2' })
      vim.api.nvim_set_hl(0, 'MiniPickPrompt', { link = 'Title' })
      vim.api.nvim_set_hl(0, 'MiniPickBorder', { link = 'FloatBorder' })
      vim.api.nvim_set_hl(0, 'MiniPickPreview', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'MiniPickSelection', { bg = '#504945' })
    end,
    opts = {
      provider = 'gemini',
      file_selector = {
        provider = 'mini.pick',
        mini_pick = {
          options = {
            use_icons = true,
          },
        },
      },
      auto_suggestions_provider = 'openai',
      openai = {
        endpoint = 'https://api.deepseek.com/v1',
        model = 'deepseek-chat',
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
        api_key_name = 'DEEPSEEK_API_KEY',
      },
      gemini = {
        api_key_name = 'GOOGLEAI_API_KEY',
        model = 'gemini-2.0-pro-exp-02-05',
        temperature = 0,
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.pick',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'zbirenbaum/copilot.lua',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },

  -- Code companions
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Visual tools
  {
    'folke/twilight.nvim',
    opts = {},
  },

  -- Code outline
  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- Marks navigation
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Github integration
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- LeetCode practice
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      lang = 'typescript',
    },
  },

  -- Code completion
  'supermaven-inc/supermaven-nvim',

  -- Search and replace
  'nvim-pack/nvim-spectre',

  -- Prettier formatting
  'prettier/vim-prettier',

  -- Git diff viewer
  'sindrets/diffview.nvim',

  -- Vim game to practice movement
  'ThePrimeagen/vim-be-good',

  -- Tmux integration
  'aserowy/tmux.nvim',

  -- Lua development
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },

  -- Todo comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Session management
  'tpope/vim-obsession',
}

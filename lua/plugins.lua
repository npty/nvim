-- lua/plugins.lua
-- Plugin specs, in lazy.nvim's spec format.
--
-- Previously split across user/plugins_always.lua and user/plugins_notvscode.lua
-- while this config still supported running inside VSCode. That branch is gone, so
-- the split meant nothing and the two lists live here together.

return {
  -- Core plugins that enhance Vim functionality
  'tpope/vim-fugitive', -- Git integration
  'tpope/vim-rhubarb', -- GitHub integration

  -- Navigation and editing improvements
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
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Better text objects

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- Other always-loaded plugins from your config
  'ojroques/vim-oscyank',
  'rust-lang/rust.vim',
  '0xmovses/move.vim',

  -- UI enhancements

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
    priority = 1000,
    config = function(_, opts)
      local snacks = require 'snacks'
      snacks.setup(opts)
      vim.ui.select = snacks.picker.select
    end,
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
              'build',
              'out',
              '.next',
              '.nuxt',
              '.turbo',
              '.vscode',
              '.idea',
              '%.svg$',
              '%.map$',
              '%.min%.js$',
              '%.min%.css$',
              '.*cache.*%.json$',
              '%.lock$',
              '%.log$',
              'coverage',
              '.nyc_output',
              'tmp',
              'temp',
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
      -- scroll = {},
      git = {},
      terminal = {},
      lazygit = {},
      styles = {
        terminal = {
          keys = {
            term_normal = {
              '<esc>',
              function(self)
                vim.cmd 'stopinsert'
              end,
              mode = 't',
              expr = false,
              desc = 'Escape to normal mode',
            },
          },
        },
      },
    },
  },

  -- LSP and completion
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'saghen/blink.cmp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    opts = {
      servers = require('custom.lsp_servers').servers,
    },

    config = function(_, opts)
      local servers = opts.servers or {}
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettier',
        'prettierd',
        'shfmt',
        'isort',
        'black',
      })

      require('mason').setup()
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = false,
      }

      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
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
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
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

  -- UI enhancements
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
  },

  {
    'chrisgrieser/nvim-early-retirement',
    config = true,
    event = 'VeryLazy',
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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

  -- Treesitter for syntax highlighting and code parsing
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'diff',
          'html',
          'javascript',
          'json',
          'latex',
          'lua',
          'markdown',
          'norg',
          'prisma',
          'regex',
          'rust',
          'scss',
          'solidity',
          'svelte',
          'tmux',
          'toml',
          'tsx',
          'typst',
          'typescript',
          'vue',
          'yaml',
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = { 'markdown', 'yaml' },
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = {
          enable = true,
          disable = { 'ruby', 'javascript', 'typescript', 'rust', 'json', 'markdown', 'yaml' },
        },
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

  -- Code context at the top of the buffer
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      enable = true,
      max_lines = 3,
      on_attach = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        return ft ~= 'markdown' and ft ~= 'yaml'
      end,
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
    },
  },

  -- Which key to show keybindings
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Visual tools
  {
    'folke/twilight.nvim',
    cmd = 'Twilight',
    keys = {
      { '<leader>tw', '<cmd>Twilight<CR>', desc = 'Toggle Twilight' },
    },
    opts = {},
  },

  -- Code outline
  {
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle', 'AerialOpen', 'AerialClose', 'AerialNavToggle' },
    keys = {
      { '<leader>l', '<cmd>AerialToggle!<CR>', desc = 'Toggle Aerial' },
    },
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function(_, opts)
      opts.on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end
      require('aerial').setup(opts)
    end,
  },

  -- Tmux integration
  {
    'aserowy/tmux.nvim',
    event = 'VeryLazy',
    cond = function()
      return require('custom.tmux').is_available()
    end,
    opts = {
      copy_sync = {
        sync_clipboard = false,
      },
    },
  },

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
  { 'folke/todo-comments.nvim', event = { 'BufReadPost', 'BufNewFile' }, dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Session management
  'tpope/vim-obsession',

  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'saghen/blink.compat', 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-c>'] = {
          function(cmp)
            cmp.show { providers = { 'lsp' } }
          end,
        },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        menu = {
          border = 'rounded',
        },
        ghost_text = {
          enabled = true,
        },
        documentation = { auto_show = true },
      },

      signature = { enabled = true },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}

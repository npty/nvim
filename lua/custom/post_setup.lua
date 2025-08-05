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
  --
  -- Configure TreeSitter context
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

  require('nvim-treesitter.configs').setup {
    modules = {},
    sync_install = false,
    ignore_install = {},
    auto_install = true,
    ensure_installed = { 'lua', 'typescript', 'javascript', 'json', 'prisma' },
    highlight = {
      enable = true,
    },
    fold = {
      enable = true,
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

  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.move',
    command = 'set filetype=move',
  })

  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.prisma',
    command = 'set filetype=prisma',
  })

  require('tmux').setup()

  local original_capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities)

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

  local servers = require('custom.lsp_servers').servers

  require('mason').setup()

  -- You can add other tools here that you want Mason to install
  -- for you, so that they are available from within Neovim.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- Add other tools here like formatters, linters, debuggers
    'stylua',
    'prettier',
    'shfmt',
    'isort',
    'black',
    'rustfmt',
    -- Add debug adapters if needed
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers or {}), -- Ensure only LSP servers from your list are managed here
    automatic_installation = true,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- Merge capabilities correctly
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
end

return M

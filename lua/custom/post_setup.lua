-- custom/post_setup.lua
-- This file contains configurations that should be run after plugins are loaded

local M = {}

function M.setup()
  -- Only execute these configurations outside of VSCode
  if vim.g.vscode then
    return
  end

  -- Configure Octo.nvim
  require('octo').setup {
    suppress_missing_scope = {
      projects_v2 = true,
    },
  }

  require('supermaven-nvim').setup {
    color = {
      suggestion_color = '#C1FFC1',
      cterm = 244,
    },
    keymaps = {
      accept_suggestion = '<Tab>',
      clear_suggestion = '<C-]>',
      accept_word = '<C-j>',
    },
  }
  vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#E6E6FA' })

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
    ensure_installed = { 'lua', 'typescript', 'javascript' },
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

  require('tmux').setup()

  -- Configure Noice
  -- require('noice').setup {
  --   lsp = {
  --     override = {
  --       ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
  --       ['vim.lsp.util.stylize_markdown'] = true,
  --     },
  --   },
  --   presets = {
  --     bottom_search = true,
  --     command_palette = true,
  --     long_message_to_split = true,
  --   },
  --   notify = {
  --     enabled = true,
  --     view = 'notify',
  --     opts = {
  --       background_colour = '#000000',
  --     },
  --   },
  -- }

  -- local telescope = require 'telescope'
  -- telescope.setup {
  --   defaults = {
  --     vimgrep_arguments = {
  --       'rg',
  --       '--color=never',
  --       '--ignore',
  --       '--no-heading',
  --       '--with-filename',
  --       '--smart-case',
  --       '--line-number',
  --       '--column',
  --     },
  --     file_sorter = require('telescope.sorters').get_fuzzy_file,
  --     generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
  --     file_ignore_patterns = {
  --       'node_modules',
  --       '.git',
  --       'target',
  --       'dist',
  --       '%.svg$',
  --       -- Matches JSON files that have "cache" anywhere in the name
  --       '.*cache.*%.json$',
  --       '%.lock$',
  --     },
  --     cache_picker = {
  --       num_pickers = 5,
  --       limit_entries = 1000,
  --     },
  --   },
  --   -- You can put your default mappings / updates / etc. in here
  --   --  All the info you're looking for is in `:help telescope.setup()`
  --   --
  --   -- defaults = {
  --   --   mappings = {
  --   --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
  --   --   },
  --   -- },
  --   -- pickers = {}
  --   pickers = {
  --     find_files = {
  --       find_command = {
  --         'rg',
  --         '--files',
  --         '--hidden',
  --         '--glob',
  --         '!**/.git/*',
  --         '--glob',
  --         '!**/node_modules/*',
  --         '--glob',
  --         '!**/dist/*',
  --         '--glob',
  --         '!**/target/*',
  --         '--smart-case',
  --       },
  --     },
  --     colorscheme = {
  --       enable_preview = true,
  --     },
  --   },
  --   extensions = {
  --     ['ui-select'] = {
  --       require('telescope.themes').get_dropdown(),
  --     },
  --     aerial = {
  --       -- How to format the symbols
  --       format_symbol = function(symbol_path, filetype)
  --         if filetype == 'json' or filetype == 'yaml' then
  --           return table.concat(symbol_path, '.')
  --         else
  --           return symbol_path[#symbol_path]
  --         end
  --       end,
  --       -- Available modes: symbols, lines, both
  --       show_columns = 'both',
  --     },
  --   },
  -- }
  -- pcall(telescope.load_extension, 'fzf')
  -- pcall(telescope.load_extension, 'aerial')
  -- pcall(telescope.load_extension, 'ui-select')
  --
  -- -- See `:help telescope.builtin`
  -- local builtin = require 'telescope.builtin'
  -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  -- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  -- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  --
  -- -- Slightly advanced example of overriding default behavior and theme
  -- vim.keymap.set('n', '<leader>/', function()
  --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  --     winblend = 10,
  --     previewer = false,
  --   })
  -- end, { desc = '[/] Fuzzily search in current buffer' })
  --
  -- -- It's also possible to pass additional configuration options.
  -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
  -- vim.keymap.set('n', '<leader>s/', function()
  --   builtin.live_grep {
  --     grep_open_files = true,
  --     prompt_title = 'Live Grep in Open Files',
  --   }
  -- end, { desc = '[S]earch [/] in Open Files' })
  --
  -- -- Shortcut for searching your Neovim configuration files
  -- vim.keymap.set('n', '<leader>sn', function()
  --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
  -- end, { desc = '[S]earch [N]eovim files' })
  --
  -- -- Setup the LSP
  -- vim.api.nvim_create_autocmd('LspAttach', {
  --   group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --   callback = function(event)
  --     -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  --     -- to define small helper and utility functions so you don't have to repeat yourself.
  --     --
  --     -- In this case, we create a function that lets us more easily define mappings specific
  --     -- for LSP related items. It sets the mode, buffer and description for us each time.
  --     local map = function(keys, func, desc)
  --       vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  --     end
  --
  --     -- Jump to the definition of the word under your cursor.
  --     --  This is where a variable was first declared, or where a function is defined, etc.
  --     --  To jump back, press <C-t>.
  --     map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  --
  --     -- Find references for the word under your cursor.
  --     map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  --
  --     -- Jump to the implementation of the word under your cursor.
  --     --  Useful when your language has ways of declaring types without an actual implementation.
  --     map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  --
  --     -- Jump to the type of the word under your cursor.
  --     --  Useful when you're not sure what type a variable is and you want to see
  --     --  the definition of its *type*, not where it was *defined*.
  --     map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  --
  --     -- Fuzzy find all the symbols in your current document.
  --     --  Symbols are things like variables, functions, types, etc.
  --     map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  --
  --     -- Fuzzy find all the symbols in your current workspace.
  --     --  Similar to document symbols, except searches over your entire project.
  --     map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  --
  --     -- Rename the variable under your cursor.
  --     --  Most Language Servers support renaming across files, etc.
  --     map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  --
  --     -- Execute a code action, usually your cursor needs to be on top of an error
  --     -- or a suggestion from your LSP for this to activate.
  --     map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  --
  --     -- WARN: This is not Goto Definition, this is Goto Declaration.
  --     --  For example, in C this would take you to the header.
  --     map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  --     -- When you move your cursor, the highlights will be cleared (the second autocommand).
  --     local client = vim.lsp.get_client_by_id(event.data.client_id)
  --     if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
  --       local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  --       vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  --         buffer = event.buf,
  --         group = highlight_augroup,
  --         callback = vim.lsp.buf.document_highlight,
  --       })
  --
  --       vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  --         buffer = event.buf,
  --         group = highlight_augroup,
  --         callback = vim.lsp.buf.clear_references,
  --       })
  --
  --       vim.api.nvim_create_autocmd('LspDetach', {
  --         group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
  --         callback = function(event2)
  --           vim.lsp.buf.clear_references()
  --           vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
  --         end,
  --       })
  --     end
  --
  --     -- The following code creates a keymap to toggle inlay hints in your
  --     -- code, if the language server you are using supports them
  --     --
  --     -- This may be unwanted, since they displace some of your code
  --     if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
  --       map('<leader>th', function()
  --         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  --       end, '[T]oggle Inlay [H]ints')
  --     end
  --   end,
  -- })

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

  -- require('nvim-tree').setup {
  --   view = {
  --     width = 50,
  --   },
  --   sort = {
  --     sorter = 'case_sensitive',
  --   },
  --   renderer = {
  --     group_empty = true,
  --   },
  --   update_focused_file = {
  --     enable = true,
  --     update_cwd = true,
  --   },
  --   diagnostics = {
  --     enable = true,
  --     show_on_dirs = true,
  --     icons = {
  --       hint = '',
  --       info = '',
  --       warning = '',
  --       error = '',
  --     },
  --   },
  --   on_attach = function(bufnr)
  --     local api = require 'nvim-tree.api'
  --
  --     local function opts(desc)
  --       return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  --     end
  --
  --     -- Default mappings
  --     api.config.mappings.default_on_attach(bufnr)
  --
  --     -- Custom mappings
  --     vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
  --     vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
  --     vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
  --     vim.keymap.set('n', 'y', api.fs.copy.filename, opts 'Copy Name')
  --     vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts 'Copy Relative Path')
  --     vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts 'Copy Absolute Path')
  --   end,
  -- }

  -- Setup Nvim CMP
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  luasnip.config.setup {} -- Explicitly initialize LuaSnip

  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = 'menu,menuone,noinsert', -- Restore noinsert behavior
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      ['<C-p>'] = cmp.mapping.select_prev_item(),

      ['<C-c>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm { select = true },
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require('luasnip').jumpable(-1) then
          require('luasnip').jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      -- To use <C-n> and <C-p> like your old config:
      -- ['<C-n>'] = cmp.mapping.select_next_item(),
      -- ['<C-p>'] = cmp.mapping.select_prev_item(),
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'supermaven' }, -- Add back supermaven
    },
  }
end

return M

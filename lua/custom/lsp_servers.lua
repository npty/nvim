-- lua/custom/lsp_servers.lua
-- Defines the LSP servers configuration to be used across the setup

local M = {}

local quiet_diagnostic_handler = function() end

M.servers = {
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
  ts_ls = {
    handlers = {
      ['textDocument/publishDiagnostics'] = quiet_diagnostic_handler,
    },
  },

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

  eslint = {
    handlers = {
      ['textDocument/publishDiagnostics'] = quiet_diagnostic_handler,
    },
  },

  tailwindcss = {
    filetypes = {
      'html',
      'css',
      'scss',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'svelte',
      'vue',
    },
    handlers = {
      ['textDocument/publishDiagnostics'] = quiet_diagnostic_handler,
    },
  },

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

  marksman = {
    handlers = {
      ['textDocument/publishDiagnostics'] = quiet_diagnostic_handler,
    },
  },

  prismals = {},

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

return M

-- lua/custom/quiet.lua
-- One home for this config's diagnostic-quieting intent.
--
-- `M.policy` is the declaration; the functions below are only the mechanisms
-- that implement it. Nothing else in the config should silence diagnostics by
-- hand -- ask this module instead.

local M = {}

-- Filetype entries keep visible diagnostics off for the buffer, and
-- `treesitter = true` also stops treesitter there. Server entries are the
-- `quiet = true` marks in custom.lsp_servers: the mark is where a server is
-- declared quiet, this is just the resolved view of it.
M.policy = {
  filetypes = {
    typescript = {},
    typescriptreact = {},
    markdown = { treesitter = true },
    yaml = { treesitter = true },
  },
  servers = {},
}

for server, config in pairs(require('custom.lsp_servers').servers) do
  if config.quiet then
    M.policy.servers[#M.policy.servers + 1] = server
  end
end
table.sort(M.policy.servers)

-- A quiet server's diagnostics are dropped on arrival, in every buffer it
-- attaches to. That is deliberately wider than the filetype list above --
-- eslint and tailwindcss also attach to plain javascript -- so it stays a
-- per-server decision rather than a second reading of the filetypes.
local function drop_diagnostics() end

-- Per-buffer mechanism for the filetype policy. Called from the autocmd in
-- config/options.lua.
function M.apply(bufnr)
  local quiet = M.policy.filetypes[vim.bo[bufnr].filetype]
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

-- Per-server mechanism for the server policy. Returns the config to hand to
-- `vim.lsp.config`, with the policy's handler derived rather than copied into
-- each server entry. The mark is dropped so it never reaches the client config.
function M.server_config(config)
  if not config.quiet then
    return config
  end

  local out = vim.tbl_extend('force', {}, config)
  out.quiet = nil
  out.handlers = vim.tbl_extend('force', {}, config.handlers or {}, {
    ['textDocument/publishDiagnostics'] = drop_diagnostics,
  })
  return out
end

return M

-- lua/custom/env.lua
local M = {}

-- Function to load environment variables from .env file
function M.load_env()
  local env_file = vim.fn.stdpath 'config' .. '/.env'
  if vim.fn.filereadable(env_file) == 1 then
    for line in io.lines(env_file) do
      -- Skip comments and empty lines
      if line:sub(1, 1) ~= '#' and line:match '%S' then
        local name, value = line:match '^%s*(%S+)%s*=%s*(.-)%s*$'
        if name and value then
          -- Remove surrounding quotes if they exist
          value = value:gsub('^"(.-)"$', '%1')
          value = value:gsub("^'(.-)'$", '%1')
          vim.env[name] = value
        end
      end
    end
  end
end

-- Function to get environment variable with fallback
function M.get_env(name, default)
  return vim.env[name] or default
end

-- Function to check if all required environment variables are set
function M.check_required_env()
  local required_vars = {}

  local missing_vars = {}
  for _, var in ipairs(required_vars) do
    if not vim.env[var] or vim.env[var] == '' then
      table.insert(missing_vars, var)
    end
  end

  if #missing_vars > 0 then
    local msg = 'Missing required environment variables:\n' .. table.concat(missing_vars, '\n')
    vim.notify(msg, vim.log.levels.WARN)
  end
end

return M

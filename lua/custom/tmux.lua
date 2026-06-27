local M = {}

function M.socket()
  local tmux = vim.env.TMUX
  if not tmux or tmux == '' then
    return nil
  end

  local socket = vim.split(tmux, ',', { plain = true })[1]
  if not socket or socket == '' then
    return nil
  end

  if not vim.uv.fs_stat(socket) then
    return nil
  end

  return socket
end

function M.is_available()
  return M.socket() ~= nil
end

function M.command(args)
  local socket = M.socket()
  if not socket then
    return nil
  end

  return 'tmux -S ' .. vim.fn.shellescape(socket) .. ' ' .. args
end

return M

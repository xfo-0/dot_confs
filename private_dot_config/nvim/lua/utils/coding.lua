local M = {}

function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", { size = { width = 1, height = 1 } }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

function M.find_cfg_path(file_name, directory)
  local path = directory or vim.api.nvim_buf_get_name(0)
  local config_path = vim.fs.find({ file_name }, { upward = true, path = path })[1] or vim.fn.expand(directory)
  return vim.fs.dirname(config_path)
end

-- FIX: regular gx
--      handle commaless

function M.OpenRepo()
  -- Get the text under the cursor
  local text = vim.fn.expand "<cWORD>"
  print(text)

  -- Check if the text matches the expected pattern
  if string.match(text, "^['\"][%w%._-]+/[%w%._-]+['\"],?$") then
    -- Remove the surrounding quotes and comma
    local repo = string.sub(text, 2, -3)

    -- Construct the GitHub URL
    local url = "https://github.com/" .. repo
    print(url, repo)
    -- Use jobstart to open the URL in the system's default web browser
    os.execute("handlr open " .. url)
  else
    -- If the text doesn't match the pattern, call the original gx command
    vim.api.nvim_command "normal! gx"
  end
end

function M.toggle_fold_method()
  -- Get the current fold method
  local current_foldmethod = vim.o.foldmethod

  -- Toggle between manual and marker
  if current_foldmethod == "manual" then
    -- Set fold method to marker
    vim.o.foldmethod = "marker"

    -- Detach UFO
    vim.cmd "UfoDetach"
  elseif current_foldmethod == "marker" then
    -- Set fold method to manual
    vim.o.foldmethod = "manual"

    -- Attach UFO
    vim.cmd "UfoAttach"
  end
end

function M.in_snippet()
  local luasnip = require "luasnip"
  return luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] ~= nil
end

return M

local icons = require "config.icons"
local Job = require "plenary.job"

local function fg(name)
  return function()
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

return {
  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return icons.ui.Tab .. " " .. shiftwidth
    end,
    padding = 1,
  },
  git_repo = {
    function()
      local results = {}
      local job = Job:new {
        command = "git",
        args = { "rev-parse", "--show-toplevel" },
        cwd = vim.fn.expand "%:p:h",
        on_stdout = function(_, line)
          table.insert(results, line)
        end,
      }
      job:sync()
      if results[1] ~= nil then
        return vim.fn.fnamemodify(results[1], ":t")
      else
        return ""
      end
    end,
  },
  separator = {
    function()
      return "%="
    end,
  },
  diff = {
    "diff",
    colored = true,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    diagnostics_color = {
      error = "DiagnosticError",
      warn = "DiagnosticWarn",
      info = "DiagnosticInfo",
      hint = "DiagnosticHint",
    },
    colored = true,
  },
  lsp_client = {
    function(msg)
      msg = msg or ""
      local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return ""
        end
        return msg
      end

      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local lsp_utils = require "plugins.lang.lsp.utils"
      local formatters = lsp_utils.list_formatters(buf_ft)
      vim.list_extend(buf_client_names, formatters)

      -- add linter
      local linters = lsp_utils.list_linters(buf_ft)
      vim.list_extend(buf_client_names, linters)

      -- -- add hover
      -- local hovers = lsp_utils.list_hovers(buf_ft)
      -- vim.list_extend(buf_client_names, hovers)

      -- add code action
      local code_actions = lsp_utils.list_code_actions(buf_ft)
      vim.list_extend(buf_client_names, code_actions)

      local hash = {}
      local client_names = {}
      for _, v in ipairs(buf_client_names) do
        if not hash[v] then
          client_names[#client_names + 1] = v
          hash[v] = true
        end
      end
      table.sort(client_names)
      return icons.ui.Code .. " " .. table.concat(client_names, ", ") .. " " .. icons.ui.Code
    end,
    -- icon = icons.ui.Code,
    colored = true,
    on_click = function()
      vim.cmd [[LspInfo]]
    end,
    color = fg "Comment",
  },
  noice_mode = {
    function()
      return require("noice").api.status.mode.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.mode.has()
    end,
    color = fg "Constant",
  },
  noice_command = {
    function()
      return require("noice").api.status.command.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.command.has()
    end,
    color = fg "Statement",
  },
  recorder = { require("recorder").displaySlots },
  -- node_type = { require("node-type").statusline },
  lspsaga_symbols = {
    function()
      return require("lspsaga.symbolwinbar"):get_winbar()
    end,
  },
  filename = {
    "filename",
    path = 4,
    color = { fg = "#544c3c" },
  },
  encoding = { "encoding", color = { fg = "#7b6f2d" } },
  -- venv = {
  -- 	function()
  -- 		function split(input, delimiter)
  -- 			local arr = {}
  -- 			string.gsub(input, "[^" .. delimiter .. "]+", function(w)
  -- 				table.insert(arr, w)
  -- 			end)
  -- 			return arr
  -- 		end

  -- 		function get_venv()
  -- 			local venv = vim.env.VIRTUAL_ENV
  -- 			if venv then
  -- 				local params = split(venv, "/")
  -- 				return "env:" .. params[table.getn(params)]
  -- 			else
  -- 				return ""
  -- 			end
  -- 		end

  -- 		return get_venv()
  -- 	end,
  -- },
}

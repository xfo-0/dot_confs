-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- -- Auto toggle hlsearch
-- local ns = vim.api.nvim_create_namespace("toggle_hlsearch")
-- local function toggle_hlsearch(char)
-- 	if vim.fn.mode() == "n" then
-- 		local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
-- 		local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

-- 		if vim.opt.hlsearch:get() ~= new_hlsearch then
-- 			vim.opt.hlsearch = new_hlsearch
-- 		end
-- 	end
-- end
-- vim.on_key(toggle_hlsearch, ns)

-- windows to close
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "OverseerForm",
    "OverseerList",
    "checkhealth",
    "floggraph",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-summary",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.gif" },
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    vim.api.nvim_command("!sway_float_nvim_gif " .. buf_name)
    vim.api.nvim_command "bdelete"
  end,
  once = true,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.g.enter_focused_buffer = vim.fn.bufnr()
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  callback = function()
    vim.g.last_focused_buffer = vim.fn.bufnr()
  end,
})

-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     vim.opt.statuscolumn = "%s %C %l"
--   end,
--   once = false,
-- })

-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     vim.opt.statuscolumn = "%s %C %r "
--   end,
--   once = false,
-- })
-- FIX: use bash parser for zsh?

-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = "zsh",
-- 	callback = function()
-- 		local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang
-- 		require("nvim-treesitter.parsers").ft_to_lang = function(ft)
-- 			if ft == "zsh" then
-- 				return "bash"
-- 			end
-- 			return ft_to_lang(ft)
-- 		end
-- 	end,
-- })

-- vim.api.nvim_set_hl(0, "TerminalCursorShape", { underline = true })
-- vim.api.nvim_create_autocmd("TermEnter", {
-- callback = function()
--  vim.cmd [[setlocal winhighlight=TermCursor:TerminalCursorShape]]
-- end,
-- })

-- vim.api.nvim_create_autocmd("VimLeave", {
-- callback = function()
--  vim.cmd [[set guicursor=a:ver100]]
-- end,
-- })

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- vim.api.nvim_create_autocmd("StdinReadPre", {
--   pattern = "*",
--   command = "let s:std_in=1",
-- })

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = [[
--     if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
--       execute 'Nnn' argv()[0] |
--       wincmd p |
--       enew |
--       execute 'cd '.argv()[0] |
--     endif
--   ]],
-- })

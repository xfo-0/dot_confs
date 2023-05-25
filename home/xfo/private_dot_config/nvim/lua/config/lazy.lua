--- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.ui" },
		{ import = "plugins.edit" },
		{ import = "plugins.lang" },
		{ import = "plugins.lang.diagnostics" },
		{ import = "plugins.lang.language" },
		-- { import = "plugins.extras.pde" },
		-- { import = "plugins.extras.pde.notes" },
	},
	defaults = { lazy = true, version = nil },
	ui = {
		custom_keys = {
			["l"] = function(plugin)
				require("lazy.util").float_term({ "lazygit", "log" }, { cwd = plugin.dir })
			end,
		},
		size = { width = 0.99, height = 0.99 },
	},
	-- install = { missing = true, colorscheme = { "gonio", "tokyonight", "gruvbox" } },
	install = { missing = true, colorscheme = { "gonio" } },
	-- dev = { patterns = jit.os:find "Windows" and {} or { "alpha2phi" } },
	-- dev = {
	-- 	-- directory where you store your local plugin projects
	-- 	path = "~/git/system/term/neovim/plugins/",
	-- 	---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
	-- 	patterns = {}, -- For example {"folke"}
	-- 	fallback = false, -- Fallback to git when local plugin doesn't exist
	-- },
	diff = { cmd = "terminal_git" },
	checker = { enabled = true },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

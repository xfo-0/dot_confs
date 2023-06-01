return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		config = function()
			local components = require("plugins.ui.statusline.components")

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = {},
					section_separators = {},
					disabled_filetypes = {
						statusline = { "alpha", "lazy" },
						winbar = {
							"help",
							"alpha",
							"lazy",
						},
					},
					always_divide_middle = true,
					globalstatus = true,
				},
				-- tabline = {
				-- 	lualine_a = { "buffers" },
				-- 	lualine_b = { "branch" },
				-- 	lualine_c = { "filename" },
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = { "tabs" },
				-- },
				winbar = {
					lualine_a = {},
					lualine_b = {
						components.git_repo,
						"branch",
						components.diff,
						components.filename,
					},
					lualine_c = {},
					lualine_x = {
						components.lsp_client,
						components.spaces,
						components.encoding,
					},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { components.filename },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						components.diagnostics,
						components.lspsaga_symbols,
						-- components.node_type,
						components.separator,
					},
					lualine_x = {
						components.noice_command,
						components.noice_mode,
						components.recorder,
						-- components.venv,
					},
					lualine_y = {
						"location",
						"progress",
					},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {
					"fzf",
					"lazy",
					"man",
					"nvim-dap-ui",
					"symbols-outline",
					"trouble",
					"toggleterm",
					"quickfix",
				},
			})
		end,
		dependencies = {
			-- { "roobert/node-type.nvim", config = true },
		},
	},
}

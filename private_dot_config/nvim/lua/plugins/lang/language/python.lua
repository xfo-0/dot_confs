vim.cmd([[
  if has('nvim') && !empty($CONDA_PREFIX)
  let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
endif
  ]])

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "off",
								autoSearchPaths = false,
								useLibraryCodeForTypes = false,
								-- diagnosticMode = "workspace",
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "mfussenegger/nvim-dap-python" },
		opts = {
			setup = {
				debugpy = function(_, _)
					require("dap-python").setup("python", {})
					table.insert(require("dap").configurations.python, {
						type = "python",
						request = "attach",
						connect = {
							port = 5678,
							host = "127.0.0.1",
						},
						mode = "remote",
						name = "container attach debug",
						cwd = vim.fn.getcwd(),
						pathmappings = {
							{
								localroot = function()
									return vim.fn.input("local code folder > ", vim.fn.getcwd(), "file")
								end,
								remoteroot = function()
									return vim.fn.input("container code folder > ", "/", "file")
								end,
							},
						},
					})
				end,
			},
		},
	},
}

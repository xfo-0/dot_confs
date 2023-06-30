return {
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
		ft = { "markdown" },
		build = "cd app && npm install",
	},
	{
		"xfo-0/jupyter_ascending.vim",
		branch = "open_converted",
		event = "VeryLazy",
	},
	{ "stsewd/gx-extended.vim", event = "VeryLazy" },
	{
		"kiyoon/jupynium.nvim",
		event = "VeryLazy",
		-- event = "'Bufunter *.ju'",
		build = "micromamba run -a '' -n base pip install .",
		enabled = vim.fn.isdirectory(vim.fn.expand("~/micromamba/")),
		opts = {
			auto_download_ipynb = false,
			python_host = { "micromamba", "run", "-a ''", "python" },
			jupyter_command = { "micromamba", "run", "-a ''", "jupyter-notebook" },
			firefox_profiles_ini_path = "/home/xfo/.mozilla/firefox/profiles.ini",
			firefox_profile_name = "jupynium_profile",
		},
	},
}

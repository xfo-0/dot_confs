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
    build = "conda run --no-capture-output -n jupynium pip install .",
    enabled = vim.fn.isdirectory(vim.fn.expand "~/mambaforge/envs/jupynium"),
    opts = {
      python_host = { "mamba", "run", "--no-capture-output", "-n", "jupynium", "python" },
      jupyter_command = { "mamba", "run", "--no-capture-output", "-n", "jupynium", "jupyter" },
      firefox_profiles_ini_path = "/home/xfo/.mozilla/firefox/profiles.ini",
      firefox_profile_name = "jupynium_profile",
    },
  },
}

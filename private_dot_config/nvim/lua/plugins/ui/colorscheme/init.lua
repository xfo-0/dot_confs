return {
  {
    "xfo-0/gonio",
    -- dir = "~/git/system/neovim/plugins/themes/Despacio",
    lazy = false,
    priority = 1000,
    branch = "main",
    config = function()
      vim.cmd [[
    try
    colorscheme gonio
    catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    endtry
    ]]
      require("gonio").setup {
        style = "default",
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
        use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background
      }
    end,
  },
  { "rktjmp/lush.nvim", event = "VeryLazy" },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
  },

  -- {
  --   "folke/styler.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("styler").setup {
  --       themes = {
  --         markdown = { colorscheme = "gruvbox" },
  --         help = { colorscheme = "gruvbox" },
  --       },
  --     }
  --   end,
  -- },

  --   {
  --     "folke/tokyonight.nvim",
  --     lazy = false,
  --     priority = 1000,
  --     opts = {
  --       style = "storm",
  --       transparent = false,
  --       styles = {
  --         sidebars = "transparent",
  --         floats = "transparent",
  --       },
  --     },
  --     config = function(_, opts)
  --       local tokyonight = require "tokyonight"
  --       tokyonight.setup(opts)
  --       tokyonight.load()
  --     end,
  --   },
  --   {
  --     "catppuccin/nvim",
  --     lazy = false,
  --     name = "catppuccin",
  --   },
  --   {
  --     "ellisonleao/gruvbox.nvim",
  --     lazy = false,
  --     config = function()
  --       require("gruvbox").setup()
  --     end,
  --   },
}

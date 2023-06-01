return {
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        left = "<C-Left>",
        right = "<C-Right>",
        down = "<C-Down>",
        up = "<C-Up>",
        line_left = "<C-Left>",
        line_right = "<C-Right>",
        line_down = "<C-Down>",
        line_up = "<C-Up>",
      },
    },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    event = "VeryLazy",
    config = function()
      local ccc = require "ccc"
      -- local mapping = ccc.mapping
      -- mapping.complete()
      -- mapping.quit()
      --
      -- mapping.toggle_input_mode()
      -- mapping.toggle_output_mode()
      -- mapping.toggle_alpha()

      -- mapping.goto_next()
      -- mapping.goto_prev()

      -- mapping.increase1()
      -- mapping.increase5()
      -- mapping.increase10()
      --
      -- mapping.decrease1()
      -- mapping.decrease5()
      -- mapping.decrease10()

      -- mapping.set0()
      -- mapping.set50()
      -- mapping.set100()
      -- ccc.delta()
      -- ccc.set_percent()
      ccc.setup {
        -- pickers = {
        --   ccc.picker.trailing_whitespace {
        --     ---@type table<string, string>
        --     --- Keys are filetypes, values are colors (6-digit hex)
        --     palette = {},
        --     ---@type string
        --     --- Default color. 6-digit hex representation.
        --     default_color = "#db7093",
        --     ---@type string[]|true
        --     --- List of filetypes for which highlighting is enabled or true.
        --     enable = true,
        --     ---@type string[]
        --     --- Used only when enable is true. List of filetypes for which
        --     --- highlighting is disabled.
        --     disable = {},
        --   },
        -- },
      }
    end,
  },

  {
    "nguyenvukhang/nvim-toggler",
    event = "VeryLazy",
    opts = {
      inverses = {
        ["True"] = "False",
        ["-"] = "+",
        [">"] = "<",
        ["/"] = "\\",
        ["Left"] = "Right",
        ["Up"] = "Down",
        ["top"] = "bottom",
      },
      remove_default_keybinds = true,
      remove_default_inverses = false,
    },
  },
  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", "<C-x>", { "<C-a>", "v" }, { "<C-x>", "v" }, { "g<C-a>", "v" }, { "g<C-x>", "v" } },
    -- stylua: ignore
    init = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { desc = "Decrement", noremap = true })
    end,
  },
  -- hex editing
  -- { "RaafatTurki/hex.nvim", event = "VeryLazy" },
  { "lambdalisue/suda.vim", event = "VeryLazy" },
  { "vladdoster/remember.nvim", event = "VeryLazy", config = true },
}

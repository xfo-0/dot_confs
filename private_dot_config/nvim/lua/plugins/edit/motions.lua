return {
  { "numToStr/Navigator.nvim", opts = { mux = "auto" } },

  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
    keys = { "<C-Left>", "<C-Right>", "<C-Down>", "<C-Up>" },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },

  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    opts = {
      -- safe_labels = {},
      -- labels = {},
      special_keys = {
        repeat_search = "<enter>",
        next_phase_one_target = "<enter>",
        next_target = "<enter>",
        prev_target = "<tab>",
        next_group = "<space>",
        prev_group = "<tab>",
        multi_accept = "<enter>",
        multi_revert = "<backspace>",
      },
    },
  },

  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    -- TODO: grapple.nvim and harpoon
    "cbochs/portal.nvim",
    event = "VeryLazy",
    opts = {
      labels = { "e", "o", "n", "t" },
    },
  },

  {
    "echasnovski/mini.ai",
    keys = { { "a", mode = { "x", "o" } }, { "i", mode = { "x", "o" } } },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        end,
      },
    },
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = {
              "@block.outer",
              "@conditional.outer",
              "@loop.outer",
            },
            i = {
              "@block.inner",
              "@conditional.inner",
              "@loop.inner",
            },
          }, {}),
          f = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require "mini.ai"
      ai.setup(opts)
    end,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    config = function()
      require("various-textobjs").setup {
        useDefaultKeymaps = false,
      }
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
    },
    config = function()
      require("hlslens").setup()
    end,
  },

  { "chentoast/marks.nvim", event = "VeryLazy", config = true },

  {
    "ziontee113/query-secretary",
    event = "VeryLazy",
    config = true,
  },

  {
    "chrisgrieser/nvim-recorder",
    event = "VeryLazy",
    opts = {
      -- Named registers where macros are saved. The first register is the default
      -- register/macro-slot used after startup.
      slots = { "a", "b" },
      -- default keymaps, see README for description what the commands do
      mapping = {
        startStopRecording = "<C-q>",
        playMacro = "<C-z>",
        switchSlot = "<C-g>",
        editMacro = "cq",
        yankMacro = "yq", -- also decodes it for turning macros to mappings
        addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
      },
      -- clears all macros-slots on startup
      clear = false,
      -- log level used for any notification, mostly relevant for nvim-notify
      -- (note that by default, nvim-notify does not show the levels trace and debug.)
      logLevel = vim.log.levels.INFO,
      -- experimental, see README
      dapSharedKeymaps = false,
    },
  },

  {
    "abecodes/tabout.nvim",
    event = "VeryLazy",
    config = true,
  },
}

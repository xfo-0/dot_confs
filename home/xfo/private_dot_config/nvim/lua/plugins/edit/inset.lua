return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {
        fast_wrap = {
          -- check_ts = true,
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "",
          keys = "hetocnarsf",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    },
  },
  {
    "danymat/neogen",
    opts = {
      snippet_engine = "luasnip",
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        javascript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
        typescriptreact = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
      },
    },
  --stylua: ignore
  keys = {
    -- { "<leader>cgd", function() require("neogen").generate() end, desc = "Annotation", },
    -- { "<leader>cgc", function() require("neogen").generate { type = "class" } end, desc = "Class", },
    -- { "<leader>cgf", function() require("neogen").generate { type = "func" } end, desc = "Function", },
    -- { "<leader>cgt", function() require("neogen").generate { type = "type" } end, desc = "Type", },
  },
    {
      "gbprod/yanky.nvim",
      event = "VeryLazy",
      config = function()
        require("yanky").setup {}
      end,
    },
    { "nvim-telescope/telescope-symbols.nvim", event = "VeryLazy" },
  },
  -- { "dhruvasagar/vim-table-mode", ft = { "markdown", "org", "norg" } },
  -- { "mzlogin/vim-markdown-toc", ft = { "markdown" } },
  -- { "dbmrq/vim-chalk", event = "VeryLazy" },
  -- {
  -- 	"jakewvincent/mkdnflow.nvim",
  -- 	ft = { "markdown" },
  -- 	rocks = "luautf8",
  -- 	opts = {},
  -- 	enabled = false,
  -- },
  -- { "AckslD/nvim-FeMaco.lua", ft = { "markdown" }, opts = {} },

  -- TODO: load on md with whichkey table motion/toggle/fold rebinds for nav link header etc standard md. neorg for notetaking
  -- { "antonk52/markdowny.nvim", event = "VeryLazy", config = true },
  -- {
  -- 	"jakewvincent/mkdnflow.nvim",
  -- 	event = "VeryLazy",
  -- 	config = true,
  -- },
  -- {
  -- 	"nvim-orgmode/orgmode",
  -- 	ft = { "org" },
  -- 	opts = {
  -- 		org_agenda_files = { vim.env.HOME .. "/org-notes/agenda/*" },
  -- 		org_default_notes_file = vim.env.HOME .. "/org-notes/default.org",
  -- 	},
  -- 	config = function(plugin, opts)
  -- 		require("orgmode").setup_ts_grammar()
  -- 		require("orgmode").setup(opts)
  -- 	end,
  -- },
  { "akinsho/org-bullets.nvim", opts = {}, ft = { "org" } },
  {
    "nvim-neorg/neorg",
    -- event = "VeryLazy",
    lazy = false,
    build = ":Neorg sync-parsers",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
          ["core.completion"] = { config = { engine = "nvim-cmp" } },
          ["core.summary"] = {},
          ["core.integrations.telescope"] = {},
        },
      }

      local neorg_callbacks = require "neorg.callbacks"

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode
            { "<C-s>", "core.integrations.telescope.find_linkable" },
          },

          i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)
    end,
  },
  -- {
  --   "ziontee113/icon-picker.nvim",
  --   event = "VeryLazy",
  --   opts = { disable_legacy_commands = true },
  -- },
}

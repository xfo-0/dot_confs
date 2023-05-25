return {
  {
    "ThePrimeagen/refactoring.nvim",
    event = "VeryLazy",
    -- keys = {
    --   {
    --     "<leader>cF",
    --     function()
    --       require("telescope").extensions.refactoring.refactors()
    --     end,
    --     mode = { "v" },
    --     desc = "Refactor",
    --   },
    -- },
    opts = {},
    config = function(_, opts)
      require("refactoring").setup(opts)
      require("telescope").load_extension "refactoring"
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  {
    "mizlan/iswap.nvim",
    event = "VeryLazy",
    opts = {
      keys = "dzrchutenosa",
      grey = "enabled",
      hl_snipe = "ErrorMsg",
      hl_selection = "WarningMsg",
      hl_grey = "Comment",
      flash_style = "sequential",
      hl_flash = "IncSearch",
      autoswap = true,
      debug = nil,
      hl_grey_priority = "1000",
    },
  },
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup {
        on_substitute = nil,
        yank_substituted_text = false,
        highlight_substituted_text = {
          enabled = true,
          timer = 500,
        },
        range = {
          prefix = "s",
          prompt_current_text = false,
          confirm = false,
          complete_word = false,
          motion1 = false,
          motion2 = false,
          suffix = "",
        },
        exchange = {
          motion = false,
          use_esc_to_cancel = true,
        }, -- refer to the configuration section below
      }
    end,
  },
  {
    "Wansmer/treesj",
    event = "VeryLazy",
    opts = function()
      local lang_utils = require "treesj.langs.utils"

      require("treesj").setup {
        use_default_keymaps = false,
        check_syntax_error = true,
        max_join_length = 120,
        cursor_behavior = "hold",
        notify = true,
        langs = {
          -- python = {
          -- },
        },
        dot_repeat = true,
      }
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    -- event = "VeryLazy",
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local navbuddy = require "nvim-navbuddy"
      local actions = require "nvim-navbuddy.actions"
      navbuddy.setup {
        window = {
          border = "single", -- "rounded", "double", "solid", "none"
          -- or an array with eight chars building up the border in a clockwise fashion
          -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
          size = "60%", -- Or table format example: { height = "40%", width = "100%"}
          position = "50%", -- Or table format example: { row = "100%", col = "0%"}
          scrolloff = nil, -- scrolloff value within navbuddy window
          sections = {
            left = {
              size = "20%",
              border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
              size = "40%",
              border = nil,
            },
            right = {
              -- No size option for right most section. It fills to
              -- remaining area.
              border = nil,
              preview = "leaf", -- Right section can show previews too.
              -- Options: "leaf", "always" or "never"
            },
          },
        },
        node_markers = {
          enabled = true,
          icons = {
            leaf = "  ",
            leaf_selected = " → ",
            branch = " ",
          },
        },
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = "練",
          Interface = "練",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = "◩ ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = "ﳠ ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
        use_default_mappings = false,
        mappings = {
          ["<esc>"] = actions.close(), -- Close and cursor to original location
          ["q"] = actions.close(),

          ["<Down>"] = actions.next_sibling(), -- down
          ["<Up>"] = actions.previous_sibling(), -- up

          ["<Left>"] = actions.parent(), -- Move to left panel
          ["<Right>"] = actions.children(), -- Move to right panel
          ["_"] = actions.root(), -- Move to first panel

          ["v"] = actions.visual_name(), -- Visual selection of name
          ["V"] = actions.visual_scope(), -- Visual selection of scope

          ["y"] = actions.yank_name(), -- Yank the name to system clipboard "+
          ["Y"] = actions.yank_scope(), -- Yank the scope to system clipboard "+

          ["i"] = actions.insert_name(), -- Insert at start of name
          ["I"] = actions.insert_scope(), -- Insert at start of scope

          ["a"] = actions.append_name(), -- Insert at end of name
          ["A"] = actions.append_scope(), -- Insert at end of scope

          ["r"] = actions.rename(), -- Rename currently focused symbol

          ["d"] = actions.delete(), -- Delete scope

          ["f"] = actions.fold_create(), -- Create fold of current scope
          ["F"] = actions.fold_delete(), -- Delete fold of current scope

          ["c"] = actions.comment(), -- Comment out current scope

          ["<enter>"] = actions.select(), -- Goto selected symbol
          ["o"] = actions.select(),

          ["<C-Down>"] = actions.move_down(), -- Move focused node down
          ["<C-Up>"] = actions.move_up(), -- Move focused node up

          ["t"] = actions.telescope { -- Fuzzy finder at current level.
            layout_config = { -- All options that can be
              height = 0.60, -- passed to telescope.nvim's
              width = 0.60, -- default can be passed here.
              prompt_position = "top",
              preview_width = 0.50,
            },
            layout_strategy = "horizontal",
          },

          ["g?"] = actions.help(), -- Open mappings help window
        },
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        source_buffer = {
          follow_node = true, -- Keep the current node in focus on the source buffer
          highlight = true, -- Highlight the currently focused node
          reorient = "smart", -- "smart", "top", "mid" or "none"
          scrolloff = nil, -- scrolloff value when navbuddy is open
        },
      }
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "VeryLazy",
    opts = {
      color_devicons = true,
      open_cmd = "vnew",
      live_update = false, -- auto execute search again when you write to any file in vim
      line_sep_start = "┌-----------------------------------------",
      result_padding = "¦  ",
      line_sep = "└-----------------------------------------",
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
      mapping = {
        ["toggle_line"] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item",
        },
        ["enter_file"] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "goto current file",
        },
        ["send_to_qf"] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
        ["replace_cmd"] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace vim command",
        },
        ["show_option_menu"] = {
          map = "<leader>o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show option",
        },
        ["run_current_replace"] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line",
        },
        ["run_replace"] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all",
        },
        ["change_view_mode"] = {
          map = "<leader>v",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode",
        },
        ["change_replace_sed"] = {
          map = "trs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace",
        },
        ["change_replace_oxi"] = {
          map = "tro",
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = "use oxi to replace",
        },
        ["toggle_live_update"] = {
          map = "tu",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "update change when vim write file.",
        },
        ["toggle_ignore_case"] = {
          map = "ti",
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case",
        },
        ["toggle_ignore_hidden"] = {
          map = "th",
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden",
        },
        ["resume_last_search"] = {
          map = "<leader>l",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "resume last search before close",
        },
        -- you can put your mapping here it only use normal mode
      },
      find_engine = {
        -- rg is map with finder_cmd
        ["rg"] = {
          cmd = "rg",
          -- default args
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
            -- you can put any rg search option you want here it can toggle with
            -- show_option function
          },
        },
        ["ag"] = {
          cmd = "ag",
          args = {
            "--vimgrep",
            "-s",
          },
          options = {
            ["ignore-case"] = {
              value = "-i",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
          },
        },
      },
      replace_engine = {
        ["sd"] = {
          cmd = "sd",
          args = nil,
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
        -- call rust code by nvim-oxi to replace
        ["oxi"] = {
          cmd = "oxi",
          args = {},
          options = {
            ["ignore-case"] = {
              value = "i",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
      },
      default = {
        find = {
          --pick one of item in find_engine
          cmd = "rg",
          options = { "ignore-case" },
        },
        replace = {
          --pick one of item in replace_engine
          cmd = "sed",
        },
      },
      replace_vim_cmd = "cdo",
      is_open_target_win = true, --open file on opener window
      is_insert_mode = false, -- start open panel on is_insert_mode
    },
  },
  { "roobert/search-replace.nvim", event = "VeryLazy", config = true },
}

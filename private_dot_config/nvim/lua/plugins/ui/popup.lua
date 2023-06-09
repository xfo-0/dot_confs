return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local icons = require "config.icons"
      require("notify").setup {
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        background_colour = "#000000",
        fps = 120,
        icons = {
          DEBUG = icons.diagnostics.Debug,
          ERROR = icons.diagnostics.Error,
          INFO = icons.diagnostics.Information,
          TRACE = icons.diagnostics.Trace,
          WARN = icons.diagnostics.Warning,
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "slide",
        timeout = 3200,
        top_down = true,
      }
    end,
  },
  {
    "folke/noice.nvim",
    lazy = false,
    -- enabled = false,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "rcarriga/nvim-notify" },
    },
    opts = {
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "󰾺", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "󰾺", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "󰢱", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
          input = {}, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
      },
      -- default options for require('noice').redirect
      -- see the section on Command Redirection
      ---@type NoiceRouteConfig
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      -- You can add any custom commands below that will be available with `:Noice command`
      ---@type table<string, NoiceCommand>
      commands = {
        history = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
        },
        -- :Noice last
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp", kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
          -- options for the message history that you get with `:Noice`
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
      },
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
      },
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = false,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = true,
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        signature = {
          -- rayx signature
          enabled = false,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help, -- vim help links
          -- ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      health = {
        checker = true, -- Disable if you don't want health checks to run
      },
      smart_move = {
        -- noice tries to move out of the way of existing floating windows.
        enabled = true, -- you can disable this behaviour here
        -- add any filetypes here, that shouldn't trigger smart move.
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },
      ---@type NoicePresets
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
      ---@type NoiceConfigViews
      views = {}, ---@see section on views
      ---@type NoiceRouteConfig[]
      routes = {}, --- @see section on routes
      ---@type table<string, NoiceFilter>
      status = {}, --- @see section on statusline components
      ---@type NoiceFormatOptions
      format = {}, --- @see section on formatting
    },
  --stylua: ignore
  keys = {
    -- { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    -- { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    -- { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    -- { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    -- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
    -- { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
  },
  },
  {
    "simrat39/symbols-outline.nvim",
    event = "VeryLazy",
    opts = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false,
      position = "right",
      relative_width = true,
      width = 22,
      auto_close = false,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      preview_bg_highlight = "Pmenu",
      autofold_depth = 3,
      auto_unfold_hover = true,
      fold_markers = { "", "" },
      wrap = false,
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "h",
        toggle_preview = "k",
        rename_symbol = "r",
        code_actions = "a",
        fold = "f",
        unfold = "<C-f>",
        fold_all = "W",
        unfold_all = "M",
        fold_reset = "R",
      },
      lsp_blacklist = {},
      symbol_blacklist = {},
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      },
    },
  },
  -- {
  --   "stevearc/aerial.nvim",
  --   event = "VeryLazy",
  --   -- config = true,
  --   opts = {
  --     -- Priority list of preferred backends for aerial.
  --     -- This can be a filetype map (see :help aerial-filetype-map)
  --     backends = { "treesitter", "lsp", "markdown", "man" },

  --     layout = {
  --       max_width = { 40, 0.2 },
  --       width = nil,
  --       min_width = 10,
  --       default_direction = "prefer_right",
  --       placement = "window",
  --       preserve_equality = false,
  --     },
  --     attach_mode = "window",
  --     close_automatic_events = {},
  --     keymaps = {
  --       ["?"] = "actions.show_help",
  --       ["g?"] = "actions.show_help",
  --       ["<CR>"] = "actions.jump",
  --       ["<2-LeftMouse>"] = "actions.jump",
  --       ["<C-v>"] = "actions.jump_vsplit",
  --       ["<C-s>"] = "actions.jump_split",
  --       ["p"] = "actions.scroll",
  --       ["<C-j>"] = "actions.down_and_scroll",
  --       ["<C-k>"] = "actions.up_and_scroll",
  --       ["{"] = "actions.prev",
  --       ["}"] = "actions.next",
  --       ["[["] = "actions.prev_up",
  --       ["]]"] = "actions.next_up",
  --       ["q"] = "actions.close",
  --       ["o"] = "actions.tree_toggle",
  --       ["za"] = "actions.tree_toggle",
  --       ["O"] = "actions.tree_toggle_recursive",
  --       ["zA"] = "actions.tree_toggle_recursive",
  --       ["l"] = "actions.tree_open",
  --       ["zo"] = "actions.tree_open",
  --       ["L"] = "actions.tree_open_recursive",
  --       ["zO"] = "actions.tree_open_recursive",
  --       ["h"] = "actions.tree_close",
  --       ["zc"] = "actions.tree_close",
  --       ["H"] = "actions.tree_close_recursive",
  --       ["zC"] = "actions.tree_close_recursive",
  --       ["zr"] = "actions.tree_increase_fold_level",
  --       ["zR"] = "actions.tree_open_all",
  --       ["zm"] = "actions.tree_decrease_fold_level",
  --       ["zM"] = "actions.tree_close_all",
  --       ["zx"] = "actions.tree_sync_folds",
  --       ["zX"] = "actions.tree_sync_folds",
  --     },
  --     lazy_load = false,
  --     disable_max_lines = 10000,
  --     disable_max_size = 2000000, -- Default 2MB
  --     filter_kind = {
  --       "Class",
  --       "Constructor",
  --       "Enum",
  --       "Function",
  --       "Interface",
  --       "Module",
  --       "Method",
  --       "Struct",
  --     },
  --     highlight_mode = "split_width",
  --     highlight_closest = true,
  --     highlight_on_hover = false,
  --     highlight_on_jump = 300,
  --     icons = {},
  --     ignore = {
  --       unlisted_buffers = false,
  --       filetypes = {},
  --       buftypes = "special",
  --       wintypes = "special",
  --     },
  --     manage_folds = false,
  --     link_folds_to_tree = false,
  --     link_tree_to_folds = true,
  --     nerd_font = "auto",
  --     on_attach = function(bufnr)
  --       -- Jump forwards/backwards with '{' and '}'
  --       vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
  --       vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  --     end,
  --     on_first_symbols = function(bufnr) end,
  --     open_automatic = function(bufnr)
  --       return vim.api.nvim_buf_line_count(bufnr) > 80
  --         -- Enforce a minimum symbol count
  --         and require("aerial").num_symbols(bufnr) > 4
  --         -- A useful way to keep aerial closed when closed manually
  --         and not require("aerial").was_closed()
  --     end,
  --     post_jump_cmd = "normal! zz",
  --     post_parse_symbol = function(bufnr, item, ctx)
  --       return true
  --     end,
  --     post_add_all_symbols = function(bufnr, items, ctx)
  --       return items
  --     end,

  --     close_on_select = false,
  --     update_events = "TextChanged,InsertLeave",
  --     show_guides = true,
  --     guides = {
  --       mid_item = "├─",
  --       last_item = "└─",
  --       nested_top = "│ ",
  --       whitespace = "  ",
  --     },
  --     get_highlight = function(symbol, is_icon)
  --       -- return "MyHighlight" .. symbol.kind
  --     end,
  --     float = {
  --       border = "rounded",
  --       relative = "cursor",
  --       max_height = 0.9,
  --       height = nil,
  --       min_height = { 8, 0.1 },
  --       override = function(conf, source_winid)
  --         -- This is the config that will be passed to nvim_open_win.
  --         -- Change values here to customize the layout
  --         return conf
  --       end,
  --     },

  --     lsp = {
  --       diagnostics_trigger_update = false,
  --       update_when_errors = true,
  --       update_delay = 300,
  --       priority = {
  --         -- pyright = 10,
  --       },
  --     },
  --     treesitter = {
  --       update_delay = 300,
  --     },

  --     markdown = {
  --       update_delay = 300,
  --     },

  --     man = {
  --       update_delay = 300,
  --     },
  --   },
  -- },
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    config = function()
      require("output_panel").setup()
    end,
  },
  {
    "jbyuki/nabla.nvim",
    --stylua: ignore
		config = function()
			require("nabla").enable_virt()
		end,
  },
  { "folke/zen-mode.nvim", opts = {}, cmd = { "ZenMode" } },
  -- {
  --   "echasnovski/mini.bufremove",
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
  --     { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
  --   },
  -- },
}

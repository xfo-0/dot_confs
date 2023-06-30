return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
        },
      },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup {
            text = {
              spinner = "pipe", -- animation shown when tasks are ongoing
              done = "✔", -- character shown when all tasks are complete
              commenced = "Started", -- message shown when task starts
              completed = "Completed", -- message shown when task completes
            },
            align = {
              bottom = true, -- align fidgets along bottom edge of buffer
              right = true, -- align fidgets along right edge of buffer
            },
            timer = {
              spinner_rate = 125, -- frame rate of spinner animation, in ms
              fidget_decay = 2000, -- how long to keep around empty fidget, in ms
              task_decay = 1000, -- how long to keep around completed task, in ms
            },
            window = {
              relative = "win", -- where to anchor, either "win" or "editor"
              blend = 100, -- &winblend for the window
              zindex = nil, -- the zindex value for the window
              border = "none", -- style of border for the fidget window
            },
            fmt = {
              leftpad = true, -- right-justify text in fidget box
              stack_upwards = true, -- list of tasks grows upwards
              max_width = 0, -- maximum width of the fidget box
              -- function to format fidget title
              fidget = function(fidget_name, spinner)
                return string.format("%s %s", spinner, fidget_name)
              end,
              -- function to format each task line
              task = function(task_name, message, percentage)
                return string.format("%s%s [%s]", message, percentage and string.format(" (%s%%)", percentage) or "", task_name)
              end,
            },
            -- sources = {                 -- Sources to configure
            --   * = {                     -- Name of source
            --     ignore = false,         -- Ignore notifications from this source
            --   },
            -- },
            debug = {
              logging = false, -- whether to enable logging, for debugging
              strict = false, -- whether to interpret LSP strictly
            },
          }
        end,
      },
      { "smjonas/inc-rename.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              hint = {
                enable = false,
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        dockerls = {},
      },
      setup = {
        lua_ls = function(_, _)
          -- local lsp_utils = require "plugins.lang.lsp.utils"
          -- lsp_utils.on_attach(function(client, buffer)
          -- stylua: ignore
          -- if client.name == "lua_ls" then
          --   vim.keymap.set("n", "klx", function() require("osv").run_this() end, { buffer = buffer, desc = "OSV Run" })
          --   vim.keymap.set("n", "kll", function() require("osv").launch({ port = 8086 }) end,
          --   { buffer = buffer, desc = "OSV Launch" })
          -- end
          -- end)
        end,
        yamlls = function(_, _) end,
      },
    },
    config = function(plugin, opts)
      require("plugins.lang.lsp.servers").setup(plugin, opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "ruff",
        "debugpy",
        "codelldb",
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mr = require "mason-registry"
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    config = function()
      local nls = require "null-ls"
      -- code_actions.refactoring
      -- code_actions.refactoring
      local nact = nls.builtins.code_actions
      local nfor = nls.builtins.formatting
      local ndia = nls.builtins.diagnostics
      local nhov = nls.builtins.hover
      local find_cfg_path = require("utils.coding").find_cfg_path
      nls.setup {
        debug = false,
        sources = {
          -- nfor.beautysh,
          -- nfor.black.with {
          --   extra_args = {
          --     "--config" .. find_cfg_path("pyproject.toml", "~/.config/lint/black/"),
          --   },
          -- },
          nact.shellcheck,
          nact.refactoring,
          nfor.black,
          nfor.trim_whitespace.with {
            filetypes = { "*" },
          },
          nfor.clang_format,
          nfor.gofmt,
          nfor.goimports,
          nfor.golines,
          nfor.rustfmt,
          nfor.shellharden,
          nfor.taplo,
          nfor.sql_formatter,
          nfor.xmlformat,
          nfor.stylua,
          -- nfor.xq,
          -- nfor.yq,
          -- nfor.jq,
          nfor.deno_fmt,
          -- nfor.dprint.with { find_cfg_path("dprint.json", "~/.config/lint/dprint/") },
          nfor.ruff,
          ndia.todo_comments,
          ndia.trail_space,
          ndia.commitlint,
          ndia.curlylint,
          ndia.gitlint,
          ndia.golangci_lint,
          -- ndia.markdownlint, -- diagnostics.misspell,
          ndia.shellcheck,
          -- ndia.yamllint,
          ndia.zsh,
          ndia.ruff,
          ndia.selene.with {
            cwd = function(_params)
              return vim.fs.dirname(vim.fs.find({ "selene.toml" }, {
                upward = true,
                path = vim.api.nvim_buf_get_name(0),
              })[1]) or vim.fn.expand "~/.config/lint/selene/" -- fallback value
            end,
          },
          nhov.printenv.with {
            filetypes = { "sh", "dosbatch", "ps1", "bash", "zsh" },
          },
        },
      }
    end,
  },
  { "jay-babu/mason-null-ls.nvim", opts = { ensure_installed = nil, automatic_installation = true, automatic_setup = false } },
  { "ray-x/lsp_signature.nvim", enabled = true, event = "VeryLazy", config = true },
  {
    "glepnir/lspsaga.nvim",
    enabled = true,
    event = "BufRead",
    config = function()
      require("lspsaga").setup {
        symbol_in_winbar = { enable = false },
        lightbulb = { enable = false },
        ui = {
          -- This option only works in Neovim 0.9
          title = true,
          -- Border type can be single, double, rounded, solid, shadow.
          border = "single",
          winblend = 0,
          expand = "",
          collapse = "",
          code_action = "",
          incoming = " ",
          outgoing = " ",
          hover = " ",
          kind = {},
        },
        code_action = {
          keys = {
            quit = { "q", "<Esc>" },
            exec = "<CR>",
          },
          outline = {
            win_position = "right",
            win_with = "",
            win_width = 30,
            show_detail = true,
            auto_preview = true,
            auto_refresh = true,
            auto_close = true,
            auto_resize = true,
            custom_sort = nil,
            keys = {
              jump = "o",
              expand_collapse = "u",
              quit = "q",
            },
          },
        },
      }
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "folke/trouble.nvim",
    enabled = true,
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
  },
  -- {
  --   "kevinhwang91/nvim-bqf",
  --   opts = {
  --     filter = {
  --       fzf = {
  --         extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
  --       },
  --     },
  --   },
  --   ft = "qf",
  -- },
}

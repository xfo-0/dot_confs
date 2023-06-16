return {
  -- legendary
  {
    "mrjones2014/legendary.nvim",
    keys = {
      -- { '<C-S-p>', '<cmd>Legendary<cr>', desc = 'Legendary' },
      -- { '<leader>hc', '<cmd>Legendary<cr>', desc = 'Command Palette' },
    },
    opts = {
      which_key = { auto_register = true },
    },
  },
  -- which_key
  -- TODO: hydra(dap)/harpoon
  -- ctrl-e
  -- ctrl-space / ctr-t / t?
  -- swap out , ; groups for use in repeatable locations
  -- g follow, edit hovers (s), edit (semicolon) - new key as a home layer, l binds?, comma?,
  -- q recording accciddental triggers

  {
    "folke/which-key.nvim",
    dependencies = { "mrjones2014/legendary.nvim" },
    event = "VeryLazy",
    config = function()
      local wk = require "which-key"
      local presets = require "which-key.plugins.presets"
      presets.operators["gc"] = nil
      presets.operators["ys"] = nil
      presets.operators["yS"] = nil
      presets.operators["v"] = nil

      wk.setup {
        -- key_labels = { ['<leader>'] = 'SPC' },
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = 'Comments' },
        -- key_labels = {
        --   -- override the label used to display some keys. It doesn't effect WK in any other way.
        --   -- For example:
        --   ['<space>'] = 'SPC',
        --   ['<cr>'] = 'RET',
        --   ['<tab>'] = 'TAB',
        -- },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
          border = "shadow", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "center", -- align columns left, center or right
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        hidden = {
          "<silent>",
          "<cmd>",
          "<Cmd>",
          "<CR>",
          "call",
          "lua",
          "^:",
          "^ ",
        }, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = "auto", -- automatically setup triggers
        -- triggers = {} -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }

      local nmappings = {
        ["<C-n>"] = { "<C-w><C-w>", "switch windows" },
        ["<C-c>"] = { ":CccPick<cr>", "ccc pick" },
        -- ['<C-t>'] = { ':NnnPicker %:p:h <cr>', 'nnn' },
        ["<C-t>"] = { ":Nnn %:p:h<cr>", "xplr" },
        -- ['<C-t>'] = { ':lua _NNN_TOGGLE<cr>', 'nnn' },
        ["<C-s>"] = { ":ISwapNodeWith<cr>", "ISWapNodeWith" },
        ["<C-.>"] = { ":ISwapNode<cr>", "ISWap" },
        ["t"] = { "<Plug>(leap-forward)", "leap forward" },
        ["T"] = { "<Plug>(leap-backward)", "leap backward" },
        ["h"] = { ":FzfLua buffers<cr>", "buffers (f)" },
        ["H"] = { ':lua require("telescope").load_extension("scope")<cr>', "tabs" },
        ['"'] = { ":FzfLua registers<cr>", "fzf registers" },
        -- ["'"] = { ":FzfLua marks<cr>", "fzf marks" },
        ["-"] = { ":w<cr>", "w" },
        ["<M-->"] = { ":noa w<cr>", "w" },
        ["#"] = { ":wq<cr>", "wq" },
        ["<M-#>"] = { ":qall!<cr>", "qall!" },
        -- ["<M-s>"] = { ":{ last focused buffer } <cr>", "last buf" },

        ["<M-j>"] = {
          name = "jupyter",
          ["."] = {
            ":JupyniumStartAndAttachToServerInTerminal <cr>",
            "start server",
          },
          s = {
            ":JupyniumStartSync <cr>",
            "start sync",
          },
          k = {
            ":JupyniumSelectKernel <cr>",
            "select kernel",
          },
          t = {
            ":JupyniumExecuteSelectedCells<cr>",
            "execute selected",
          },
          i = {
            ":JupyniumKernelInterrupt<cr>",
            "interrupt",
          },
          l = {
            ":JupyniumClearSelectedCellsOutputs<cr>",
            "clear selected",
          },
          r = {
            ":JupyniumKernelRestart<cr>",
            "restart kernel",
          },
        },

        s = {
          name = "s",
          ["<M-j>"] = { ":JupyniumKernelHover<cr>", "jupyter" },
          ["<Space>"] = { ':lua require("nvim-navbuddy").open()<cr>', "navbuddy" },
          l = { ":OutputPanel<cr>", "lsp log" },
          h = { ":lua vim.lsp.buf.hover()<cr>", "hover" },
          a = { ":Lspsaga code_action<cr>", "code action (s)" },
          C = { ":TSHighlightCapturesUnderCursor<cr>", "TSCaptures" },
          n = { ":TSNodeUnderCursor<cr>", "TSNodeUnderCursor" },
          d = { ":Lspsaga peek_definition<cr>", "peek definition (s)" },
          f = { ":Lspsaga lsp_finder<cr>", "lsp finder (s)" },
          i = { ":lua vim.lsp.buf.signature_help()<cr>", "signature help" },
          r = { ":Telescope lsp_references theme=ivy<cr>", "references (t)" },
          x = { ':lua require("nabla").popup()<cr>', "Notation" },
          c = {
            function()
              vim.api.nvim_command "TodoTrouble cwd=' .. vim.fn.expand '%:p:h"
            end,
            "Todo (T)",
          },
          e = {
            ":lua vim.diagnostic.open_float()<cr>",
            "line diagnostics (v)",
          },
          t = {
            ":TroubleToggle lsp_type_definitions<cr>",
            "type definitions (T)",
          },
          s = {
            ":FzfLua lsp_document_symbols<cr>",
            "document symbols (f)",
          },
          S = {
            ":Telescope lsp_dynamic_workspace_symbols theme=ivy<cr>",
            "workspace symbols (t)",
          },
          q = {
            ':lua require "query-secretary".query_window_initiate()<cr>',
            "query-secretary",
          },
          b = { ':lua require "gitsigns".blame_line()<cr>', "Blame (g)" },
          H = { ':lua require "gitsigns".preview_hunk()<cr>', "Preview Hunk (g)" },
          u = {
            ":TroubleToggle document_diagnostics<cr>",
            "document diagnostics (T)",
          },
          o = { ":TroubleToggle loclist<cr>", "loclist (T)" },
          w = {
            ":TroubleToggle workspace_diagnostics<cr>",
            "workspace diagnostics (T)",
          },
        },

        Z = {
          name = "Git",
          R = { ':lua require "gitsigns".reset_buffer()<cr>', "Reset Buffer" },
          r = { ':lua require "gitsigns".reset_hunk()<cr>', "Reset Hunk" },
          u = {
            ':lua require "gitsigns".undo_stage_hunk()<cr>',
            "Undo Stage Hunk",
          },
          S = { ':lua require "gitsigns".stage_hunk()<cr>', "Stage Hunk" },
          c = { ":FzfLua git_branches<cr>", "Checkout branch" },
          s = { ":FzfLua git_status<cr>", "status" },
          i = {
            name = "cli",
            i = { ":Octo issues list<cr>", "issues (o)" },
            p = { ":Octo pr list<cr>", "prs (o)" },
            g = { ":Octo gist list<cr>", "gists (o)" },
            -- r = { ':Octo repo list --hostname <cr>', "github repos (o)" },
          },
          o = { ":FzfLua git_status<cr>", "Open changed file" },
          h = { ":FzfLua git_commits<cr>", "Checkout commit" },
          t = { ":FzfLua git_bcommits<cr>", "buffer commits" },
          d = { ":Gitsigns diffthis HEAD<cr>", "Diff" },
          a = { ":Telescope repo list theme=ivy<cr>", "repo list" },
          f = { ":FzfLua git_files<cr>", "git_files(t)" },
        },

        f = {
          name = "[f]ind",
          [":"] = { ":FzfLua commands<cr>", "command history (f)" },
          ["/"] = {
            ":FzfLua search_history<cr>",
            "search history (f)",
          },
          d = { ":FzfLua commands<cr>", "commands (f)" },
          w = { ":FzfLua lines<cr>", "window (f)" },
          b = { ":FzfLua blines<cr>", "buffer (f)" },
          v = { ":FzfLua help_tags<cr>", "help tags (f)" },
          m = { ":FzfLua man_pages<cr>", "man pages (f)" },
          k = { ":FzfLua keymaps<cr>", "keymaps (f)" },
          c = { ":FzfLua files cwd=~/.config/nvim/<cr>", "nvim rg (f)" },
          C = { ":FzfLua live_grep_native  cwd=~/.config/<cr>", "~/.config rg (f)" },
          r = { ":FzfLua oldfiles<cr>", "old files (f)" },
          g = { ':FzfLua live_grep_native cwd=vim.fn.expand("%:p:h")<cr>', "rg wd (f)" },
          a = { ":FzfLua live_grep_native<cr>", "rg (f)" },
          f = { ":FzfLua files<cr>", "fd (f)" },
          h = { ":Telescope neorg search_headings theme=ivy<cr>", "norg headings (t)" },
          l = { ":Telescope neorg find_linkable theme=ivy<cr>", "norg linkable (t)" },
          z = { ":Telescope lazy theme=ivy<cr>", "lazy (t)" },
          u = { ":Telescope undo theme=ivy<cr>", "undo (t)" },
          Z = { ":Telescope scriptnames theme=ivy<cr>", "scriptnames (t)" },
          p = { ":Telescope projects theme=ivy<cr>", "projects (t)" },
          e = { ":Telescope env theme=ivy<cr>", "env vars (t)" },
          o = { ":TodoTelescope theme=ivy<cr>", "Todo telescope" },
        },

        l = {
          name = "mgmt",
          -- a = { ":AerialToggle!<cr>", "aerial outline" },
          r = { ":earlier 1f<cr>", "reset buf :w state" },
          t = { ":TaskWarriorTUI<cr>", "TaskWarriorTUI" },
          a = { ":Lspsaga outline<cr>", "lspsaga outline" },
          o = { ":SymbolsOutline<cr>", "symbols outline" },
          c = { ":lcd %:p:h | !pwd<cr>", "cwd buffer path" },
          k = { ":edit ~/.config/nvim/lua/plugins/whichkey.lua<cr>", "edit wk" },
          L = { ':lua require("hlargs).toggle()<cr>', "hlargs toggle" },
          d = { ':lua require("dapui").toggle()<cr>', "dap toggle" },
          l = { ":Mason<cr>", "Mason" },
          T = { ":TransparentToggle<cr>", "TransparentToggle" },
          u = { ":UfoInspect<cr>", "UfoInspect" },
          -- jq = { ':JqxQuery<cr>', 'JqxQuery' },
          -- jl = { ':JqxList<cr>', 'JqxList' },
          f = {
            ':lua require("utils.coding").toggle_fold_method()<cr>',
            "toggle fold method",
          },
          -- h = { ':lua require("mini.map").toggle() <cr>', 'map' },
          -- t = { ':LspToggle<cr>', 'LspToggle' },
          m = { ":Neomutt<cr>", "ISwapNodeWith" },
          v = { ":MarkdownPreviewToggle<cr>", "markdown Preview" },
          -- TODO: possibly avoid tab
          --       also M-e could remap l, tab cycle needs alternate remap
          ["<Tab>"] = { ":Alpha<cr>", "alpha" },
          ["<Enter>"] = { ":ColorizerToggle<cr>", "ColorizerToggle" },
          i = { ":LspInfo<cr>", "LSP Info" },
          s = { ":Lazy sync<cr>", "lazySync" },
          z = { ":Lazy<cr>", "Lazy" },
          p = { ":TSPlaygroundToggle<cr>", "TSPlaground" },
          -- t = { ':lua vim.treesitter.show_tree({command='bel 32vnew'})<cr>', 'TS show tree' },
          g = { ":lua _LAZYGIT_TOGGLE()<cr>", "lazygit" },
          H = { ":checkhealth<cr>", "checkhealth" },
          h = { ":Noice telescope theme=ivy<cr>", "noice history" },
          n = { ":Neorg workspace notes<cr>", "neorg" },
          N = { ":help news<cr>", "neovim news" },
          e = { ":Noice errors<cr>", "noice errors" },
          ["!"] = {
            ":ToggleTerm size=10 direction=horizontal<cr>",
            "float_term horizontal",
          },
        },

        [";"] = {
          name = ";",
          ["-"] = { ':lua require "plugins.lang.lsp.format".toggle()<cr>', "toggle format (nls)" },
          a = { "a<cr><Esc>", "append split" },
          o = { ':lua require "treesj".toggle()<cr>', "TSJToggle" },
          l = { ":Telescope neorg insert_file_link<cr>", "norg file ln" },
          e = { ':lua require "nvim-toggler".toggle()<cr>', "toggler" },
          -- TODO:
          --       org/norg/mdny/mdflow/(obsidian/telekastten?)
          --       neogen
          --       table mode
          --       markdown toc
          i = { "i<cr><Esc>", "insert split" },
          n = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
          r = { ":Lspsaga rename ++project<cr>", "Rename (s)" },
          j = { ":join<cr>", "join" },
          p = { ":YankyRingHistory<cr>", "Yanky" },
          w = { ":SearchReplaceSingleBufferCWord<cr>", "[w]ord" },
          s = { ":ISwapNodeWith<cr>", "ISwapNodeWith" },
          q = {
            name = "symbols",
            a = { ":Telescope symbols<cr>", "insert icon" },
            e = { ':lua require"telescope.builtin".symbols{ sources = {"emoji", "kaomoji", "gitmoji"} }<cr>', "emoji" },
            n = { ':lua require"telescope.builtin".symbols{ sources = {"nerd", "julia"} }<cr>', "nerd" },
            s = { ':lua require"telescope.builtin".symbols{ sources = {"latex", "math" } }<cr>', "math" },
          },
          ["."] = { ":ISwapNode<cr>", "ISwap" },
          b = {
            ':lua require("refactoring").refactor("Extract Block")<cr>',
            "Refact Extract Block",
          },
          -- b = { ':lua require("refactoring").refactor("Extract Block To File")<cr>', 'Extract Block To File' },
          v = {
            ':lua require("refactoring").refactor("Inline Variable")<cr>',
            "Refact Inline Variable",
          },
        },

        [","] = {
          name = ",",
          e = { ":BufferLineSortByExtension<cr>", "sort by extension" },
          o = { ":BufferLineSortByDirectory<cr>", "sort by directory" },
          s = { ":silent SudaWrite<cr>", "SudaWrite" },
          ["#"] = { ":wq<cr>", "write quit" },
          x = { ":xall!<cr>", "x all" },
          ["-"] = { ":SessionSave<cr>", "save session" },
          l = { ":SessionLoad<cr>", "Load" },
          -- T = { ':SessionToggle<cr>', 'Toggle' },
          -- s = { ':SessionStart<cr>', 'Start' },
          -- e = { ':SessionStop<cr>', 'Stop' },
          -- t = { ':SessionSave<cr>', 'Save' },
          r = { ":SessionLoadLast<cr>", "LoadLast" },
          d = { ":SessionDelete<cr>", "Delete" },
          p = { ":Telescope persisted<cr>", "Sessions" },
        },

        ["g"] = {
          name = "g motions",
          -- c = { -- TODO insert comment at cursor w/ associated Todo flag
          --   h = { '', 'Insert Todo ' },
          --   j = { ' ', 'Insert Todo Hack' },}
          --   k =
          --   l =
          -- }
          z = { ":ZenMode<cr>", "zen mode" },
          e = { ":Nnn <cfile><cr>", "fm path" },
          D = { ":lua vim.lsp.buf.declaration()<cr>", "to declaration hov" },
          t = { ":Lspsaga goto_type_definition<cr>", "goto type def (s)" },
          d = { ":Lspsaga goto_definition<cr>", "goto definition (s)" },
          o = { ":Portal jumplist backward<cr>", "jumplist backward" },
          i = { ":Portal jumplist forward<cr>", "jumplist forward" },
          -- a = { 'ggVG', 'select all' },
          x = { ':lua require("utils.coding").OpenRepo()<cr>', "gx w/ gh repo" },
          w = { "<Plug>(leap-from-window)", "leap window" },
          -- t = {},
        },

        ["["] = {
          name = "[ motions",
          -- ["["] = {
          --   function()
          --     require("illuminate").goto_prev_reference(false)
          --   end,
          --   "Prev Reference",
          -- },
          ["<Space>"] = {
            ":call append(line('.') - 1, '')<cr>",
            "blankline above",
          },
          c = {
            function()
              require("todo-comments").jump_prev()
            end,
            "Previous todo comment",
          },
          -- d = {
          --   ":Lspsaga diagnostic_jump_prev<cr>",
          --   "prev diagnostic",
          -- },
          e = {
            function()
              require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
            end,
            "prev error",
          },
          p = { "::pu!<cr>", "paste above" },
          l = { "::yyP<cr>", "current line above" },
          h = { ':lua require "gitsigns".prev_hunk()<cr>', "prev hunk" },
        },

        ["]"] = {
          name = "] motions",
          -- ["]"] = {
          --   function()
          --     require("illuminate").goto_next_reference(false)
          --   end,
          --   "Next Reference",
          -- },
          ["<Space>"] = { ":call append(line('.'), '')<cr>", "blankline below" },
          c = {
            function()
              require("todo-comments").jump_next()
            end,
            "Next todo comment",
          },
          -- d = {
          --   ":Lspsaga diagnostic_jump_next<cr>",
          --   "next diagnostic",
          -- },
          e = {
            function()
              require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
            end,
            "prev error",
          },
          p = { "::pu<cr>", "paste below" },
          l = { "::yyp<cr>", "current line below" },
          h = { ':lua require "gitsigns".next_hunk()<cr>', "next hunk" },
        },

        ["z"] = {
          -- TODO: better fold less/more
          --       toggle/choose fold method manual/ts/lsp bind
          name = "z/fold motions",
          ["R"] = { ':lua require("ufo").closeAllFolds()<cr>', "close all folds" },
          ["M"] = { ':lua require("ufo").openAllFolds()<cr>', "open all folds" },
          -- ['/'] = { ':ChalkAlign<cr>', 'ChalkAlign' },
          -- ['D'] = { ':ChalkDown<cr>', 'ChalkDown' },
          -- ['U'] = { ':ChalkUp<cr>', 'ChalkUp' },
          -- ['E'] = { '::zE<cr>', 'remove all folds' },
        },

        -- ['y'] = {
        --   name = 'y motions',
        --   -- [''] = { '', '' },
        -- },
      }

      local nopts = {
        mode = "n", -- NORMAL mode
        prefix = "",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local vmappings = {
        -- FIX: leap activating on initial typing of snippet field, needs conditional using boolean check of luasnip active
        -- ["t"] = { "<Plug>(leap-forward)", "leap forward" },
        -- ["T"] = { "<Plug>(leap-backward)", "leap backward" },
        [";"] = {
          r = {
            name = "refactoring",
            f = {
              ':lua require("refactoring").refactor("Extract Function")<cr>',
              "Extract Function",
            },
            -- f = { ':lua require("refactoring").refactor("Extract Function To File")<cr>', 'Extract Function To File' },
            v = {
              ':lua require("refactoring").refactor("Extract Variable")<cr>',
              "Extract Variable",
            },
            i = {
              ':lua require("refactoring").refactor("Inline Variable")<cr>',
              "Inline Variable",
            },
          },
          ["<M-j>"] = {
            name = "jupyter",
            t = {
              ":JupyniumExecuteSelectedCells<cr>",
              "execute selected",
            },
            l = {
              ":JupyniumClearSelectedCellsOutputs<cr>",
              "clear selected",
            },
          },
          w = {
            ":SearchReplaceSingleBufferVisualSelection<cr>",
            "SnR - buffer selection",
          },
          b = { ':lua require "markdowny".bold()<cr>', "md-ny bold" },
          i = { ':lua require "markdowny".italic()<cr>', "md-ny italic" },
          l = { ':lua require "markdowny".link()<cr>', "md-ny link" },

          t = { ':lua require "nvim-toggler".toggle()<cr>', "toggler" },
          y = { ":YankyRingHistory<cr>", "Yanky" },
        },
        ["z"] = {
          -- TODO: better fold less/more
          name = "z/fold motions",
          ["R"] = { ':lua require("ufo").closeAllFolds()<cr>', "close all folds" },
          ["M"] = { ':lua require("ufo").openAllFolds()<cr>', "open all folds" },
          -- ['/'] = { ':ChalkAlign<cr>', 'ChalkAlign' },
          -- ['D'] = { ':ChalkDown<cr>', 'ChalkDown' },
          -- ['U'] = { ':ChalkUp<cr>', 'ChalkUp' },
          -- ['E'] = { '::zE<cr>', 'remove all folds' },
        },
      }

      local vopts = {
        mode = "v", -- NORMAL mode
        prefix = "",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      wk.register(nmappings, nopts)
      wk.register(vmappings, vopts)
    end,
  },
}

return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next ToDo",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous ToDo",
      },
      -- { "<leader>ct", "<cmd>TodoTrouble<cr>", desc = "ToDo (Trouble)" },
      -- { "<leader>cT", "<cmd>TodoTelescope<cr>", desc = "ToDo" },
    },
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      color = "#ef9062",
      use_colorpalette = false,
      disable = function(_, bufnr)
        if vim.b.semantic_tokens then
          return true
        end
        local clients = vim.lsp.get_active_clients { bufnr = bufnr }
        for _, c in pairs(clients) do
          local caps = c.server_capabilities
          if c.name ~= "null-ls" and caps.semanticTokensProvider and caps.semanticTokensProvider.full then
            vim.b.semantic_tokens = true
            return vim.b.semantic_tokens
          end
        end
      end,
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup(nil, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
      })
    end,
  },
  { "HiPhish/nvim-ts-rainbow2", event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
      }
      vim.g.indentLine_enabled = 1
      -- vim.g.indent_blankline_char = "│"
      vim.g.indent_blankline_char = "▏"
      -- vim.g.indent_blankline_char = "▎"
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      }
      vim.wo.colorcolumn = "99999"

      -- vim.opt.listchars:append "space:⋅"
      -- vim.opt.listchars:append "space:"
      -- vim.opt.listchars:append "eol:↴"

      vim.cmd [[
        let g:indent_blankline_use_treesitter = v:true
      ]]

      require("indent_blankline").setup {
        -- show_end_of_line = true,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end,
  },
  { "RRethy/vim-illuminate", event = "VeryLazy" },
  -- {
  --   "zbirenbaum/neodim",
  --   event = "LspAttach",
  --   config = function()
  --     require("neodim").setup {
  --       alpha = 0.75,
  --       blend_color = "#000000",
  --       update_in_insert = {
  --         enable = true,
  --         delay = 100,
  --       },
  --       hide = {
  --         virtual_text = true,
  --         signs = true,
  --         underline = true,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "echasnovski/mini.trailspace",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.trailspace").setup { only_in_normal_buffers = true }
  --   end,
  -- },
}

return {
  {
    "akinsho/toggleterm.nvim",
    -- keys = {
    --   { [[<C-\>]] },
    --   { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
    -- },
    -- cmd = { "ToggleTerm", "TermExec" },
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup {
        size = 80,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 0.3,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        autochdir = true,
        close_on_exit = true,
        shell = vim.o.shell,
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end,
        },
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = { border = "Normal", background = "Normal" },
        },
      }

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        -- vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
        -- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        -- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        -- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new { cmd = "lazygit", float_opts = { border = "double", width = 200, height = 200 }, hidden = true }

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new { cmd = "node", hidden = true }

      function _NODE_TOGGLE()
        node:toggle()
      end

      local neomutt = Terminal:new { cmd = "nm", hidden = true }

      function _NEOMUTT_TOGGLE()
        neomutt:toggle()
      end

      local taskwarrior = Terminal:new { cmd = "taskwarrior-tui", hidden = true }

      function _TASKWARRIOR_TOGGLE()
        taskwarrior:toggle()
      end

      local btop = Terminal:new { cmd = "btop", hidden = true }

      function _BTOP_TOGGLE()
        btop:toggle()
      end

      local nvitop = Terminal:new { cmd = "nvtp", hidden = true }

      function _BTOP_TOGGLE()
        nvitop:toggle()
      end

      local python = Terminal:new { cmd = "python", hidden = true }

      function _PYTHON_TOGGLE()
        python:toggle()
      end
    end,
  },
}

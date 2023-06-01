return {
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
          "<C-u>",
          "<C-h>",
          "<C-b>",
          "<C-f>",
          "<C-y>",
          "<C-e>",
          "zt",
          "zz",
          "zb",
        }, -- 'gg', 'G'},
        hide_cursor = false,
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = "sine",
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false,
      }

      local t = {}
      t["<C-u>"] = {
        "scroll",
        { "-vim.wo.scroll", "true", "80", [['circular']] },
      }
      t["<C-h>"] = {
        "scroll",
        { "vim.wo.scroll", "true", "80", [['circular']] },
      }
      t["<C-d>"] = {
        "scroll",
        { "vim.wo.scroll", "true", "80", [['circular']] },
      }
      t["<C-b>"] = {
        "scroll",
        {
          "-vim.api.nvim_win_get_height(0)",
          "true",
          "80",
          [['circular']],
        },
      }
      t["<C-f>"] = {
        "scroll",
        { "vim.api.nvim_win_get_height(0)", "true", "80", [['circular']] },
      }
      t["<C-y>"] = { "scroll", { "-0.10", "true", "80", [['circular']] } }
      t["<C-e>"] = { "scroll", { "0.10", "true", "80", [['circular']] } }
      t["zt"] = { "zt", { "80", [['circular']] } }
      t["zz"] = { "zz", { "80", [['circular']] } }
      t["zb"] = { "zb", { "80", [['circular']] } }
      -- t['gg']    = {'scroll', {'-2*vim.api.nvim_buf_line_count(0)', 'true', '40', [['circular']]}}
      -- t['G']     = {'scroll', {'2*vim.api.nvim_buf_line_count(0)', 'true', '40', [['circular']]}}
      -- t["G"] = { "G", { "18" } }
      -- t["gg"] = { "gg", { "18" } }

      require("neoscroll.config").set_mappings(t)
    end,
  },
}

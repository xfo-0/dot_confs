local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    c = "@class.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<leader>cx%s", key)] = obj
    p[string.format("<leader>cX%s", key)] = obj
  end

  return n, p
end)()

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      "David-Kunz/markid",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      sync_install = false,
      ensure_installed = {
        "bash",
        "dockerfile",
        "help",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
        "org",
        "query",
        "regex",
        "latex",
        "vim",
        "yaml",
      },
      highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
      indent = { enable = true, disable = { "python" } },
      context_commentstring = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<m-space>",
          node_incremental = "<m-space>",
          scope_incremental = "<m-s>",
          node_decremental = "<m-h>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          -- keymaps = {
          --   -- You can use the capture groups defined in textobjects.scm
          --   ["aa"] = "@parameter.outer",
          --   ["ia"] = "@parameter.inner",
          --   ["af"] = "@function.outer",
          --   ["if"] = "@function.inner",
          --   ["ac"] = "@class.outer",
          --   ["ic"] = "@class.inner",
          -- },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = swap_next,
          swap_previous = swap_prev,
        },
      },
      markid = {
        enable = false,
        colors = {
          "#619e9d",
          "#9E6162",
          "#81A35C",
          "#7E5CA3",
          "#9E9261",
          "#616D9E",
          "#97687B",
          "#689784",
          "#999C63",
          "#66639C",
        },
      },
      matchup = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { "nvim-treesitter/playground", event = "VeryLazy" },
}

return {
  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },
  { "zbirenbaum/copilot-cmp", lazy = false, config = true }, -- }}}
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local neogen = require "neogen"
      local icons = require "config.icons"
      local compare = require "cmp.config.compare"
      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      cmp.setup { mapping = {} }
      vim.keymap.set("c", "<C-t>", "<Nop>")
      vim.keymap.set("c", "<C-e>", "<Nop>")
      vim.keymap.set("c", "<C-t>", '<Cmd>lua require("cmp").select_next_item()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap("c", "<C-e>", '<Cmd>lua require("cmp").select_prev_item()<CR>', { noremap = true, silent = true })
      cmp.setup {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.offset,
            compare.exact,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<Up>"] = cmp.config.disable,
          ["<Down>"] = cmp.config.disable,
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-h>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete {
            "i",
            "s",
            "c",
          },
          ["<C-x>"] = cmp.mapping.abort(),
          ["<C-s>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<C-t>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.choice_active() then
              luasnip.change_choice(1)
            elseif neogen.jumpable() then
              neogen.jump_next()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.choice_active() then
              luasnip.change_choice(-1)
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<C-o>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
        },

        sources = cmp.config.sources {
          { name = "neorg" },
          { name = "luasnip" },
          { name = "jupynium", priority = 1000 },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "cmp-git" },
          { name = "copilot" },
          { name = "buffer" },
          -- { name = "orgmode" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#282828" })
            if entry.source.name == "copilot" then
              item.kind = icons.git.Octoface
              item.kind_hl_group = "CmpItemKindCopilot"
            end
            local max_width = 0
            local source_names = {
              luasnip = "(Snippet)",
              nvim_lsp = "(LSP)",
              path = "(Path)",
              copilot = "(Copilot)",
              buffer = "(Buffer)",
            }
            local duplicates = {
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              luasnip = 1,
            }
            local duplicates_default = 0
            if max_width ~= 0 and #item.abbr > max_width then
              item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            item.kind = icons.kind[item.kind]
            item.menu = source_names[entry.source.name]
            item.dup = duplicates[entry.source.name] or duplicates_default
            return item
          end,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          documentation = {
            border = {
              "╭",
              "─",
              "╮",
              "│",
              "╯",
              "─",
              "╰",
              "│",
            },
          },
        },
      }

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline {
          ["<C-t>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            "c",
          }),
          ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {
            "c",
          }),
          ["<C-Space>"] = cmp.mapping.complete {
            "c",
          },
        },
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline {
          ["<C-t>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            "c",
          }),
          ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {
            "c",
          }),
          ["<C-Space>"] = cmp.mapping.complete {
            "c",
          },
        },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)

      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)

      -- Auto pairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "honza/vim-snippets",
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load()

          -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
          -- are stored in `ls.snippets._`.
          -- We need to tell luasnip that "_" contains global snippets:
          require("luasnip").filetype_extend("all", { "_" })
        end,
      },
    },
    build = "make install_jsregexp",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
      -- ext_opts = {
      --   [require("luasnip.util.types").choiceNode] = {
      --     active = {
      --       virt_text = { { "", "Comment" } },
      --     },
      --   },
      -- },
    },
    -- stylua: ignore
    -- keys = {
      -- {
      --   "<C-n>",
      --   function()
      --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
      --   end,
      --   expr = true, remap = true, silent = true, mode = "i",
      -- },
      -- { "<C-n>", function() require("luasnip").jump(1) end, mode = "s" },
      -- { "<C-o>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- },
		config = function(_, opts)
			-- require("luasnip").setup(opts)

			-- local snippets_folder = vim.fn.stdpath("config") .. "/lua/plugins/completion/snippets/"
			-- require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_folder })

			-- vim.api.nvim_create_user_command("LuaSnipEdit", function()
			-- 	require("luasnip.loaders.from_lua").edit_snippet_files()
			-- end, {})
		end,
  },
}

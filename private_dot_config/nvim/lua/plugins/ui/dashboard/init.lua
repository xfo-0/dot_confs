return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = require("plugins.ui.dashboard.logo")["random"]
    dashboard.section.buttons.val = {
      dashboard.button("p", " project", ":Telescope projects theme=ivy<cr>"),
      dashboard.button("s", " session", ":Telescope persisted theme=ivy<cr>"),
      dashboard.button("r", " recent file", ":FzfLua oldfiles<cr>"),
      dashboard.button("F", " find file", ":FzfLua files<cr>"),
      dashboard.button("c", "nvim (f)", ":FzfLua files cwd=~/.config/nvim/<cr>"),
      dashboard.button("C", " config file", ":FzfLua files cwd=~/.config/<cr>"),
      dashboard.button("g", " grep", ":FzfLua live_grep_native cwd=vim.fn.expand('%:p:h')<cr>"),
      dashboard.button("n", " new file", ":ene <BAR> startinsert <cr>"),
      dashboard.button("q", " quit", ":qa<cr>"),
    }
    dashboard.section.buttons.opts.spacing = 0
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    -- dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val = 8

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        -- local now = os.date "%d-%m-%Y %H:%M:%S"
        -- local version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local fortune = require "alpha.fortune"
        local quote = table.concat(fortune(), "\n")
        local plugins = stats.count .. " - " .. ms .. "ms"
        local footer = "\t" .. plugins .. "\t" .. quote
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}

return { -- lazy.nvim
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find Files", ":Telescope find_files<cr>"),
      dashboard.button("e", " " .. " New Files", ":ene <BAR> startinsert <CR>"),
      dashboard.button("o", " " .. " Recent Files", ":Telescope frecency <CR>"),
      dashboard.button("g", " " .. " Find Text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Nvim Config", [[<cmd>PossessionLoad config<CR>]]),
      dashboard.button("z", "鈴" .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      (function()
        local group = { type = "group", opts = { spacing = 0 } }
        group.val = {
          {
            type = "text",
            val = "Sessions",
            opts = {
              position = "center"
            }
          }
        }
        local path = vim.fn.stdpath("data") .. "/possession"
        local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
        for i, file in pairs(files) do
          local basename = vim.fs.basename(file):gsub("%.json", "")
          local button = dashboard.button(tostring(i), "勒 " .. basename, "<cmd>PossessionLoad " .. basename .. "<cr>")
          table.insert(group.val, button)
        end
        return group
      end)()
    }
    dashboard.section.header.val = {
      " ███▄    █  ██▒   █▓  ██  ███▄ ▄███▓",
      " ██ ▀█   █ ▓██░   █▒  ██  ██▒▀█▀ ██▒",
      "░██  ▀█ ██▒ ▓██  █▒░  ██░ ██    ▓██░",
      "░██▒  ▐▌██▒  ▒██ █░░  ██░ ██    ▒██ ",
      "▒██░   ▓██░   ▒▀█░   ░██░ ██▒   ░██▒",
      "░ ▒░   ▒ ▒    ░ ▐░   ░▓  ░ ▒░   ░  ░",
      "░ ░░   ░ ▒░   ░ ░░  ░ ▒ ░░  ░   ░  ░",
      "   ░   ░ ░       ░  ░ ▒ ░░      ░   ",
      "         ░       ░    ░            ",

    }
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)
  end,
}

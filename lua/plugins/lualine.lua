local config = function()
  local noice = require('noice')
  return {
    options = {
      icons_enabled = false,
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_x = {
        {
          color = { fg = "#d4d4d4" },
          noice.api.statusline.mode.get,
          cond = noice.api.statusline.mode.has,
        }
      },
    },
  }
end
return {
  "nvim-lualine/lualine.nvim", 
  event = "VeryLazy",
  init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
  end,
  dependencies = { 
    "folke/noice.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = config
}

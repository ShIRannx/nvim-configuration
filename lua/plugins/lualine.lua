local noice = require('noice')
require('lualine').setup {
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

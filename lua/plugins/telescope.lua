local util = require("util")

local config = function ()
  local tele = require("telescope")
  tele.load_extension('fzf')
  return {
    defaults = {
      layout_config = {
        horizontal = {
          preview_cutoff = 0,
        },
      },
    },
  }
end

return {
  'nvim-telescope/telescope.nvim', 
  keys = {
    {'<leader>sf', util.telescope('find_files'), desc = '[S]earch [F]iles' },
    {'<leader>sw', util.telescope('grep_string'), desc = '[S]earch current [W]ord' },
    {'<leader>sg', util.telescope('live_grep'), desc = '[S]earch by [G]rep' },
    {'<leader>sd', util.telescope('diagnostics'), desc = '[S]earch [D]iagnostics' }
  },
  opts = config,
  version = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

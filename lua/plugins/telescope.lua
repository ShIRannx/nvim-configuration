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
    {'gr', util.telescope('lsp_references'), '[G]oto [R]eferences'},
    {'<leader>sf', util.telescope('find_files'), desc = '[S]earch [F]iles' },
    {'<leader>sg', util.telescope('live_grep'), desc = '[S]earch by [G]rep' },
    {'<leader>ds', util.telescope('lsp_document_symbols'), '[D]ocument [S]ymbols'},
    {'<leader>sd', util.telescope('diagnostics'), desc = '[S]earch [D]iagnostics' },
    {'<leader>sw', util.telescope('grep_string'), desc = '[S]earch current [W]ord' },
    {'<leader>ws', util.telescope('lsp_dynamic_workspace_symbols'), '[W]orkspace [S]ymbols'},
  },
  opts = config,
  version = '0.1.5',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', event = "VeryLazy"}
  },
}

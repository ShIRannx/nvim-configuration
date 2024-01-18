local config = function()
  local vscode = require('vscode')
  local c = require('vscode.colors').get_colors()
  vscode.setup({
    -- Enable transparent background
    transparent = false,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    -- color_overrides = {
    --   vscLineNumber = '#FFFFFF',
    -- },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
      -- this supports the same val table as vim.api.nvim_set_hl
      -- use colors from this colorscheme by requiring vscode.colors!
      Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      -- vim-illuminate
      illuminatedWord = { bg = c.vscPopupHighlightGray },
      illuminatedCurWord = { bg = c.vscPopupHighlightGray },
      IlluminatedWordText = { bg = c.vscPopupHighlightGray },
      IlluminatedWordRead = { bg = c.vscPopupHighlightGray },
      IlluminatedWordWrite = { bg = c.vscPopupHighlightGray },
      --
      -- mini.indentscope
      MiniIndentscopeSymbol = { fg = c.vscContextCurrent, bg = 'NONE', nocombine = true },
      MiniIndentscopeSymboloff = { fg = c.vscContext, bg = 'NONE', nocombine = true },
      MiniIndentscopePrefix = { nocombine = true },
    }
  })
  vscode.load()
end

return {
  'Mofiqul/vscode.nvim', 
  config = config
}


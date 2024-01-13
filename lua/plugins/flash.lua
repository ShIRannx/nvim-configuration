local util = require("lazy.util")
local line_select = function()
  require("flash").jump({
    search = { mode = "search", max_length = 0 },
    label = { after = { 0, 0 } },
    pattern = "^"
  })
end
local jump = function() require("flash").jump() end
local block = function() require("flash").treesitter() end

return {
  'folke/flash.nvim',
  keys = {
    { '<leader>l', line_select },
    { 'ss', jump, mode = { 'n', 'x', 'o' } },
    { 'st', block, mode = { 'n', 'x', 'o' } },
  },
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = {
      -- search/jump in all windows
      multi_window = false,
    },
    modes = {
      -- options used when flash is activated through
      -- a regular search with `/` or `?`
      search = {
        -- when `true`, flash will be activated during regular search by default.
        -- You can always toggle when searching with `require("flash").toggle()`
        enabled = false,
      }
    }
  }
}

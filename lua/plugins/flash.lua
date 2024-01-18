local line_select = function()
  require("flash").jump({
    search = { mode = "search", max_length = 0 },
    label = { after = { 0, 0 } },
    pattern = "^"
  })
end

return {
  'folke/flash.nvim',
  keys = {
    { '<leader>l', line_select },
    { 's', function() require("flash").jump() end, mode = { 'n', 'x', 'o' } },
    { 'st', function() require("flash").treesitter() end, mode = { 'n', 'x', 'o' } },
    { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
    { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search", mode = { "o", "x" } },
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

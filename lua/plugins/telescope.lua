local tele = require("telescope")
tele.setup({
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
  },
})
pcall(tele.load_extension, 'fzf')

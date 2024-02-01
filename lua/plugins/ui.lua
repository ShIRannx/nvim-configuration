local util = require("util")

return {
  { 'j-hui/fidget.nvim', event = "VeryLazy" },
  {
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
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
        lualine_y = {
          { "progress", separator = "|", padding = { left = 1, right = 1 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = util.ui.fg("Normal"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = util.ui.fg("Normal"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = util.ui.fg("Debug"),
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = util.ui.fg("Special"),
          },
        },
      },
    }
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    event = "VeryLazy",
    dependencies = { "tpope/vim-dadbod" },
    keys = { { '<leader>du', "<Cmd>DBUIToggle<CR>" } }
  },
  { 
    'romgrk/barbar.nvim', 
    event = "BufReadPost", 
    keys = {
      {'<A-h>', '<Cmd>BufferPrevious<CR>'},
      {'<A-l>', '<Cmd>BufferNext<CR>'},
      -- Re-order to previous/next
      {'<A-<>', '<Cmd>BufferMovePrevious<CR>'},
      {'<A->>', '<Cmd>BufferMoveNext<CR>'},
      -- Goto buffer in position...
      {'<A-1>', '<Cmd>BufferGoto 1<CR>'},
      {'<A-2>', '<Cmd>BufferGoto 2<CR>'},
      {'<A-3>', '<Cmd>BufferGoto 3<CR>'},
      {'<A-4>', '<Cmd>BufferGoto 4<CR>'},
      {'<A-5>', '<Cmd>BufferGoto 5<CR>'},
      {'<A-6>', '<Cmd>BufferGoto 6<CR>'},
      {'<A-7>', '<Cmd>BufferGoto 7<CR>'},
      {'<A-8>', '<Cmd>BufferGoto 8<CR>'},
      {'<A-9>', '<Cmd>BufferGoto 9<CR>'},
      {'<A-0>', '<Cmd>BufferLast<CR>'},
      -- Pin/unpin buffer
      -- {'<A-p>', '<Cmd>BufferPin<CR>'},
      -- Close buffer
      {'<A-c>', '<Cmd>BufferClose<CR>'},
      -- Magic buffer-picking mode
      {'<C-p>', '<Cmd>BufferPick<CR>'},
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim", 
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = function() return 0 end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

}

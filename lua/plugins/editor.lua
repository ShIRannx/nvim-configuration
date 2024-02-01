
local util = require("util")

return {
  {
    'folke/flash.nvim',
    keys = {
      { '<leader>l',
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^"
          })
        end
      },
      { 's', function() require("flash").jump() end,              mode = { 'n', 'x', 'o' } },
      { 'S', function() require("flash").treesitter() end,        mode = { 'n', 'o' } },
      { "r", function() require("flash").remote() end,            desc = "Remote Flash",      mode = "o" },
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
  },
  {
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
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            preview_cutoff = 0,
          },
        },
      },
    },
    version = '0.1.5',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
        enabled = vim.fn.executable("make") == 1,
        config = function()
          util.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end
      }
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = { fast_wrap = {} },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      --- add spaces between parenthesis
      local npairs = require 'nvim-autopairs'
      local Rule = require 'nvim-autopairs.rule'
      local cond = require 'nvim-autopairs.conds'

      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
      npairs.add_rules {
        -- Rule for a pair with left-side ' ' and right side ' '
        Rule(' ', ' ')
        -- Pair will only occur if the conditional function returns true
            :with_pair(function(opts)
              -- We are checking if we are inserting a space in (), [], or {}
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2]
              }, pair)
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
        -- We only want to delete the pair of spaces when the cursor is as such: ( | )
            :with_del(function(opts)
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local context = opts.line:sub(col - 1, col + 2)
              return vim.tbl_contains({
                brackets[1][1] .. '  ' .. brackets[1][2],
                brackets[2][1] .. '  ' .. brackets[2][2],
                brackets[3][1] .. '  ' .. brackets[3][2]
              }, context)
            end)
      }
      -- For each pair of brackets we will add another rule
      for _, bracket in pairs(brackets) do
        npairs.add_rules {
          -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
          Rule(bracket[1] .. ' ', ' ' .. bracket[2])
              :with_pair(cond.none())
              :with_move(function(opts) return opts.char == bracket[2] end)
              :with_del(cond.none())
              :use_key(bracket[2])
          -- Removes the trailing whitespace that can occur without this
              :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
        }
      end
      -- arrow key on javascript
      npairs.add_rules {
        Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
            :use_regex(true)
            :set_end_pair_length(2),
      }
    end
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
        delay = 200,
        large_file_overrides = {
            providers = { "lsp" },
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
    end
  }
}

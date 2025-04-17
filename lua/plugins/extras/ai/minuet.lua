return {
  {
    "milanglacier/minuet-ai.nvim",
    lazy = true,
    config = function()
      require("minuet").setup({
        -- Your configuration options here
        provider = "openai_compatible",
        provider_options = {
          openai_compatible = {
            model = "deepseek-v3-250324",
            end_point = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
            api_key = "OPENAI_API_KEY",
            name = "deepseek",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
  { "nvim-lua/plenary.nvim", optional = true },
  -- optional, if you are using virtual-text frontend, nvim-cmp is not
  -- required.
  { "hrsh7th/nvim-cmp", optional = true },
  -- optional, if you are using virtual-text frontend, blink is not required.
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<A-y>"] = {
          function()
            require("minuet").make_blink_map()
          end,
          "fallback",
        },
      },
      sources = {
        -- Enable minuet for autocomplete
        default = { "lsp", "path", "buffer", "snippets", "minuet" },
        -- For manual completion only, remove 'minuet' from default
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            -- Should match minuet.config.request_timeout * 1000,
            -- since minuet.config.request_timeout is in seconds
            timeout_ms = 3000,
            score_offset = 50, -- Gives minuet higher priority among suggestions
          },
        },
      },
      -- Recommended to avoid unnecessary request
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}

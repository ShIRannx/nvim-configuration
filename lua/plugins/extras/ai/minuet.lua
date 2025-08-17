return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "VeryLazy",
    config = function()
      require("minuet").setup({
        -- Your configuration options here
        provider = "openai_compatible",
        provider_options = {
          openai_compatible = {
            model = "qwen3-coder-plus-2025-07-22",
            end_point = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
            api_key = "QWEN_API_KEY",
            name = "qwen",
            stream = true,
            optional = {
              stop = nil,
              max_tokens = nil,
            },
          },
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        ["<A-y>"] = {
          function(cmp)
            cmp.show({ providers = { "minuet" } })
          end,
        },
      },
      sources = {
        -- if you want to use auto-complete
        default = { "lsp", "path", "buffer", "snippets", "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 50,
            async = true,
          },
        },
      },
    },
    completion = { trigger = { prefetch_on_insert = false } },
  },
  {
    "lualine.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.sections then
        opts.sections = opts.sections or {}
      end
      if not opts.sections.lualine_x then
        opts.sections.lualine_x = opts.sections.lualine_x or {}
      end

      table.insert(opts.sections.lualine_x, {
        require("minuet.lualine"),
        -- the follwing is the default configuration
        -- the name displayed in the lualine. Set to "provider", "model" or "both"
        display_name = "provider",
        -- separator between provider and model name for option "both"
        -- provider_model_separator = ':',
        -- whether show display_name when no completion requests are active
        -- display_on_idle = false,
      })

      return opts
    end,
  },
}

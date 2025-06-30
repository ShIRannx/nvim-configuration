return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" } },
      { "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" } },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "volcengine",
        },
        inline = {
          adapter = "volcengine",
        },
        cmd = {
          adapter = "volcengine",
        },
      },
      adapters = {
        volcengine = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://ark.cn-beijing.volces.com/api", -- optional: default value is ollama url http://127.0.0.1:11434
              api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
              chat_url = "/v3/chat/completions", -- optional: default value, override if different
            },
            schema = {
              model = {
                default = "deepseek-v3-250324", -- define llm model to be used
              },
            },
          })
        end,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}

return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "warmer",
      highlights = {
        illuminatedWord = { bg = "$bg2" },
        illuminatedCurWord = { bg = "$bg2" },
        IlluminatedWordText = { bg = "$bg2" },
        IlluminatedWordRead = { bg = "$bg2" },
        IlluminatedWordWrite = { bg = "$bg2" },

        DiagnosticVirtualTextError = { fg = "$red" },
        DiagnosticVirtualTextWarn = { fg = "$yellow" },
        DiagnosticVirtualTextInfo = { fg = "$cyan" },
        DiagnosticVirtualTextHint = { fg = "$purple" },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}

local opt = vim.opt

-- 行号
-- opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.cmdheight = 0
-- opt.smartindent = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse = "a"

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

opt.undofile = true
-- indent-blankline
-- opt.list = true
-- opt.listchars:append "space:⋅"
-- opt.background = 'dark'
-- vim.cmd[[colorscheme dark]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format {filter = function(client) return client.name ~= "tsserver" end}]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format() ]]
vim.g.VM_maps = {
  ["I BS"] = '<C-h>', -- disable backspace mapping
}

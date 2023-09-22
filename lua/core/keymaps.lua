vim.g.mapleader = " "

local keymap = vim.keymap
-- local nmap = function(keys, func, desc)
--   if desc then
--     desc = 'LSP: ' .. desc
--   end
--
--   keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
-- end

-- ---------- 插入模式 ---------- ---
-- keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("n", "J", ":m+<CR>==")
keymap.set("n", "K", ":m-2<CR>==")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 单行或多行复制
keymap.set("n", "<A-J>", ":t.<CR>")
keymap.set("n", "<A-K>", ":t-<CR>")
keymap.set("v", "<A-J>", ":t '><CR>`[V`]")
keymap.set("v", "<A-K>", ":t '><CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- format
keymap.set("n", "<A-f>", vim.lsp.buf.format)

-- 切换buffer
-- keymap.set("n", "<A-h>", "<C-w>h")
-- keymap.set("n", "<A-l>", "<C-w>l")

-- keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- save & quit
keymap.set('n', '<C-s>', '<cmd>w<cr>')
keymap.set('i', '<C-s>', '<Esc>:w<cr>')

keymap.set('n', '<C-q>', '<cmd>qa!<cr>')

-- diag
keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- 移动
keymap.set('i', '<C-a>', '<Esc>I')
keymap.set('i', '<C-e>', '<Esc>A')
keymap.set({ 'n', 'v' }, '<C-a>', '0')
keymap.set({ 'n', 'v' }, '<C-e>', '$')

-- ---------- 插件 ---------- ---
-- nvim-tree
keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

-- aerial
keymap.set('n', '<leader>f', '<cmd>AerialToggle!<cr>')
keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
-- hop
-- keymap.set('n', 'ss', "<cmd>lua require'hop'.hint_char2()<cr>")
-- keymap.set('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>")
-- flash
keymap.set({ 'n', 'x', 'o' }, 'ss', require("flash").jump)
keymap.set('n', '<leader>l', function()
  require("flash").jump({
    search = { mode = "search", max_length = 0 },
    label = { after = { 0, 0 } },
    pattern = "^"
  })
end
)
keymap.set({ 'n', 'x', 'o' }, 'st', require("flash").treesitter)

-- barbar
-- local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- Move to previous/next
keymap.set('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
keymap.set('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Magic buffer-picking mode
keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- telescope
local builtin = require('telescope.builtin')

keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
-- keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- fterm
keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-- debugger
local dap = require('dap')
keymap.set('n', '<leader>db', '<CMD> DapToggleBreakpoint <CR>')
keymap.set('n', '<leader>sd', dap.continue)

-- luasnip
local ls = require("luasnip")
keymap.set({ "i", "s" }, "<c-l>", function()
  if ls.expandable() then
    ls.expand()
  end
end, { silent = true })
-- daddb
keymap.set('n', '<leader>du', "<Cmd>DBUIToggle<CR>")

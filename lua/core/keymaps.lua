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

-- terminal

keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- format
-- keymap.set("n", "<A-f>", vim.lsp.buf.format)

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

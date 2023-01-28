vim.g.mapleader = " "

local keymap = vim.keymap
local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 切换buffer
keymap.set("n", "<C-L>", ":bnext<CR>")
keymap.set("n", "<C-H>", ":bprevious<CR>")

keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- save
keymap.set('n', '<C-s>', '<cmd>w<cr>')
-- diag
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- ---------- 插件 ---------- ---
-- nvim-tree
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

-- aerial
keymap.set('n', '<leader>f', '<cmd>AerialToggle!<cr>')
keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
-- hop
keymap.set('n', 'ss', "<cmd>lua require'hop'.hint_char2()<cr>")
keymap.set('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>")
-- barbar
-- local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- Move to previous/next
keymap.set('n', '<A-j>', '<Cmd>BufferPrevious<CR>', opts)
keymap.set('n', '<A-k>', '<Cmd>BufferNext<CR>', opts)
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
keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- fterm
keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-- telescope 
local buf = vim.lsp.buf

nmap('<leader>rn', buf.rename, '[R]e[n]ame')
nmap('<leader>ca', buf.code_action, '[C]ode [A]ction')

nmap('gd', buf.definition, '[G]oto [D]efinition')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
nmap('gI', buf.implementation, '[G]oto [I]mplementation')
nmap('<leader>D', buf.type_definition, 'Type [D]efinition')
nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- See `:help K` for why this keymap
nmap('K', buf.hover, 'Hover Documentation')
nmap('<C-k>', buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
nmap('gD', buf.declaration, '[G]oto [D]eclaration')
nmap('<leader>wa', buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
nmap('<leader>wr', buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
nmap('<leader>wl', function() print(vim.inspect(buf.list_workspace_folders())) end, '[W]orkspace [L]ist Folders')

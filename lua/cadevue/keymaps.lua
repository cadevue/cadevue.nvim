vim.g.mapleader = " "

-- Centering on immediate movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up and center" })
vim.keymap.set("n", "G", "Gzz", { silent = true, desc = "Go to end of file and center" })
vim.keymap.set("n", "gg", "ggzz", { silent = true, desc = "Go to start of file and center" })
vim.keymap.set("n", "n", "nzzzv", { silent = true, desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, desc = "Previous search result and center" })

-- Moving selected line vertically
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
vim.keymap.set("v", "D", 'y`>o<Esc>p`[v`]', { silent = true, desc = "Duplicate selection down" })
vim.keymap.set("v", "U", 'y`>O<Esc>p`[v`]', { silent = true, desc = "Duplicate selection up" })

-- Copying selection to main clipboard
vim.keymap.set("v", "<C-c>", '"+y', { silent = true, desc = "Copy selection to clipboard" })

-- Keeping selection intact after indent
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "Indent selection and stay" })
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "Outdent selection and stay" })

-- Alt-backspace to delete word in insert mode
vim.keymap.set('i', '<A-BS>', '<C-w>', { silent = true, desc = "Delete word backward" })

-- Buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bl', ':ls<CR>', { desc = 'List buffers' })
vim.keymap.set('n', '<leader>bb', ':b ', { desc = 'Switch buffer (type name)' })

-- Close buffer but keep window
vim.keymap.set('n', '<leader>x', ':bp|bd #<CR>', { desc = 'Close buffer, keep window' })

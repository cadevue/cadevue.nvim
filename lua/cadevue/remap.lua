vim.g.mapleader = " "

-- Moving selected line vertically
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "D", 'y`>o<Esc>p`[v`]')
vim.keymap.set("v", "U", 'y`>O<Esc>p`[v`]')

-- Centering on immediate movement (credit: Primeagen as usual)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy-paste with system buffer
vim.keymap.set("v", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p", "\"+p")

-- Navigating split windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Format and selection
vim.keymap.set("n", "<C-f>", [[ma | :%s/\s\+$//e<CR>ggVG= | :noh<CR> | `a]], { silent = true })
vim.keymap.set("n", "<C-a>", "gg0VG")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Insert mode stuffs
vim.keymap.set("i", "<C-z>", "<esc>ui")

-- Clear selection
vim.keymap.set("v", ":", "<Esc>:")
vim.keymap.set("v", "<C-r>", ":s/")

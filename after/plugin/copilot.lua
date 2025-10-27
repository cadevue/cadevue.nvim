-- Accept
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

-- Dismiss
vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Dismiss()', { expr = true, silent = true })

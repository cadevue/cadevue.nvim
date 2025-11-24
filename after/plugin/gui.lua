-- Setup colorscheme
local dracula = require("dracula")
dracula.setup({
    colors = {
        orange = "#f7ab59",
        green = "#8fde76",
        purple = "#b897e8",
        pink = "#f28f9c",
    },

    show_end_of_buffer = true,
    transparent_bg = true,
})

vim.cmd.colorscheme("dracula")

-- Lualine statusbar setup
require("lualine").setup({
    options = {
        section_separators = "",
        component_separators = "",
        theme = 'dracula-nvim'
    },
})

require("bufferline").setup({
    options = {
        numbers = "ordinal", -- Shows buffer numbers
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
    },
})

vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.o.winbar = " "
    end,
})


vim.keymap.set('n', '<leader>bh', ':BufferLineMovePrev<CR>', { desc = 'Move buffer left' })
vim.keymap.set('n', '<leader>bl', ':BufferLineMoveNext<CR>', { desc = 'Move buffer right' })

-- Use bufferline's functions for buffer navigation
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })

-- Go to specific buffer by number
vim.keymap.set('n', '<A-1>', ':BufferLineGoToBuffer 1<CR>', { desc = 'Go to buffer 1' })
vim.keymap.set('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', { desc = 'Go to buffer 2' })
vim.keymap.set('n', '<A-3>', ':BufferLineGoToBuffer 3<CR>', { desc = 'Go to buffer 3' })
vim.keymap.set('n', '<A-4>', ':BufferLineGoToBuffer 4<CR>', { desc = 'Go to buffer 4' })
vim.keymap.set('n', '<A-5>', ':BufferLineGoToBuffer 5<CR>', { desc = 'Go to buffer 5' })
vim.keymap.set('n', '<A-6>', ':BufferLineGoToBuffer 6<CR>', { desc = 'Go to buffer 6' })
vim.keymap.set('n', '<A-7>', ':BufferLineGoToBuffer 7<CR>', { desc = 'Go to buffer 7' })
vim.keymap.set('n', '<A-8>', ':BufferLineGoToBuffer 8<CR>', { desc = 'Go to buffer 8' })

-- Indent-blankline setup with custom colors
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#4F383B" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#55462F" })
    vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#2E3A4C" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#4A3B2D" })
    vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#354027" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#463255" })
    vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#2C3B3E" })
end)

require("ibl").setup {
    indent = { highlight = highlight },
}

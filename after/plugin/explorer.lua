local oil = require("oil")

oil.setup({
    columns = {
        "icon",
    },
    lsp_file_methods = {
        autosave_changes = false
    },
    keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-p>"] = false,       
        ["<C-l>"] = false,
        ["<leader>r"] = "actions.refresh"
    },
    view_options = {
        -- show files and directories that start with "."
        show_hidden = true
    },
})

vim.keymap.set("n", "<leader>cd",oil.open)
vim.keymap.set("n", "<leader>cf",oil.open_float)

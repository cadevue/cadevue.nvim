local builtin = require("telescope.builtin")
local telescope = require("telescope")
local actions = require("telescope.actions")

-- Helper: detect if current directory is a Unity project
local function is_unity_project()
    return vim.fn.isdirectory("Assets") == 1 and vim.fn.isdirectory("ProjectSettings") == 1
end

-- Smart find_files: only .cs, .shader, and .asmdef in Unity projects, inside Assets
local function smart_find_files()
    if is_unity_project() then
        builtin.find_files({
            prompt_title = "Find Unity Files (.cs, .shader, .asmdef)",
            cwd = "Assets",
            find_command = { "rg", "--files", "--iglob", "*.cs", "--iglob", "*.shader", "--iglob", "*.asmdef" },
        })
    else
        local ok = pcall(builtin.git_files, { show_untracked = true })
        if not ok then builtin.find_files() end
    end
end

-- Smart live_grep: only .cs, .shader, and .asmdef in Unity projects, inside Assets
local function smart_live_grep()
    if is_unity_project() then
        builtin.live_grep({
            prompt_title = "Search Unity Files (.cs, .shader, .asmdef)",
            cwd = "Assets",
            glob_pattern = { "*.cs", "*.shader", "*.asmdef" },
        })
    else
        builtin.live_grep()
    end
end

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })

telescope.setup({
    defaults = {
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        path_display = { "smart" },
        layout_strategy = "horizontal",
        layout_config = {
            prompt_position = "top",
            preview_width = 0.6,
        },
        sorting_strategy = "ascending",
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
    pickers = {
        find_files = { hidden = true },
        buffers = { sort_lastused = true, ignore_current_buffer = true },
    },
})

-- Enable fzf-native
telescope.load_extension("fzf")

-- Keymaps
vim.keymap.set("n", "<leader>ff", smart_find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", smart_live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })

-- LSP Integration
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Find references" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

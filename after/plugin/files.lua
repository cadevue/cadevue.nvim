local oil = require("oil")
local always_hide_patterns = 
{
    "^%.%.$",  -- Parent directory entry
    "%.meta$", -- Unity .meta files
}

oil.setup({
    view_options =
    {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
            -- Hide parent directory entry "../"
            for _, pattern in ipairs(always_hide_patterns) do
                if name:match(pattern) then
                    return true
                end
            end

            return false
        end,
    }
})

vim.keymap.set("n", "<S-CR>", "<CMD>Oil<CR>", { desc = "Open parent directory" })

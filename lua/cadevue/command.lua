local function confirm_quit()
    print("What do you want to do?")
    print("1. Close current buffer")
    print("2. Quit Neovim")
    print("3. Cancel")
    print("Choice? ")

    local choice = vim.fn.getchar()           -- get a single key immediately
    choice = tonumber(vim.fn.nr2char(choice)) -- convert to number

    if choice == 1 then
        local current_buf = vim.api.nvim_get_current_buf()
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        if #bufs > 1 then
            vim.cmd("bp | bd " .. current_buf)
        else
            print("No other buffers, quitting Neovim.")
            vim.cmd("qa")
        end
    elseif choice == 2 then
        vim.cmd("qa")
    else
        print("Quit canceled")
    end
end

-- Allow capitalized W and Q to work like :w and :q
for _, cmd in ipairs({ "w", "q" }) do
    vim.api.nvim_create_user_command(cmd:upper(), function()
        vim.cmd(cmd)
    end, {})
end

vim.api.nvim_create_user_command("CustomQ", confirm_quit, {})
vim.cmd [[
  cabbrev q CustomQ
]]

function SetTwoSpaceIndent()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local bo = vim.bo[buf]
            bo.tabstop = 2
            bo.softtabstop = 2
            bo.shiftwidth = 2
        end
    end
end
vim.api.nvim_create_user_command("SetTwoSpaceIndent", SetTwoSpaceIndent, {})

function SetFourSpaceIndent()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local bo = vim.bo[buf]
            bo.tabstop = 4
            bo.softtabstop = 4
            bo.shiftwidth = 4
        end
    end
end
vim.api.nvim_create_user_command("SetFourSpaceIndent", SetFourSpaceIndent, {})

function FormatCode()
    vim.lsp.buf.format()
end
vim.api.nvim_create_user_command("FormatCode", FormatCode, {})

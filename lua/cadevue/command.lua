local function confirm_quit()
    print("What do you want to do?")
    print("1. Close current buffer")
    print("2. Quit Neovim")
    print("3. Cancel")
    print("Choice? ")

    local choice = vim.fn.getchar()  -- get a single key immediately
    choice = tonumber(vim.fn.nr2char(choice))  -- convert to number

    if choice == 1 then
        local current_buf = vim.api.nvim_get_current_buf()
        local bufs = vim.fn.getbufinfo({buflisted = 1})
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

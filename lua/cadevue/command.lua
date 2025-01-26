local commands = {'w', 'q'}

for i=1, #commands do
    vim.api.nvim_create_user_command(string.upper(commands[i]),
    function ()
        vim.cmd(commands[i])
    end,
    {}
    )
end

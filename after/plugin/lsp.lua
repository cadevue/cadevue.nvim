local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
    }),
    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, silent = true, noremap = true }
    local keymap = vim.keymap.set

    -- Hover documentation
    keymap("n", "K", vim.lsp.buf.hover, opts)

    -- Go to definition / declaration
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "gr", vim.lsp.buf.references, opts)

    -- Code actions & renaming
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap("n", "<C-.>", vim.lsp.buf.code_action, opts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics navigation
    keymap("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Previous diagnostic" }))

    keymap("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Next diagnostic" }))

    -- Signature help (function parameter hints)
    keymap("n", "<leader>sh", vim.lsp.buf.signature_help, opts)

    -- Format document
    keymap("n", "<leader>df", function()
        vim.lsp.buf.format()
    end, opts)
end

-- Clangd (C/C++)
vim.lsp.config("clangd", {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "clangd", "--background-index" }, -- keeps an index in the background
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- Pyright (Python)
vim.lsp.config("pyright", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
            },
        },
    },
})

-- Omnisharp (C#)
vim.lsp.config("omnisharp", {
    cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Golang (gopls)
vim.lsp.config("gopls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
})

-- Lua Language Server (Neovim config/dev)
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT", -- Use LuaJIT runtime for Neovim
            },
            diagnostics = {
                globals = { "vim" }, -- Recognize `vim` as a global variable
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "",
            [vim.diagnostic.severity.INFO]  = "",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})

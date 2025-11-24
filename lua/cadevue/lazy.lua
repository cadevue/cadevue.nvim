-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugin list
local plugins = {
    -- icons and themes
    { 'nvim-tree/nvim-web-devicons' },
    { 'Mofiqul/dracula.nvim' },

    -- statusline
    { 'nvim-lualine/lualine.nvim' },

    -- file explorer / oil
    {
        'stevearc/oil.nvim',
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
    },

    -- LazyGit integration
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit", "LazyGitConfig", "LazyGitCurrentFile",
            "LazyGitFilter", "LazyGitFilterCurrentFile"
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
    },

    -- LSP & Mason
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason.nvim", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts = {},
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({})

            -- integrate with nvim-cmp
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },

    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },

    -- GitHub Copilot
    {
        "zbirenbaum/copilot.lua",
        requires = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
        },
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = { enabled = true },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },

    -- Buffer Line
    { 'akinsho/bufferline.nvim', version = "*" },

    -- Git Blame
    {
        "f-person/git-blame.nvim",
        opts = {
            enabled = false,
            message_template = "<<sha>><summary> • <author>", -- template for the blame message, check the Message template section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },
    }
}

-- setup lazy.nvim
require('lazy').setup(plugins)

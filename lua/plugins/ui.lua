return {
    -- Better Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            theme = 'auto',
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'filesize', 'fileformat', 'filetype' },
                lualine_y = {},
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        },
        config = function(_, opts)
            require('lualine').setup { options = opts }
        end
    },


    -- Starter
    {
        'echasnovski/mini.starter',
        event = "VimEnter",
        version = false,
        opts = {
            footer = "Come on then...",
            items = {
                {
                    name = "Browser",
                    action = ":e .",
                    section = "Files"
                },
                {
                    name = "Find Files",
                    action = function() require('telescope.builtin').find_files() end,
                    section = "Files"
                },
                {
                    name = "Live Grep",
                    action = function() require('telescope.builtin').live_grep() end,
                    section = "Files"
                },
                function() return require('mini.starter').sections.recent_files() end,
                function() return require('mini.starter').sections.builtin_actions() end,
            },
            query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.'
        }
    },

    -- Load last color on startup
    {
        "raddari/last-color.nvim",
        priority = 1000,
        lazy = false, -- Loads on startup
        config = function()
            local theme = require('last-color').recall() or 'gruvbox'
            vim.cmd('colorscheme ' .. theme)
        end
    },

    -- Colorschemes
    {
        "folke/tokyonight.nvim",
        opts = { style = "moon" },
    },
    {
        'navarasu/onedark.nvim',
        opts = { style = 'cool' },
    },
    { 'ellisonleao/gruvbox.nvim', },
    {
        'projekt0n/github-nvim-theme',
        config = true,
        main = 'github-theme',
    },
    'sainnhe/everforest',
    'NLKNguyen/papercolor-theme',
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    }
}

return {
    -- Telescope!
    {
        'nvim-telescope/telescope.nvim',
        version = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzy-native.nvim",
                build = "make",
                enabled = vim.fn.executable("make") == 1,
            },
            "debugloop/telescope-undo.nvim"
        },
        keys = {
            { "<leader><leader>", function() require('telescope.builtin').git_files() end },
            { "<leader>ff", function() require('telescope.builtin').find_files() end },
            { "<leader>fg", function() require('telescope.builtin').live_grep() end },
            { "<leader>fr", function() require('telescope.builtin').oldfiles() end },
            { "<leader>fj", function() require('telescope.builtin').jumplist() end },
            { "<leader>fk", function() require('telescope.builtin').keymaps() end },
            { "<leader>fs", function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end },
            { "<leader>fu", function() require('telescope').extensions.undo.undo() end },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
            require('telescope').load_extension('fzy_native')
        end,
    },


    -- Oil!
    {
        "stevearc/oil.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        cmd = "Oil",
        event = "VimEnter *", -- TODO: Change this to only run when nvim is opened with a directory
        keys = {
            { "-", "<CMD>Oil --float<CR>", desc = "Open Oil in current dir (float)" },
        },
        opts = {
            default_file_explorer = true,
            columns = {
                "icon",
            },
            skip_confirm_for_simple_edits = true,
            constrain_cursor = "editable",
        },
    },

    -- Tabout
    {
        "abecodes/tabout.nvim",
        keys = { { "<Tab>", mode = "i" } },
        config = true,
    },

    -- Global search & replace
    {
        "nvim-pack/nvim-spectre",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = "Spectre",
        keys = {
            { "<leader>/", function() require("spectre").open_visual({select_word=true}) end, desc = "Search current word" }
        },
        config = function() require('spectre').setup() end,
    }
}

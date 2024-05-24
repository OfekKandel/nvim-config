return {
    -- Treesitter (& objects)
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/nvim-treesitter-context" },
        main = "nvim-treesitter.configs",
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
        build = ":TSUpdate",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        -- ["<="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                        -- [">="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                        ["ai"] = { query = "@conditional.outer", desc = "[treesitter]Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "[treesitter]Select inner part of a conditional" },

                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

                        ["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
                        ["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
                        ["<leader>nm"] = "@function.outer", -- swap function with next
                    },
                    swap_previous = {
                        ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
                        ["<leader>pm"] = "@function.outer", -- swap function with previous
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
                        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
                        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                    },
                },
            }
        },
    },

    -- Pairs
    {
        'echasnovski/mini.pairs',
        version = false,
        keys = {
            { '(', mode = 'i' },
            { '[', mode = 'i' },
            { '{', mode = 'i' },
            { ')', mode = 'i' },
            { ']', mode = 'i' },
            { '}', mode = 'i' },
            { '"', mode = 'i' },
            { "'", mode = 'i' },
            { '`', mode = 'i' },
        },
        config = true,
    },

    -- Surround
    {
        'echasnovski/mini.surround',
        version = false,
        keys = {
            { 'sa', desc = "[mini.surround] Add surrounding in Normal and Visual modes", mode = { 'n', 'v' } },
            { 'sd', desc = "[mini.surround] Delete surrounding" },
            { 'sf', desc = "[mini.surround] Find surrounding (to the right)" },
            { 'sF', desc = "[mini.surround] Find surrounding (to the left)" },
            { 'sh', desc = "[mini.surround] Highlight surrounding" },
            { 'sr', desc = "[mini.surround] Replace surrounding" },
            { 'sn', desc = "[mini.surround] Update `n_lines`" },
        },
        opts = {
            mappings = {
                suffix_last = 'p', -- Suffix to search with "prev" method
                suffix_next = 'n', -- Suffix to search with "next" method
            },
        }
    },

    -- Comment
    {
        'echasnovski/mini.comment',
        version = false,
        keys = {
            { 'gc',  mode = { 'n', 'v' },                                                                                                                                             desc = "[mini.comment] Toggle comment for both Normal and Visual modes" },
            { 'gcc', desc = "[mini.comment] Toggle comment on current line" },
            { 'gc',  mode = 'v',                                                                                                                                                      desc = "[mini.comment] Toggle comment on visual selection" },
            { 'gc',  desc = "[mini.comment] Define 'comment' textobject (like `dgc` - delete whole comment block) Works also in Visual mode if mapping differs from `comment_visual`" },
        },
        config = true,
    },

    -- TODO Comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufEnter",
        config = true,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        main = "ibl",
        opts = {},
    }
}

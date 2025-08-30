return {
    -- LSP & Mason
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" }, -- Loads on startup, after UI
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp", "linrongbin16/lsp-progress.nvim", "antosha417/nvim-lsp-file-operations" },
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                -- underline = true,
                update_in_insert = true,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                },
                severity_sort = true,
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(opts.diagnostics)
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_nvim_lsp.default_capabilities()
            lspconfig["sourcekit"].setup({
                capabilities = capabilities,
            })
        end,
        keys = {
            { "gd",         vim.lsp.buf.definition,                             desc = "(LSP) Goto Definition" },
            { "gD",         vim.lsp.buf.declaration,                            desc = "(LSP) Goto Declaration" },
            { "gr",         vim.lsp.buf.references,                             desc = "(LSP) Goto References" },
            { "gi",         vim.lsp.buf.implementation,                         desc = "(LSP) Goto Implementation" },
            { "gT",         vim.lsp.buf.type_definition,                        desc = "(LSP) Goto Type definition" },
            { "K",          vim.lsp.buf.hover,                                  desc = "(LSP) Hover" },
            { "<c-k>",      vim.lsp.buf.signature_help,                         desc = "(LSP) Signature Help",                mode = 'i' },
            { "<leader>ca", vim.lsp.buf.code_action,                            desc = "(LSP) Code Action" },
            { '<leader>cd', vim.diagnostic.open_float,                          desc = "(LSP) Diagnostics - Line diagnostics" },
            { "<leader>rn", vim.lsp.buf.rename,                                 desc = "(LSP) ReName" },
            { '<leader>F',  function() vim.lsp.buf.format { async = true } end, desc = "(LSP) Foramt file" },
        }
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "FelipeLema/cmp-async-path",
            "onsails/lspkind.nvim",
        },
        event = "InsertEnter",
        opts = function()
            local cmp = require('cmp')
            return {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
                    { name = 'async_path' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
                            vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
            }
        end
    },

    -- Snippet client (LuaSnip)
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function(_, _)
            require("luasnip.loaders.from_vscode").lazy_load()
            local ls = require("luasnip")
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node
            ls.add_snippets('cpp', {
                s("ndocs", {
                    t("/* [DOCS NEEDED] */")
                })
            })
        end,
        keys = {
            { "<C-l>", function() require('luasnip').jump(1) end,  desc = "Progress in snippet", mode = "i" },
            { "<C-h>", function() require('luasnip').jump(-1) end, desc = "Progress in snippet", mode = "i" }
        },
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip" }
    },

    -- Trouble (diagnostics)
    {
        "folke/trouble.nvim",
        cmd = { 'Trouble' },
        keys = {
            { "<leader>xx", function() require("trouble").toggle() end,                        desc = "Trouble - Open" },
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = "Trouble - Open Document" },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Trouble - Open Workspace" },
            { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = "Trouble - Quickfix" },
            { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = "Trouble - Loclist" },
            { "<leader>xt", ":TodoTrouble<CR>",                                                desc = "Trouble - Todos" },
            { "gr",         function() require("trouble").toggle("lsp_references") end,        desc = "LSP - Trouble References" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons", "neovim/nvim-lspconfig" },
        opts = {},
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            PATH = "prepend"
        },
        cmd = { "Mason" },
        build = ":MasonUpdate",
    },

    -- Mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            handlers = {
                function(server_name)
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
                -- ["omnisharp"] = function()
                --     require("lspconfig").omnisharp.setup {
                --         cmd = { "dotnet", "/Users/ofek/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
                --         enable_editorconfig_support = true,
                --         -- Enables support for roslyn analyzers, code fixes and rulesets.
                --         enable_roslyn_analyzers = true,
                --         organize_imports_on_format = true,
                --         enable_import_completion = true,
                --     }
                -- end
            }
        }
    },

    -- LSP Progress
    {
        'linrongbin16/lsp-progress.nvim',
        config = true
    },


    -- Extra functionality
    { "antosha417/nvim-lsp-file-operations", config = true }
}

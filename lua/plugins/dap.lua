return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text', 'jay-babu/mason-nvim-dap.nvim' },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            {
                "<leader>dB",
                function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                desc = "Breakpoint Condition"
            },
            { "<leader>dc", function() require("dap").continue() end,          desc = "Debug Continue" },
            { "<leader>da", function() require("dap").continue() end,          desc = "Debug Run" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,     desc = "Debug Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end,             desc = "Debug Go to line (no execute)" },
            { "<leader>di", function() require("dap").step_into() end,         desc = "Debug Step Into" },
            { "<leader>dj", function() require("dap").down() end,              desc = "Debug Down" },
            { "<leader>dk", function() require("dap").up() end,                desc = "Debug Up" },
            { "<leader>dl", function() require("dap").run_last() end,          desc = "Debug Run Last" },
            { "<leader>do", function() require("dap").step_over() end,         desc = "Debug Step Over" },
            { "<leader>dO", function() require("dap").step_out() end,          desc = "Debug Step Out" },
            { "<leader>dp", function() require("dap").pause() end,             desc = "Debug Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Debug Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,           desc = "Debug Session" },
            { "<leader>dt", function() require("dap").terminate() end,         desc = "Debug Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "Debug Widgets" },
        },
        config = function()
            require('dap.ext.vscode').load_launchjs()
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = "nvim-neotest/nvim-nio",
        keys = {
            { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,   desc = "Eval",  mode = { "n", "v" } },
        },
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            ensure_installed = {},

            automatic_installation = true,
            handlers = {
                function(config)
                    -- all sources with no handler get passed here

                    -- Keep original functionality
                    require('mason-nvim-dap').default_setup(config)
                end,
                coreclr = function(config)
                    config.adapters = {
                        type = 'executable',
                        command = '/usr/local/bin/netcoredbg/netcoredbg',
                        args = { '--interpreter=vscode' }
                    }
                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,
            },
        },
    }
}

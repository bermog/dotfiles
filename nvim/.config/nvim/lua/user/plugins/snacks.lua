-- Based on https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            sources = {
                -- Show hidden files, keep respecting .gitignore
                files = { hidden = true },
                grep = { hidden = true },
                explorer = {
                    hidden = true,
                    win = {
                        list = {
                            wo = {
                                number = true,
                                relativenumber = true,
                            },
                        },
                    },
                },
            },
        },
        explorer = {
            enabled = true,
        },
        -- Render line numbers, gitsigns hunks and diagnostic signs in a single
        -- column: diagnostics/marks on the left, fold/git signs on the right.
        statuscolumn = {
            enabled = true,
        },
    },
    keys = {
        {
            '<leader>tf',
            function()
                Snacks.picker.files()
            end,
            desc = 'Find files',
        },
        {
            '<leader>pv',
            function()
                Snacks.explorer()
            end,
            desc = 'Open file explorer',
        },
        {
            '<C-t>',
            function()
                Snacks.picker.git_files()
            end,
            desc = 'Git files',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git branches',
        },
        {
            '<leader>th',
            function()
                Snacks.picker.help()
            end,
            desc = 'Help tags',
        },
        {
            '<leader>tw',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
    },
}

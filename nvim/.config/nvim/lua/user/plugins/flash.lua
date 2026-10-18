-- Jump navigation: labels, enhanced f/t/F/T motions, Treesitter selection.
-- https://github.com/folke/flash.nvim
return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
        modes = {
            -- Show jump labels for f/t/F/T so any on-screen match is one keystroke away
            char = { jump_labels = true },
        },
    },
    keys = {
        {
            's',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        -- Visual-mode S stays mapped to mini.surround (add surrounding)
        {
            'S',
            mode = { 'n', 'o' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },
        {
            'r',
            mode = 'o',
            function()
                require('flash').remote()
            end,
            desc = 'Remote Flash',
        },
        {
            'R',
            mode = { 'o', 'x' },
            function()
                require('flash').treesitter_search()
            end,
            desc = 'Treesitter Search',
        },
        {
            '<c-s>',
            mode = 'c',
            function()
                require('flash').toggle()
            end,
            desc = 'Toggle Flash Search',
        },
    },
}

-- Add, change, and delete surrounding text
-- mini.surround configured to mimic tpope/vim-surround (see :h MiniSurround-vim-surround-config)
return {
    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = 'ys', -- ys{motion}{char}, or S in visual mode
                delete = 'ds',
                find = '',
                find_left = '',
                highlight = '',
                replace = 'cs',
                suffix_last = '',
                suffix_next = '',
            },
            search_method = 'cover_or_next',
        },
        config = function(_, opts)
            require('mini.surround').setup(opts)

            -- Remap adding surrounding to Visual mode selection
            vim.keymap.del('x', 'ys')
            vim.keymap.set(
                'x',
                'S',
                [[:<C-u>lua MiniSurround.add('visual')<CR>]],
                { silent = true, desc = 'Add surrounding' }
            )

            -- Make special mapping for "add surrounding for line"
            vim.keymap.set('n', 'yss', 'ys_', { remap = true, desc = 'Surround whole line' })
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            spec = {
                { '<leader>g', group = 'Git' },
                { '<leader>h', group = 'Hunks' },
                { '<leader>t', group = 'Pickers' },
            },
        },
    },
}

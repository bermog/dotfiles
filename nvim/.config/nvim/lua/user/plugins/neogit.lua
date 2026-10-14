return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
    },
    keys = {
        { '<leader>gs', '<Cmd>Neogit<CR>', desc = 'Open Neogit' },
        { '<leader>gc', '<Cmd>Neogit commit<CR>', desc = 'Neogit commit' },
        { '<leader>gp', '<Cmd>Neogit pull<CR>', desc = 'Neogit pull' },
        { '<leader>gP', '<Cmd>Neogit push<CR>', desc = 'Neogit push' },
    },
    config = true,
}

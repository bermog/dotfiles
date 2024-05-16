return {
    "NeogitOrg/neogit",
    commit = "bc0c609",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        { '<leader>gs', '<Cmd>Neogit<CR>' },
        { '<leader>gc', '<Cmd>Neogit commit<CR>' },
        { '<leader>gp', '<Cmd>Neogit pull<CR>' },
        { '<leader>gP', '<Cmd>Neogit push<CR>' },
    },
    config = true
}

return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>tf', '<Cmd>Telescope find_files<CR>' },
        { '<leader>gb', '<Cmd>Telescope git_branches<CR>' },
        { '<C-t>', '<Cmd>Telescope git_files<CR>' },
        { '<leader>th', '<Cmd>Telescope help_tags<CR>' },
        { '<leader>of', '<Cmd>ObsidianQuickSwitch<CR>' },
        { '<leader>ow', '<Cmd>ObsidianSearch<CR>' },
        { '<leader>ot', '<Cmd>ObsidianTags<CR>' },
        {
            '<leader>tw', function()
                require('telescope.builtin').grep_string({
                    search = vim.fn.input('Grep > ')
                })
            end
        },
    },
    config = function()
        require('telescope').setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = function()
                        return { '--hidden', '--glob', '!**/.git/*' }
                    end,
                },
                grep_string = {
                    additional_args = function()
                        return { '--hidden', '--glob', '!**/.git/*' }
                    end,
                },
            },
        })
    end,
}

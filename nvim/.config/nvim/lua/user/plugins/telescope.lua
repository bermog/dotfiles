return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>pf', '<Cmd>Telescope find_files<CR>' },
        { '<leader>gb', '<Cmd>Telescope git_branches<CR>' },
        { '<C-p>', '<Cmd>Telescope git_files<CR>' },
        {
            '<leader>pw', function()
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

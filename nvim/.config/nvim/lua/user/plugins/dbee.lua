return {
    {
        'kndndrj/nvim-dbee',
        dependencies = {
            'MunifTanjim/nui.nvim',
            { 'MattiasMTS/cmp-dbee', ft = 'sql' },
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require('dbee').install()
        end,
        config = function()
            require('cmp').setup.buffer { sources = { { name = 'cmp-dbee' } } }

            require('dbee').setup({
                drawer = {
                    disable_help = true,
                    window_options = {
                        relativenumber = true,
                    }
                },
                call_log = {
                    window_options = {
                        relativenumber = true,
                    }
                },
            })

            vim.keymap.set('n', '<leader>b', '<Cmd>Dbee toggle<CR>')
            vim.keymap.set('n', '<leader>q', '<Cmd>Dbee close<CR>:q<CR>')
        end,
    },
}

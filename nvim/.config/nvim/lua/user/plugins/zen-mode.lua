return {
    'folke/zen-mode.nvim',
    dependencies = { 'folke/twilight.nvim' },
    keys = {
        { '<leader>z', '<Cmd>ZenMode<CR>', desc = 'Toggle zen mode' },
    },
    opts = {
        window = {
            backdrop = 1,
            width = 120,
            height = 1,
            options = {
                signcolumn = 'no', -- disable signcolumn
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
            },
        },
        plugins = {
            -- disable some global vim options (vim.o...)
            options = {
                enabled = true,
                ruler = true, -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
                -- turn off the statusline in zen mode ('laststatus' == 3 shows it globally)
                laststatus = 0,
            },
            twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
            gitsigns = { enabled = false }, -- disables git signs
            tmux = { enabled = true }, -- disables the tmux statusline
        },
    },
    config = function(_, opts)
        require('zen-mode').setup(opts)

        -- Work around a bug where the tmux status remains disabled after quitting vim in zen mode
        -- https://github.com/folke/zen-mode.nvim/issues/111
        vim.api.nvim_create_autocmd({ 'VimLeave' }, {
            callback = function()
                os.execute('tmux set-option status on')
            end,
        })
    end,
}

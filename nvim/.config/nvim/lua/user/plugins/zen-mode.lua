return {
    "folke/zen-mode.nvim",
    dependencies = { 'folke/twilight.nvim' },
    keys = {
        { '<leader>z', '<Cmd>ZenMode<CR>' },
    },
    opts = {
        window = {
            backdrop = 1,
            width = 120,
            height = 1,
            options = {
                signcolumn = "no",      -- disable signcolumn
                number = false,         -- disable number column
                relativenumber = false, -- disable relative numbers
                -- cursorline = false,     -- disable cursorline
                -- cursorcolumn = false,   -- disable cursor column
                -- foldcolumn = "0",       -- disable fold column
                -- list = false,           -- disable whitespace characters
            },
        },
        plugins = {
            -- disable some global vim options (vim.o...)
            options = {
                enabled = true,
                ruler = true,    -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
                -- you may turn on/off statusline in zen mode by setting 'laststatus'
                -- statusline will be shown only if 'laststatus' == 3
                laststatus = 0,             -- turn off the statusline in zen mode
            },
            twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
            gitsigns = { enabled = false }, -- disables git signs
            tmux = { enabled = true },      -- disables the tmux statusline
        },

        -- Work around a bug where the tmux status remains disabled after quitting vim in zen mode
        -- https://github.com/folke/zen-mode.nvim/issues/111
        vim.api.nvim_create_autocmd({ "VimLeave" }, {
            callback = function()
                os.execute("tmux set-option status on")
            end,
        })
    }
}

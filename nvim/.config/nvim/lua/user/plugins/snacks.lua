-- Based on https://github.com/folke/snacks.nvim/blob/main/docs/picker.md

-- Hide/show the tmux statusline (only when running inside tmux). Used by zen
-- mode: disabled on open, restored on close.
local function tmux_status(state)
    if vim.env.TMUX then
        vim.fn.system({ 'tmux', 'set-option', 'status', state })
    end
end

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
        -- Zen mode (replaces zen-mode.nvim + twilight.nvim). Dimming is off,
        -- matching the previous twilight-disabled setup.
        zen = {
            toggles = { dim = false },
            win = {
                width = 120,
                wo = {
                    signcolumn = 'no',
                    number = false,
                    relativenumber = false,
                },
            },
            on_open = function()
                tmux_status('off')
            end,
            on_close = function()
                tmux_status('on')
            end,
        },
    },
    config = function(_, opts)
        require('snacks').setup(opts)

        -- Guard against quitting nvim while zen is open, which would otherwise
        -- leave the tmux statusline hidden (zen-mode.nvim#111)
        vim.api.nvim_create_autocmd('VimLeave', {
            callback = function()
                tmux_status('on')
            end,
        })
    end,
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
        {
            '<leader>z',
            function()
                Snacks.zen()
            end,
            desc = 'Toggle zen mode',
        },
    },
}

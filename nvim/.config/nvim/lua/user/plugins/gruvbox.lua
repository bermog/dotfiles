return {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('gruvbox').setup({
            contrast = 'hard',
            overrides = {
                -- gruvbox only applies `contrast` to Normal's bg0; lift floats one
                -- tone above the hard bg (#1d2021 -> #282828) so they read as raised
                NormalFloat = { bg = '#282828' },
                Pmenu = { bg = '#282828' },
                -- selection bg defaults to gruvbox blue (#83a598, reads as cyan);
                -- use cream with a dark fg so the selected item stays readable
                PmenuSel = { fg = '#504945', bg = '#ebdbb2', bold = true },
                PmenuSbar = { bg = '#3c3836' },
                MatchParen = { bg = '#32302f' },
                ZenBg = { bg = '#1d2021' },
            },
        })
        vim.cmd([[colorscheme gruvbox]])
    end,
}

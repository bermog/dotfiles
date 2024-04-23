return {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('gruvbox').setup({
            contrast = 'hard',
            overrides = {
                MatchParen = { bg = '#32302f' },
            },
        })
        vim.cmd([[colorscheme gruvbox]])
    end,
}

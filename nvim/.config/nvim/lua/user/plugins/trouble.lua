-- Pretty list for diagnostics, LSP symbols/references, quickfix and loclist.
-- Icons come from the defaults (no nvim-web-devicons dependency; mini.icons
-- is kept for other plugins).
return {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
        { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
        { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
        { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols' },
        {
            '<leader>xl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'LSP definitions / references / ...',
        },
        { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
        { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
    },
    opts = {},
}

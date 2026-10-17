return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            theme = 'gruvbox',
            globalstatus = true,
        },
        sections = {
            lualine_c = { { 'filename', path = 1 } },
        },
        inactive_sections = {
            lualine_c = { { 'filename', path = 1 } },
        },
        extensions = { 'lazy' },
    },
}

return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    -- Completion source is wired up in blink.lua (blink.compat + per_filetype)
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'dbout',
            callback = function()
                vim.wo.foldenable = false
            end,
        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'DBUIOpened',
            callback = function()
                vim.opt.relativenumber = true
            end,
        })
    end,
}

-- Completion engine, replacing nvim-cmp
-- LuaSnip is kept as the snippet engine so the snipmate-format snippets/ keep working
return {
    'saghen/blink.cmp',
    version = '*', -- use prebuilt binaries from releases
    dependencies = {
        'L3MON4D3/LuaSnip',
        { 'saghen/blink.compat', version = '*', opts = {} }, -- runs nvim-cmp sources (vim-dadbod-completion)
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
        -- Load custom snipmate snippets
        require('luasnip.loaders.from_snipmate').lazy_load()

        require('blink.cmp').setup({
            keymap = {
                preset = 'default',
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-y>'] = { 'select_and_accept' },
                ['<C-Space>'] = { 'show' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            },
            -- Use LuaSnip instead of the built-in snippet engine
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                compat = { 'vim-dadbod-completion' },
                -- dadbod only makes sense in SQL-ish buffers
                per_filetype = {
                    sql = { 'vim-dadbod-completion', 'lsp', 'path', 'buffer' },
                    mysql = { 'vim-dadbod-completion', 'lsp', 'path', 'buffer' },
                    plsql = { 'vim-dadbod-completion', 'lsp', 'path', 'buffer' },
                    dbout = { 'vim-dadbod-completion', 'lsp', 'path', 'buffer' },
                },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
            },
        })
    end,
}

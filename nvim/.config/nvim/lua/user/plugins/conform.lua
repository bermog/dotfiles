return {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
        {
            '<leader>f', function()
                require('conform').format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end
        },
    },
    opts = {
        formatters_by_ft = {
            php = { 'pint' },
            blade = { 'blade-formatter' },
        },
        notify_on_error = true,
    },
}

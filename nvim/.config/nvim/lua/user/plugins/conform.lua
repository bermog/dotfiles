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
            php = { 'php-cs-fixer' },
            blade = { 'blade-formatter' },
        },
        formatters = {
            ['php-cs-fixer'] = {
                command = 'php-cs-fixer',
                args = {
                    'fix',
                    '--rules=@PSR12',
                    '$FILENAME',
                },
                stdin = false,
            },
        },
        notify_on_error = true,
    },
}

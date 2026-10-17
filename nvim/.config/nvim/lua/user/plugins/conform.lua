return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format({
                    lsp_format = 'fallback',
                    async = true,
                    timeout_ms = 2000,
                })
            end,
            desc = 'Format buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            php = { 'pint' },
            blade = { 'blade-formatter' },
            lua = { 'stylua' },
            go = { 'goimports' },
            python = { 'ruff_format' },
            javascript = { 'prettierd', 'prettier', stop_after_first = true },
            javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            typescript = { 'prettierd', 'prettier', stop_after_first = true },
            typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            vue = { 'prettierd', 'prettier', stop_after_first = true },
            css = { 'prettierd', 'prettier', stop_after_first = true },
            html = { 'prettierd', 'prettier', stop_after_first = true },
            json = { 'prettierd', 'prettier', stop_after_first = true },
            jsonc = { 'prettierd', 'prettier', stop_after_first = true },
            yaml = { 'prettierd', 'prettier', stop_after_first = true },
            markdown = { 'prettierd', 'prettier', stop_after_first = true },
            astro = { 'prettierd', 'prettier', stop_after_first = true },
        },
        notify_on_error = true,
    },
}

-- Linting, complementing conform.nvim (formatting)
return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            php = { 'phpstan' },
            javascript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescript = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            vue = { 'eslint_d' },
            go = { 'golangci_lint' },
            lua = { 'selene' },
        }

        -- Lint on save, and when opening a file (covers opening without writing)
        local group = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = group,
            callback = function()
                lint.try_lint()
            end,
        })
        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
            group = group,
            callback = function()
                -- Only lint buffers that have a file on disk
                if vim.api.nvim_buf_get_name(0) ~= '' then
                    lint.try_lint()
                end
            end,
        })
    end,
}

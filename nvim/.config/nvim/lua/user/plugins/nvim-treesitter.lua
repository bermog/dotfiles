-- NOTE: nvim-treesitter was rewritten on the `main` branch; the old
-- `master` branch API (nvim-treesitter.configs.setup) no longer exists.
-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/7901
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- main branch does not support lazy-loading
    build = ':TSUpdate',
    config = function()
        -- Manual blade parser: registered here, installed with ':TSInstall blade'
        -- https://github.com/EmranMR/tree-sitter-blade/discussions/19
        vim.api.nvim_create_autocmd('User', {
            pattern = 'TSUpdate',
            callback = function()
                require('nvim-treesitter.parsers').blade = {
                    install_info = {
                        url = 'https://github.com/EmranMR/tree-sitter-blade',
                        files = { 'src/parser.c' },
                        branch = 'main',
                    },
                    maintainers = {},
                }
            end,
        })

        require('nvim-treesitter').setup({})

        -- Install parsers (async no-op if already installed)
        require('nvim-treesitter').install({
            'c',
            'lua',
            'vim',
            'vimdoc',
            'luadoc',
            'query',
            'php',
            'php_only',
            'sql',
            'javascript',
            'typescript',
            'html',
            'css',
            'vue',
            'astro',
            'angular',
            'python',
            'bash',
            'markdown',
            'markdown_inline',
            'json',
            'ini',
            'xml',
            'yaml',
            'go',
            'blade',
        })

        -- Highlighting is no longer a plugin module on main; enable it
        -- per-filetype with the runtime's vim.treesitter.start()
        local highlight_filetypes = {
            'c',
            'lua',
            'vim',
            'vimdoc',
            'php',
            'sql',
            'javascript',
            'typescript',
            'html',
            'htmlangular',
            'css',
            'vue',
            'astro',
            'python',
            'bash',
            'markdown',
            'json',
            'ini',
            'xml',
            'yaml',
            'go',
            'blade',
        }
        vim.api.nvim_create_autocmd('FileType', {
            pattern = highlight_filetypes,
            callback = function(ev)
                vim.treesitter.start(ev.buf)
            end,
        })

        -- Treesitter-based indentation is experimental on main and opt-in.
        -- Kept off for now; runtime filetype indent (plus after/indent/php.vim
        -- for PHP) covers us. To try it, add to an ftplugin:
        --   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
}

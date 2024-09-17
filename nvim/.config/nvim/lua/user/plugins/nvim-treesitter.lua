return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
        -- Manual blade parser - Install with ':TSInstall blade'
        -- https://github.com/EmranMR/tree-sitter-blade/discussions/19
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade", -- local path or git repo
                files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
                -- optional entries:
                branch = "main",            -- default branch in case of git repo if different from master
                generate_requires_npm = false, -- if stand-alone parser without npm dependencies
                requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            }
        }

        require('nvim-treesitter.configs').setup {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                'c', 'lua', 'vim', 'vimdoc', 'query',
                'php', 'sql', 'javascript', 'html', 'css',
                'vue', 'python', 'bash', 'markdown', 'markdown_inline',
                'json', 'ini', 'xml', 'yaml', 'php_only',
                'go', 'typescript', 'astro'
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            -- Needed since treesitter highlight disables autoindent for PHP files
            -- https://laracasts.com/discuss/channels/general-discussion/auto-indentation-not-working-on-php-files-neovim
            indent = {
                enable = true,
            },
        }
    end
}

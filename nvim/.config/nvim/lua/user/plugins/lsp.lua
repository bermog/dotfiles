-- Native Neovim LSP setup, see :h lsp-config
return {
    {
        'mason-org/mason.nvim',
        lazy = false,
        opts = {},
    },
    {
        -- mason 2.0 dropped `ensure_installed` from setup(); this plugin
        -- auto-installs formatters (conform) and linters (nvim-lint) on start
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        lazy = false,
        dependencies = { 'mason-org/mason.nvim' },
        opts = {
            ensure_installed = {
                -- Formatters
                'pint',
                'blade-formatter',
                'prettierd',
                'stylua',
                'goimports',
                -- Linters
                'phpstan',
                'eslint_d',
                'golangci-lint',
                'selene',
                'ruff',
            },
        },
    },
    {
        'mason-org/mason-lspconfig.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
            'saghen/blink.cmp',
        },
        config = function()
            -- Completion capabilities for every server. Pass include_nvim_defaults
            -- so the standard LSP capabilities (hover, semantic tokens, inlay
            -- hints, ...) are not dropped by blink's completion table.
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
            })

            -- Buffer keymaps on attach. Built-ins already provide K (hover),
            -- gra (code action), grr (references), gri, grn, grt, <C-s>
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local map = function(keys, fn, desc)
                        vim.keymap.set('n', keys, fn, { buffer = ev.buf, desc = desc })
                    end
                    map('gd', vim.lsp.buf.definition, 'Goto definition')
                    map('gD', vim.lsp.buf.declaration, 'Goto declaration')
                    map('gr', vim.lsp.buf.references, 'References')
                    map('gl', vim.diagnostic.open_float, 'Line diagnostics')
                    map('[d', function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, 'Prev diagnostic')
                    map(']d', function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, 'Next diagnostic')

                    -- Angular: surface inlay hints (types, bindings, @for vars)
                    if client and client.name == 'angularls' then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end
                end,
            })

            -- lazydev (ft=lua) already sets Lua.runtime.version = 'LuaJIT' and
            -- Lua.workspace.checkThirdParty = false, and injects the Neovim
            -- runtime library that defines `vim`. Only Snacks needs declaring.
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'Snacks' } },
                        telemetry = { enable = false },
                    },
                },
            })

            -- angularls: only start inside an Angular/Nx workspace. With only
            -- root_markers set, the server starts for every TS/HTML file with
            -- root_dir = nil, competing with vtsls.
            vim.lsp.config('angularls', {
                root_dir = function(bufnr, on_dir)
                    local root = vim.fs.root(bufnr, { 'angular.json', 'nx.json' })
                    if root then
                        on_dir(root)
                    end
                end,
            })

            -- Vue hybrid mode: vtsls + @vue/typescript-plugin, vue_ls handles CSS/HTML
            local vue_language_server_path = vim.fn.stdpath('data')
                .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
            vim.lsp.config('vtsls', {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vue_language_server_path,
                                    languages = { 'vue' },
                                    configNamespace = 'typescript',
                                },
                            },
                        },
                    },
                },
                -- Stand down in Angular (angularls covers TS there) and Deno workspaces
                root_dir = function(bufnr, on_dir)
                    if vim.fs.root(bufnr, { 'angular.json', 'nx.json', 'deno.json', 'deno.jsonc' }) then
                        return
                    end
                    local root = vim.fs.root(bufnr, {
                        'package-lock.json',
                        'yarn.lock',
                        'pnpm-lock.yaml',
                        'bun.lockb',
                        'bun.lock',
                        '.git',
                    })
                    on_dir(root or vim.fn.getcwd())
                end,
            })

            -- Installs servers and enables them (automatic_enable, v2 default)
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'phpactor',
                    'vtsls',
                    'vue_ls',
                    'lua_ls',
                    'tailwindcss',
                    'gopls',
                    'astro',
                    'angularls',
                    'pyright',
                },
            })
        end,
    },
}

-- Lazily configures lua_ls for editing the Neovim config: adds workspace
-- libraries so `require('...')` of plugins and `vim.*` resolve with types.
return {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
        library = {
            -- Neovim runtime types are added automatically; this only adds the
            -- luv bindings when `vim.uv` is actually used.
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
    },
}

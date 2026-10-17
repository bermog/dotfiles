-- Auto-close and auto-rename HTML/JSX/XML tags while typing (treesitter based).
-- Complements mini.pairs for bracket/quote pairs.
return {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
}

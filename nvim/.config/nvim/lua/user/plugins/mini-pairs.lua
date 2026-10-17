-- Auto-insert closing brackets/quotes. blink.cmp completes but does not
-- insert pairs, so this fills that gap.
return {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {},
}

return {
    'obsidian-nvim/obsidian.nvim', -- community-maintained fork of epwalsh/obsidian.nvim
    version = '*',
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        { '<leader>of', '<Cmd>Obsidian quick_switch<CR>', desc = 'Obsidian quick switch' },
        { '<leader>ow', '<Cmd>Obsidian search<CR>', desc = 'Obsidian search' },
        { '<leader>ot', '<Cmd>Obsidian tags<CR>', desc = 'Obsidian tags' },
        { '<leader>od', '<Cmd>Obsidian dailies<CR>', desc = 'Obsidian dailies' },
        { '<leader>on', '<Cmd>Obsidian new<CR>', desc = 'Obsidian new note' },
    },
    opts = {
        legacy_commands = false, -- we use the new `:Obsidian ...` command style above
        workspaces = {
            {
                name = 'Monolith',
                path = '~/Notes/Monolith',
            },
        },
        notes_subdir = 'VOID',
        new_notes_location = 'notes_subdir',
        daily_notes = {
            folder = 'LOGS',
        },
        completion = {
            min_chars = 2,
        },
        picker = {
            name = 'snacks.picker', -- no more fzf-lua, snacks.picker is already set up
        },
        callbacks = {
            enter_note = function()
                -- Preserve the old <leader>oc checkbox toggle
                vim.keymap.set('n', '<leader>oc', function()
                    require('obsidian.actions').toggle_checkbox()
                end, { buffer = true, desc = 'Toggle checkbox' })
            end,
        },
        -- default checkbox chars match what we had; just restrict toggling
        -- to unchecked/checked (ordering now lives in checkbox.order)
        ui = {
            checkbox = {
                order = { ' ', 'x' },
            },
        },
        attachments = {
            folder = 'IMGS',
        },
    },
}

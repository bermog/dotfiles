return {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Monolith",
                path = "~/Notes/Monolith",
            },
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        mappings = {
            -- Obsidian In - Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["<leader>oi"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Obsidian Check - Toggle check-boxes.
            ["<leader>oc"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },
        picker = {
            name = "telescope.nvim",
        },
        ui = {
            checkboxes = {
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
            },
        },
    },
}


return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        local harpoon = require('harpoon').setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-m>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-,>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-.>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-_>", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-[>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-]>", function() harpoon:list():next() end)
    end
}

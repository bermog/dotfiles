-- Define custom filetypes here

-- Blade
-- https://github.com/EmranMR/tree-sitter-blade/issues/6#issuecomment-1613286976
vim.filetype.add({
    pattern = {
        [".*%.blade.php"] = "blade",
    },
})

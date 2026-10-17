-- Define custom filetypes here
--
-- Note: vim.filetype.add() patterns are implicitly anchored (they are wrapped
-- in ^...$), so they must not include their own anchors.

-- Blade
-- https://github.com/EmranMR/tree-sitter-blade/issues/6#issuecomment-1613286976
vim.filetype.add({
    pattern = {
        ['.*%.blade.php'] = 'blade',
        -- Angular templates: treat .html files inside an Angular/Nx workspace as
        -- `htmlangular`, so tree-sitter-angular and angularls apply. Neovim 0.12
        -- already detects the common cases by content (*ngIf, @if, @for, ...);
        -- this catches the rest. Returns nil elsewhere, falling back to the
        -- default `html` detection.
        ['.*%.html'] = function(path, bufnr)
            local name = path
            if type(bufnr) == 'number' and bufnr > 0 then
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname ~= '' then
                    name = bufname
                end
            end
            if vim.fs.find({ 'angular.json', 'nx.json' }, { path = vim.fs.dirname(name), upward = true })[1] then
                return 'htmlangular'
            end
        end,
    },
})

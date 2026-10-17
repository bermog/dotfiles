-- Move selection
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor in the middle of the screen for page u/d
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down, center cursor' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up, center cursor' })
-- Same for search result navigation
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result, center cursor' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search result, center cursor' })

-- Quickly clear search highlighting
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>', { desc = 'Open file under cursor' })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left, keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right, keep selection' })

-- Copy selection into system clipboard
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete to black hole' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Delete to black hole' })

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y', { desc = 'Yank, keep cursor' })
vim.keymap.set('v', 'Y', 'myY`y', { desc = 'Yank line, keep cursor' })

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up (handles wrapped lines)' })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down (handles wrapped lines)' })

-- Paste without copying replaced text
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste over selection, keep register' })

-- Open the current file in the default program
vim.keymap.set('n', '<leader>O', function()
    vim.ui.open(vim.fn.expand('%'))
end, { desc = 'Open current file in default program' })

-- View the undo tree (built-in since Neovim 0.12, but shipped as an opt dist
-- plugin that needs :packadd before :Undotree exists — load it on first use)
vim.keymap.set('n', '<leader>u', function()
    vim.cmd.packadd('nvim.undotree')
    require('undotree').open()
end, { desc = 'Toggle undo tree' })

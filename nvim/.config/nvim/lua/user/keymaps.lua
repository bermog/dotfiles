-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open netrw
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Move selection
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle of the screen for page u/d
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- Same for search result navigation
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Quickly clear search highlighting
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Copy selection into system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dP')

-- Open the current file in the default program (on Mac this should just be just `open`)
vim.keymap.set('n', '<leader>x', ':!xdg-open %<CR><CR>')

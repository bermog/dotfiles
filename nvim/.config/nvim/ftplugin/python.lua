-- Project-specific script runners
vim.keymap.set('n', '<F5>', '!./test.sh<CR>', { buffer = true, desc = 'Run test.sh' })
vim.keymap.set('n', '<F6>', '!./main.sh<CR>', { buffer = true, desc = 'Run main.sh' })

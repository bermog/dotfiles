-- Set leader key before anything else
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('user/options')
require('user/keymaps')
require('user/filetypes')
require('user/lazy')

-- Indenting
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Title format
vim.opt.title = true
vim.opt.titlestring = '%f // nvim'

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable line wrap
vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
-- Remove the ~ from end of buffer
vim.opt.fillchars:append({ eob = ' ' }) --

-- Window split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Minimum scroll offset
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Undo file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- Complete the longest common match, and allow tabbing the results to fully complete them
-- vim.opt.wildmode = 'longest:full,full'
-- vim.opt.completeopt = 'menuone,longest,preview'

--vim.opt.signcolumn = 'yes:2'
vim.opt.signcolumn = 'yes'
--vim.opt.showmode = false
vim.opt.updatetime = 50
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files

-- Ask for confirmation when quitting without saving instead of throwing an error
vim.opt.confirm = true

-- Remove netrw's help banner
vim.g.netrw_banner = 0

-- Display UI options from the Obsidian plugin
vim.opt.conceallevel = 1

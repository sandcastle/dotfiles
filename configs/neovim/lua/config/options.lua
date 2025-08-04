-- Leader key (space for Neovim, comma for traditional Vim)
vim.g.mapleader = " "

-- Load keymaps (must be after leader key is set)
require("config.keymaps")

-- Display settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- Indentation and formatting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- Search settings
vim.opt.hlsearch = false  -- Different from Vim (which uses true)
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Performance and behavior
vim.opt.updatetime = 50
vim.opt.isfname:append("@-@")

-- Mouse and clipboard
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

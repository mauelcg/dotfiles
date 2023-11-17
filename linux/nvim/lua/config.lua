-- basic configuration

vim.opt.expandtab = false
vim.opt.shiftwidth = 4 
vim.opt.softtabstop = 4 
vim.opt.tabstop = 4
vim.opt.scrolloff = 8 
vim.opt.cmdheight = 1
vim.opt.showtabline = 2
vim.opt.numberwidth = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.foldenable = false
vim.opt.swapfile = false
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.fileencoding = "utf-8"
vim.opt.signcolumn = 'yes'
vim.opt.fileformat = 'unix'
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.guicursor = "i:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.syntax = "enable"
vim.opt.termguicolors = true -- enable to integrate colorscheme properly

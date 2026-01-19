-- Bootstrap lazy.nvim, LazyVim, and your plugins
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.o.wrap = false

vim.opt.clipboard = "unnamedplus"

require("config.lazy")

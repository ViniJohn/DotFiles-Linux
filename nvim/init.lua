--Preferences & Core Settings
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showtabline = 2
-- UI & UX 
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"
vim.opt.wrap = false
-- Case insensitive search and smart search 
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Screen Split
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Plug-ins & Scripts
require('vim._core.ui2').enable({ enable = true })
require("keymap")
require("fzf-config")
require("lsp")
require("autocomplete")
require("oil-plug")
require("dashboard")
require("status_line")
vim.cmd.colorscheme("habamax")

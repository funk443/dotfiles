-- vim: foldmethod=marker

-- General configs {{{

vim.o.title = true
vim.o.textwidth = 80
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.undofile = true
vim.o.relativenumber = true
vim.o.formatoptions = "croqlmBj"

vim.cmd.filetype("indent off")

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "

vim.keymap.set("n", "<F5>", ":belowright term <Up>")
vim.keymap.set("n", "<Leader><F5>", ":belowright term ")

vim.keymap.set("n", "<C-w>v", vim.cmd.split)
vim.keymap.set("n", "<C-w>b", vim.cmd.vsplit)
vim.keymap.set("n", "<C-w>s", "<C-w>b")

-- }}}

-- Other modules {{{

require("plugins")
vim.cmd.colorscheme("alabaster")

require("lisp")

require("autocmds")

if vim.g.neovide then
    require("neovide")
end

-- }}}

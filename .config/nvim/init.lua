-- vim: foldmethod=marker

-- General configs {{{

vim.opt.title = true
vim.opt.textwidth = 80
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.relativenumber = true
vim.opt.formatoptions:append("mM")
vim.opt.formatoptions:remove("t")

vim.g.netrw_browsex_viewer = "xdg-open"

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "

vim.keymap.set("n", "<C-h>", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("i", "<C-h>", "<C-x><C-o>", { noremap = true })

vim.keymap.set("n", "<Leader>en", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<Leader>eN", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<Leader>ee", vim.diagnostic.open_float, { noremap = true })

vim.keymap.set("n", "<Leader>tt", ":below term <Up>", { noremap = true })
vim.keymap.set("n", "<Leader>tT", ":below term ", { noremap = true })

-- }}}

-- Other modules {{{

require("plugins")
require("lisp")
require("autocmds")

if vim.g.neovide then
    require("neovide")
end

-- }}}

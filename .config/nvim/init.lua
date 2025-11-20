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
vim.cmd.filetype("indent off")

-- }}}

-- Plugins {{{

vim.pack.add({
    "https://github.com/junegunn/vim-easy-align",
})

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "

vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("i", "<c-h>", "<c-x><c-o>", { noremap = true })

vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { noremap = true })

-- }}}

-- Autocmds {{{

vim.filetype.add({
    extension = {
        ss = "scheme",
        sls = "scheme",
    },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "lisp", "scheme", "clojure" },
    callback = function(ev)
        vim.opt_local.tabstop = 2
    end,
    desc = "Adjust tabstop for some filetypes."
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "go" },
    callback = function(ev)
        vim.opt_local.expandtab = false
    end,
    desc = "Use tabs for indentation in Go files.",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces before saving.",
})

-- }}}

-- Neovide config {{{

if vim.g.neovide then
    vim.o.guifont = "Source Code Pro,Noto Sans CJK TC:h30"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_no_idle = false
    vim.g.neovide_input_ime = true
    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
end

-- }}}

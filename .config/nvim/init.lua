vim.pack.add({
    "https://github.com/junegunn/vim-easy-align",
    "https://github.com/dchinmay2/alabaster.nvim",
})

vim.g.mapleader = " "

vim.keymap.set("n", "<F5>", ":belowright term <Up>")
vim.keymap.set("n", "<Leader><F5>", ":belowright term ")

vim.keymap.set("n", "<C-w>v", vim.cmd.split)
vim.keymap.set("n", "<C-w>b", vim.cmd.vsplit)
vim.keymap.set("n", "<C-w>s", "<C-w>b")

vim.filetype.add({
    extension = {
        ss = "scheme",
        sls = "scheme",
    },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "text" },
    callback = function(ev)
        vim.bo.formatoptions = vim.bo.formatoptions .. "t"
    end,
    desc = "Enable auto line breaks for text files."
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "typescript",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lisp",
        "scheme",
        "clojure",
    },
    callback = function(ev)
        vim.bo.tabstop = 2
    end,
    desc = "Adjust tabstop for some filetypes."
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces before saving.",
})

vim.o.title = true
vim.o.textwidth = 80
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.undofile = true
vim.o.relativenumber = true
vim.o.formatoptions = "croqlmBj"
vim.o.grepprg = "rg --vimgrep "

vim.cmd.filetype("indent off")
vim.cmd.colorscheme("alabaster")

if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0

    local function change_scale_factor(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)

    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
    end)

    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
end

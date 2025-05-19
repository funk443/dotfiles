-- vim: foldmethod=marker

-- General configs {{{

vim.opt.textwidth = 80
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.relativenumber = true
vim.opt.formatoptions:append("mM")

vim.g.netrw_browsex_viewer = "xdg-open"
vim.cmd.filetype("indent off")

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ff", function()
    local cwd = vim.fn.expand("%:h")
    if 0 == #cwd then
        cwd = "."
    end
    vim.api.nvim_input(string.format(":e %s/", cwd))
end, { noremap = true })

vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("i", "<c-h>", "<c-x><c-o>", { noremap = true })

vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { noremap = true })

vim.keymap.set("n", "<F5>", ":term ", { noremap = true })

-- }}}

-- Lazy.nvim {{{

-- Plugin list {{{

local plugins = {
    {
        "miikanissi/modus-themes.nvim",
        priority = 1000,
        opts = {
            variants = "default",
        },
        config = function(_, opts)
            require("modus-themes").setup(opts)
            vim.cmd.colorscheme("modus")
        end,
    },
    { "junegunn/vim-easy-align", lazy = true, cmd = "EasyAlign", opts = {} },
}

-- }}}

-- Other Lazy.nvim stuffs {{{

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤",
        },
    },
}

require("lazy").setup(plugins, lazy_opts)

-- }}}

-- }}}

-- Autocmds {{{

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "go" },
    callback = function(ev)
        vim.opt_local.expandtab = false
    end,
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
end

-- }}}

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

lazy_plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {"junegunn/vim-easy-align", lazy = true, cmd = "EasyAlign"},
}

lazy_opts = {
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
            lazy = "💤 ",
        },
    },
}

require("lazy").setup(lazy_plugins, lazy_opts)

vim.api.nvim_create_autocmd(
    {"BufWritePre"},
    {command = "%s/\\s\\+$//e"}
)

vim.api.nvim_create_autocmd(
    {"BufWinEnter"},
    {command = 'silent! normal! g`"zz'}
)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.showbreak = "|"
vim.opt.autochdir = true
vim.opt.undofile = true

vim.g.netrw_browsex_viewer = "xdg-open"
vim.cmd.colorscheme "catppuccin"
vim.cmd.filetype "indent off"

if vim.g.neovide then
vim.o.guifont = "IBM Plex Mono,IBM Plex Sans TC,Noto Sans CJK TC:h28"
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
        change_scale_factor(1/1.25)
    end)
end

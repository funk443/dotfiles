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
    "junegunn/vim-easy-align",
    { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 }
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
    { "BufWritePre" },
    { command = "%s/\\s\\+$//e" }
)

vim.api.nvim_create_autocmd(
    { "BufWinEnter" },
    { command = 'silent! normal! g`"zz' }
)

vim.opt.showbreak = "|"
vim.opt.tw = 0
vim.opt.expandtab = true
vim.opt.ts = 4
vim.opt.shiftwidth = 0
vim.opt.background = "light"
vim.opt.autochdir = true

vim.cmd.colorscheme "catppuccin-latte"

vim.g.netrw_browsex_viewer = "xdg-open"

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")

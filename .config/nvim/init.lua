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
    { "miikanissi/modus-themes.nvim", priority = 1000 },
    "junegunn/vim-easy-align",
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

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.showbreak = "|"
vim.opt.autochdir = true

vim.g.netrw_browsex_viewer = "xdg-open"
vim.cmd.colorscheme "modus_operandi"
vim.cmd.filetype "indent off"

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")

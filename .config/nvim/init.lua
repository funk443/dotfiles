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
    {"catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false},
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
vim.cmd.colorscheme "catppuccin-latte"
vim.cmd.filetype "indent off"

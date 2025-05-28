-- vim: foldmethod=marker

-- General configs {{{

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

-- Custom commands {{{

vim.api.nvim_create_user_command("Compile", function(opts)
    local arg_count = #opts.fargs
    if arg_count <= 0 and vim.b.compile_last_command == nil then
        print("Please provide some shell commands.")
        return
    end

    local commands = nil
    if arg_count > 0 then
        commands = opts.fargs
        vim.b.compile_last_command = opts.fargs
    else
        commands = vim.b.compile_last_command
    end
    assert(commands, "Shit went wrong while setting the commands.")

    local buf = vim.api.nvim_create_buf(false, true)
    if buf == 0 then
        print("Shits happened while creating command output buffer.")
        return
    end

    vim.api.nvim_set_option_value(
        "errorformat",
        vim.api.nvim_get_option_value("errorformat", { buf = 0 }),
        { scope = "local", buf = buf }
    )

    local function callback(obj)
        local output = vim.split(
            obj.stdout .. "\n" .. obj.stderr,
            "[\n\r]+",
            { plain = false, trimempty = true }
        )
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
        vim.cmd.cgetbuffer(buf)
        vim.api.nvim_buf_delete(buf, {})
    end

    vim.system(
        commands,
        { text = true },
        vim.schedule_wrap(callback)
    )
end, { nargs = "*", complete = "shellcmdline"})

-- }}}

-- Plugin list {{{

local plugins = {
    {
        "miikanissi/modus-themes.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require("modus-themes").setup(opts)
            vim.cmd.colorscheme("modus")
        end,
    },
    { "junegunn/vim-easy-align", lazy = true, cmd = "EasyAlign", opts = {} },
}

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "

vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("i", "<c-h>", "<c-x><c-o>", { noremap = true })

vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { noremap = true })

-- }}}

-- Lazy.nvim {{{

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

-- Autocmds {{{

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
    vim.o.guifont = "Roboto Mono,Noto Sans CJK TC:h30"
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

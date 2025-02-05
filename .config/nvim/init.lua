-- vim: foldmethod=marker

-- Lazy.nvim {{{

-- Plugin list {{{

local plugins = {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				python = { "black" },
				lua = { "stylua" },
				java = { "google-java-format" },
				c = { "clang-format" },
				go = { "gofmt" },
				html = { "prettier" },
				javascript = { "prettier" },
				css = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {},
		},
	},
	{ "junegunn/vim-easy-align", lazy = true, cmd = "EasyAlign", opts = {} },
	{ "neovim/nvim-lspconfig" },
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

-- General configs {{{

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.undofile = true
vim.opt.relativenumber = true

vim.g.netrw_browsex_viewer = "xdg-open"
vim.cmd.colorscheme("industry")

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>b", ":b ", { noremap = true })

vim.keymap.set("n", "<c-i>", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("i", "<c-i>", "<c-x><c-o>", { noremap = true })

-- }}}

-- LSP configs {{{

local lsp_path = "/home/id/Documents/softwares/lsps/"
local lsp = require("lspconfig")

lsp.pyright.setup({})
lsp.jdtls.setup({ cmd = { lsp_path .. "jdtls/bin/jdtls" } })

-- }}}

-- Neovide config {{{

if vim.g.neovide then
	vim.o.guifont = "Iosevka,Noto Sans CJK TC:h30"
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

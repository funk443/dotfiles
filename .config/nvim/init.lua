-- vim: foldmethod=marker

-- Lazy.nvim {{{

-- Plugin list {{{

local plugins = {
	{
		"miikanissi/modus-themes.nvim",
		priority = 1000,
		config = function(_, opts)
			require("modus-themes").setup(opts)
			vim.cmd.colorscheme("modus")
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
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

-- }}}

-- Keybindings {{{

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>bb", ":b ", { noremap = true })
vim.keymap.set("n", "<leader>bd", ":bd<return>", { noremap = true })
vim.keymap.set("n", "<leader>bn", ":bn<return>", { noremap = true })
vim.keymap.set("n", "<leader>bp", ":bp<return>", { noremap = true })

vim.keymap.set("n", "<c-h>", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("i", "<c-h>", "<c-x><c-o>", { noremap = true })

vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { noremap = true })
vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { noremap = true })

-- }}}

-- LSP configs {{{

local lsp = require("lspconfig")
lsp.pyright.setup({})
lsp.jdtls.setup({})

if vim.version().minor >= 11 then
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, {})
			end
		end,
	})
end

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

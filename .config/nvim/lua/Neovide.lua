-- Fonts are set in Neovide's config file.

vim.g.neovide_scale_factor = 1.0

local function ChangeScaleFactor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function()
    ChangeScaleFactor(1.25)
end)

vim.keymap.set("n", "<C-->", function()
    ChangeScaleFactor(1/1.25)
end)

vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
end)

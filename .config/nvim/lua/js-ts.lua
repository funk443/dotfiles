vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "typescript", "javascript", "json", "json5", "jsonc" },
    callback = function(ev)
        vim.opt_local.tabstop = 2
    end,
    desc = "Adjust tabstop for some filetypes."
})

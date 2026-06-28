vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces before saving.",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "text" },
    callback = function(ev)
        vim.opt_local.formatoptions:append("t")
    end,
    desc = "Enable auto line breaks for text files."
})

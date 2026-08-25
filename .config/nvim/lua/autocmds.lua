vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces before saving.",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "text" },
    callback = function(ev)
        vim.bo.formatoptions = vim.bo.formatoptions .. "t"
    end,
    desc = "Enable auto line breaks for text files."
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "typescript", "javascript", "json", "json5", "jsonc" },
    callback = function(ev)
        vim.bo.tabstop = 2
    end,
    desc = "Adjust tabstop for some filetypes."
})

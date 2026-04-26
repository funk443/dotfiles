vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "lisp", "scheme", "clojure" },
    callback = function(ev)
        vim.opt_local.tabstop = 2
    end,
    desc = "Adjust tabstop for some filetypes."
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    command = "%s/\\s\\+$//e",
    desc = "Remove trailing whitespaces before saving.",
})

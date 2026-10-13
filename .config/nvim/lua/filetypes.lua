vim.filetype.add({
    extension = {
        ss = "scheme",
        sls = "scheme",
    },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "text" },
    callback = function(ev)
        vim.bo.formatoptions = vim.bo.formatoptions .. "t"
    end,
    desc = "Enable auto line breaks for text files."
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "typescript",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lisp",
        "scheme",
        "clojure",
    },
    callback = function(ev)
        vim.bo.tabstop = 2
    end,
    desc = "Adjust tabstop for some filetypes."
})

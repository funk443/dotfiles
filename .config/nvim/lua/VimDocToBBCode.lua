-- Copyright © 2026 CToID <funk443@icloud.com>
--
-- This program is free software. It comes without any warranty, to the
-- extent permitted by applicable law. You can redistribute it and/or
-- modify it under the terms of the Do What The Fuck You Want To Public
-- License, Version 2, as published by Sam Hocevar. See the COPYING file
-- for more details.

local M = {}

function M.Generate(_)
    local function NewTextGetter(buf)
        return function(node)
            return vim.treesitter.get_node_text(node, buf)
        end
    end

    local function isParagraph(node)
        return node:type() == "line" and node:child(0):type() == "word"
    end

    local function isH1(node)
        return node:type() == "line" and node:child(0):type() == "h1"
    end

    local function isH2(node)
        return node:type() == "line" and node:child(0):type() == "h2"
    end

    local function isList(node)
        return node:type() == "line_li"
    end

    local function makeElem(name, text)
        return "[" .. name .. "]" .. text .. "[/" .. name .. "]"
    end

    local buf = vim.api.nvim_get_current_buf()
    local get_text = NewTextGetter(buf)

    local lang_tree = assert(vim.treesitter.get_parser(buf, nil))
    lang_tree:parse()

    local theTrees = lang_tree:trees()
    assert(#theTrees == 1, "Multiple root nodes not supported.")

    local docRoot = theTrees[1]:root()
    assert(docRoot:type() == "help_file", "Not a Vim help file.")

    local blocks = {}
    for child, _ in docRoot:iter_children() do
        if child:type() == "block" then
            table.insert(blocks, child)
        end
    end

    local titleBlock = table.remove(blocks, 1)
    assert(
        titleBlock:child_count() == 1,
        "Invalid first line, see |help-writing|."
    )

    local titleLine = titleBlock:child(0)
    assert(
        titleLine:type() == "line" and titleLine:child_count() == 2,
        "Invalid first line, see |help-writing|."
    )

    local filename = titleLine:child(0)
    assert(
        filename:type() == "tag" and filename:child_count() == 3,
        "Invalid first line (left part,) see |help-writing|."
    )
    filename = get_text(filename:child(1))

    local title = get_text(titleLine:child(1))

    local contents = {}
    for _, block in ipairs(blocks) do
        local prober = block:child(0)
        if isParagraph(prober) then
            local builder = {}
            -- TODO: Insert spaces between CJK and latin when joining lines.
            for line, _ in block:iter_children() do
                table.insert(builder, get_text(line))
            end

            local text = table.concat(builder)
            table.insert(contents, makeElem("div", text))
        elseif isH1(prober) then
            local text = get_text(prober:child(0):child(1))
            table.insert(contents, makeElem("h2", text))
        elseif isH2(prober) then
            local text = get_text(prober:child(0):child(1))
            table.insert(contents, makeElem("h3", text))
        elseif isList(prober) then
            table.insert(contents, "[ul]")
            for item, _ in block:iter_children() do
                local text = get_text(item:child(1))
                table.insert(contents, makeElem("li", text))
            end
            table.insert(contents, "[/ul]")
        else
            assert(
                false,
                "Unrecognized type: " .. block:child(0):type() .. "."
            )
        end
    end

    local bbcodeBuf = vim.api.nvim_create_buf(true, true)
    assert(bbcodeBuf ~= 0)
    vim.api.nvim_buf_set_lines(bbcodeBuf, 0, -1, false, contents)
    vim.api.nvim_set_current_buf(bbcodeBuf)
end

return M

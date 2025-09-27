return function()
    require("ibl").setup({
        enabled = true,
        debounce = 100,
        indent = {
            char = "▎",
            highlight = "IblIndent",
            smart_indent_cap = true,
            priority = 2,
            repeat_linebreak = true,
        },
        whitespace = {
            highlight = "IblWhiteSpace",
            remove_blankline_trail = true,
        },
        scope = {
            enabled = true,
            char = "▍",
            show_start = false,
            show_end = false,
            show_exact_scope = false,
            injected_languages = true,
            highlight = "Keyword",
            priority = 1024,
            -- include = {},
            -- exclude = {},
        },
        -- exclude = {},
        -- there are some hooks, but for now I don't see a reason to use them
    })
end

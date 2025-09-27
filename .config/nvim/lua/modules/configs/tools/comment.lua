return function()
    require('Comment').setup({
        opleader = {
            line = "<leader>cc",
            block = "<leader>cb"
        },
        extra = {
            above = "<leader>ca",
            below = "<leader>cu",
            eol = "<leader>ce",
        },
        mappings = {
            basic = true,
            extra = true,
        }
    })

end

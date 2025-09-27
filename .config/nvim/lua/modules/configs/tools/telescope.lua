return function()
    require("telescope").setup {
        defaults = {

            mappings = {

            }
        },
        pickers = {
            -- default is good enough
            -- find_files = {
            --     theme = "ivy",
            -- },
            -- git_files = {
            --     theme = "ivy",
            --
            -- },
            -- buffers = {
            --     theme = "dropdown",
            --
            -- },
            -- grep_string = {
            --     theme = "dropdown",
            --
            -- },
            -- live_grep = {
            --     theme = "dropdown",
            --
            -- },
            -- git_bcommits = {
            --     theme = "ivy",
            --
            -- },
            -- git_commits = {
            --     theme = "ivy",
            --
            -- },
            -- git_commits_range = {
            --     theme = "ivy",
            -- },
        },
        extensions = {

        },
    }

    -- keybinds
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('i', '<leader>fs', builtin.grep_string, {})
    vim.keymap.set('v', '<leader>fs', function()
        local vstart = vim.fn.getpos("'<")

        local vend = vim.fn.getpos("'>")

        local line_start = vstart[2]
        local line_end = vend[2]

        -- or use api.nvim_buf_get_lines
        local lines = vim.fn.getline(line_start, line_end)
        builtin.grep_string(lines)
    end)

    vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

    vim.keymap.set('n', '<leader>lc', builtin.git_commits, {})
    vim.keymap.set('n', '<leader>bc', builtin.git_bcommits, {})
    vim.keymap.set('v', '<leader>bc', function()
        local vstart = vim.fn.getpos("'<")
        local vend = vim.fn.getpos("'>")

        builtin.git_bcommits_range(vstart, vend)
    end)
end

return function()
    -- settings
    local leap = require('leap')
    leap.opts.case_sensitive = false
    leap.opts.equivalent_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    leap.opts.preview_filter = nil
    leap.opts.max_highlighted_traversal_targets = 10
    leap.opts.substitute_chars = {}
    leap.opts.safe_labels = "sfnmut/SFNMUT?"
    leap.opts.labels = "sfgnjklhodweimbuyvrtaqpcxz/SFGNJKLHODWEIMBUYVRTAQPCXZ?"

    leap.opts.special_keys =
    {
        next_target = { '.', '<tab>' },
        prev_target = { ';', '<S-tab>' },
        next_group = { '<space>' },
        prev_group = { '<S-space>' },
    }

    -- keymaps
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
    vim.keymap.set({ 'n', 'x', 'o' }, '<C-s>', '<Plug>(leap-from-window)')

    -- highlights
    vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#D9D8E3" })
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#D9D8E3", bg = "#636183" })
    -- vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#000000", bg = "#D9D8E3"})
    vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#4D4B65" })
end

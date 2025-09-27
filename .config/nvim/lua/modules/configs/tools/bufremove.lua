return function()
    local bufrem = require('mini.bufremove')
    bufrem.setup({
        -- Whether to set Vim's settings for buffers (allow hidden buffers)
        set_vim_settings = true,

        -- Whether to disable showing non-error feedback
        silent = false
    })

    vim.keymap.set("n", "<leader>d", function()
        bufrem.delete()
    end)
end

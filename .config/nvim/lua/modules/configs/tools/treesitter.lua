local config = function()

    require("nvim-treesitter.configs").setup({
        ensure_installed = {"lua", "vim" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = true
        }
    })
end

return config

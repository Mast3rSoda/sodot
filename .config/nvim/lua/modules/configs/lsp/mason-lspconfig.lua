return function()
    require("lsp-zero").extend_lspconfig()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
            ["bashls"] = function()
                require('lspconfig')["bashls"].setup({
                    filetypes = { 'bash', 'sh', 'zsh' },
                })
            end
        }
    })
end

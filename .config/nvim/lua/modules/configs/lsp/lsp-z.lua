return function()
    local diagnosticIcons = require("modules.utils.icons").get("diagnostics", false)
    local lsp_zero = require('lsp-zero')
    lsp_zero.on_attach(
        function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({
                buffer = bufnr
            })

            lsp_zero.set_sign_icons({
                error = diagnosticIcons.Error_alt,
                warn = diagnosticIcons.Warning_alt,
                info = diagnosticIcons.Information_alt,
                hint = diagnosticIcons.Information_alt
            })
        end)
end

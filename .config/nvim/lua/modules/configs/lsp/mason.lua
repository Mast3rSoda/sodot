return function()
    local uiIcons = require("modules.utils.icons").get("ui", false)
    require("mason").setup({
        ui = {
            icons = {
                package_installed = uiIcons.Accepted,
                package_pending = uiIcons.History,
                package_uninstalled = uiIcons.Close_alt
                -- package_installed = "✓",
                -- package_pending = "➜",
                -- package_uninstalled = "✗"

            }
        },
        registries = {
            "github:mason-org/mason-registry",
        },

        ---@since 1.0.0
        -- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
        -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
        -- Builtin providers are:
        --   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
        --   - mason.providers.client        - uses only client-side tooling to resolve metadata
        providers = {
            -- NOTE: uncomment once the mason registry comes back to life
            -- "mason.providers.registry-api",
            "mason.providers.client",
        },


    })
end


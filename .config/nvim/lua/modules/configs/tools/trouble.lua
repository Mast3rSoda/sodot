local M = {}

-- 99% of the time, works 100% of the time
function M:toggle_window(mode, trouble)
    local view = trouble._find_last(mode, nil)
    if view == nil or M[mode] == nil then
        local v = trouble.open(mode)
        v:wait(function()
            M[mode] = vim.api.nvim_get_current_buf()
        end)
        return
    elseif M[mode] == vim.api.nvim_get_current_buf() then
        local v = trouble.close(mode)
        v:wait(function()
            M[mode] = nil
        end)
    else
        if not vim.api.nvim_buf_is_loaded(M[mode]) then
            local v = trouble.close(mode)
            v:wait(function()
                M[mode] = nil
            end)
        end
        trouble.open(mode)
    end
end

return function()
    local uiIcons = require("modules.utils.icons").get("ui", true)
    local typeIcons = require("modules.utils.icons").get("type", true)
    local kindIcons = require("modules.utils.icons").get("kind", true)

    local trouble = require("trouble")

    vim.keymap.set("n", "<leader>q", function()
        M:toggle_window("lsp", trouble)
    end)
    vim.keymap.set("n", "<leader>w", function()
        M:toggle_window("lsp_document_symbols", trouble)
    end)
    vim.keymap.set("n", "<leader>e", function()
        M:toggle_window("diagnostics", trouble)
    end)


    trouble.setup({

        auto_close = false,      -- auto close when there are no items
        auto_open = false,       -- auto open when there are items
        auto_preview = true,     -- automatically open preview when on an item
        auto_refresh = true,     -- auto refresh when open
        auto_jump = false,       -- auto jump to the item when there's only one
        focus = true,            -- Focus the window when opened
        restore = true,          -- restores the last location in the list when opening
        follow = true,           -- Follow the current item
        indent_guides = true,    -- show indent guides
        max_items = 200,         -- limit number of items that can be displayed per section
        multiline = true,        -- render multi-line messages
        pinned = false,          -- When pinned, the opened trouble window will be bound to the current buffer
        warn_no_results = false, -- show a warning when there are no results
        open_no_results = true,  -- open the trouble window when there are no results

        -- uhh, better set this up per mode
        win = {}, -- window options for the results window. Can be a split or a floating window.

        -- Window options for the preview window. Can be a split, floating window,
        -- or `main` to show the preview in the main editor window.
        preview = {
            -- when a buffer is not yet loaded, the preview window will be created
            -- in a scratch buffer with only syntax highlighting enabled.
            -- Set to false, if you want the preview to always be a real loaded buffer.
            scratch = true,
        },
        -- Throttle/Debounce settings. Should usually not be changed.
        ---@type table<string, number|{ms:number, debounce?:boolean}>
        throttle = {
            refresh = 20,                            -- fetches new data when needed
            update = 10,                             -- updates the window
            render = 10,                             -- renders the window
            follow = 100,                            -- follows the current item
            preview = { ms = 100, debounce = true }, -- shows the preview for the current item
        },
        -- Key mappings can be set to the name of a builtin action,
        -- or you can define your own custom action.

        keys = {
            ["?"] = "help",
            r = "refresh",
            R = "toggle_refresh",
            q = "close",
            o = "jump_close",
            ["<esc>"] = "cancel",
            ["<cr>"] = "jump",
            ["<2-leftmouse>"] = "jump",
            ["<c-w>s"] = "jump_split",
            ["<c-w>v"] = "jump_vsplit",
            -- go down to next item (accepts count)
            -- j = "next",
            ["}"] = "next",
            ["]]"] = "next",
            -- go up to prev item (accepts count)
            -- k = "prev",
            ["{"] = "prev",
            ["[["] = "prev",
            dd = "delete",
            d = { action = "delete", mode = "v" },
            i = "inspect",
            p = "preview",
            P = "toggle_preview",
            zo = "fold_open",
            zO = "fold_open_recursive",
            zc = "fold_close",
            zC = "fold_close_recursive",
            za = "fold_toggle",
            zA = "fold_toggle_recursive",
            zm = "fold_more",
            zM = "fold_close_all",
            zr = "fold_reduce",
            zR = "fold_open_all",
            zx = "fold_update",
            zX = "fold_update_all",
            zn = "fold_disable",
            zN = "fold_enable",
            zi = "fold_toggle_enable",
            b = { -- example of a custom action that toggles the active view filter
                action = function(view)
                    view:filter(
                        { buf = 0 },
                        {
                            id = "buffer",
                            toggle = true,
                            template = "{hl:Title}current buffer{hl}"
                        })
                end,
                desc = "Toggle Current Buffer Filter",
            },
            s = { -- example of a custom action that toggles the severity
                action = function(view)
                    local f = view:get_filter("severity")
                    local severity = ((f and f.filter.severity or 0) + 1) % 5
                    view:filter(
                        { severity = severity }, {
                            id = "severity",
                            template = "{hl:Title}Filter:{hl} {severity}",
                            del = severity == 0,
                        })
                end,
                desc = "Toggle Severity Filter",
            },
        },

        modes = {
            lsp = {
                win = {
                    type = "float",
                    relative = "editor",
                    border = "rounded",
                    title = "Lsp",
                    title_pos = "left",
                    position = { 0, -2 },
                    size = {
                        width = 0.4,
                        height = 0.3
                    },
                    zindex = 200,
                },
                preview = {
                    type = "main",
                },
            },

            lsp_document_symbols = {
                win = {
                    type = "float",
                    relative = "editor",
                    border = "rounded",
                    title = "Symbols",
                    title_pos = "left",
                    position = { 0.48, -2 },
                    size = {
                        width = 0.4,
                        height = 0.3
                    },
                    zindex = 200,
                },
                preview = {
                    type = "main",
                },
            },

            diagnostics = {
                win = {
                    type = "float",
                    relative = "editor",
                    border = "rounded",
                    title = "Diagnostics",
                    title_pos = "left",
                    position = { 1, -2 },
                    size = {
                        width = 0.4,
                        height = 0.3
                    },
                    zindex = 200,
                },
                preview = {
                    -- type = "float",
                    -- relative = "editor",
                    -- border = "rounded",
                    -- title = "Preview",
                    -- title_pos = "left",
                    -- position = { 0, 0.19 },
                    -- size = {
                    --     width = 0.4,
                    --     height = 1
                    -- },
                    -- zindex = 200,

                    type = "main",
                },
            },
            -- sources define their own modes, which you can use directly,
            -- or override like in the example below
            lsp_references = {
                -- some modes are configurable, see the source code for more details
                params = {
                    include_declaration = true,
                },
            },
            -- The LSP base mode for:
            -- * lsp_definitions, lsp_references, lsp_implementations
            -- * lsp_type_definitions, lsp_declarations, lsp_command
            lsp_base = {
                params = {
                    -- don't include the current location in the results
                    include_current = false,
                },
            },
            -- more advanced example that extends the lsp_document_symbols
            -- my_symbols = {
            --     desc = "document symbols",
            --     mode = "lsp_document_symbols",
            --     focus = false,
            --     win = { position = "right" },
            --     filter = {
            --         -- remove Package since luals uses it for control flow structures
            --         ["not"] = { ft = "lua", kind = "Package" },
            --         any = {
            --             -- all symbol kinds for help / markdown files
            --             ft = { "help", "markdown" },
            --             -- default set of symbol kinds
            --             kind = {
            --                 "Class",
            --                 "Constructor",
            --                 "Enum",
            --                 "Field",
            --                 "Function",
            --                 "Interface",
            --                 "Method",
            --                 "Module",
            --                 "Namespace",
            --                 "Package",
            --                 "Property",
            --                 "Struct",
            --                 "Trait",
            --             },
            --         },
            --     },
            -- },
        },
        -- stylua: ignore
        icons = {

            indent        = {
                top         = uiIcons.IndentEdge,
                middle      = uiIcons.IndentMiddle,
                last        = uiIcons.IndentCorner,
                -- last          = "-╴",
                -- last       = "╰╴", -- rounded
                fold_open   = uiIcons.ArrowOpen,
                fold_closed = uiIcons.ArrowClosed,
                ws          = "  ",
            },
            folder_closed = uiIcons.Folder,
            folder_open   = uiIcons.FolderOpen,
            kinds         = {
                Array         = typeIcons.Array,
                Boolean       = typeIcons.Boolean,
                Class         = kindIcons.Class,
                Constant      = kindIcons.Constant,
                Constructor   = kindIcons.Constructor,
                Enum          = kindIcons.Enum,
                EnumMember    = kindIcons.EnumMember,
                Event         = kindIcons.Event,
                Field         = kindIcons.Field,
                File          = kindIcons.File,
                Function      = kindIcons.Function,
                Interface     = kindIcons.Interface,
                Key           = kindIcons.Keyword,
                Method        = kindIcons.Method,
                Module        = kindIcons.Module,
                Namespace     = kindIcons.Namespace,
                Null          = typeIcons.Null,
                Number        = typeIcons.Number,
                Object        = typeIcons.Object,
                Operator      = kindIcons.Operator,
                Package       = kindIcons.Package,
                Property      = kindIcons.Property,
                String        = typeIcons.String,
                Struct        = kindIcons.Struct,
                TypeParameter = kindIcons.TypeParameter,
                Variable      = kindIcons.Variable,
            },
        },
    })
end

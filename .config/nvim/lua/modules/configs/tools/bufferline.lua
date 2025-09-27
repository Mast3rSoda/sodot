return function()
    local bufferline = require("bufferline")

    vim.keymap.set("n", "<C-p>", function()
        bufferline.cycle(-1)
    end)
    vim.keymap.set("n", "<C-n>", function()
        bufferline.cycle(1)
    end)
    vim.keymap.set("n", "<leader>bo", function()
        bufferline.close_others()
    end)
    vim.keymap.set("n", "<leader>bp", function()
        bufferline.close_with_pick()
    end)
    local uIcons = require("modules.utils.icons").get("ui", false)
    bufferline.setup({
        options = {
            mode = "buffers",                               -- set to "tabs" to only show tabpages instead
            style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
            themable = true,                                -- allows highlight groups to be overriden i.e. sets highlights as default
            numbers = "buffer_id",
            close_command = "bdelete! %d",                  -- can be a string | function, | false see "Mouse actions"
            right_mouse_command = "buffer %d",            -- can be a string | function | false, see "Mouse actions"
            left_mouse_command = "buffer %d",               -- can be a string | function, | false see "Mouse actions"
            middle_mouse_command = nil,                     -- can be a string | function, | false see "Mouse actions"
            indicator = {
                icon = '',                                  --'', -- this should be omitted if indicator style is not 'icon'
                style = 'none'
            },
            buffer_close_icon = uIcons.Close_alt,
            modified_icon = uIcons.Modified,
            close_icon = uIcons.Close,
            left_trunc_marker = uIcons.Left,
            right_trunc_marker = uIcons.Right,

            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = true,  -- whether or not tab names should be truncated
            tab_size = 18,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            offsets = { {
                filetype = "NvimTree",
                text = "Ayy lamo",
                text_align = "center",
                separator = true
            } },
            color_icons = true, -- whether or not to add the filetype icon highlights
            get_element_icon = function(element)
                -- element consists of {filetype: string, path: string, extension: string, directory: string}
                -- This can be used to change how bufferline fetches the icon
                -- for an element e.g. a buffer or a tab.
                -- e.g.
                local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, {
                    default = false
                })
                return icon, hl
            end,
            show_buffer_icons = true, -- disable filetype icons for buffers
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
            persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
            move_wraps_at_ends = false,   -- whether or not the move command "wraps" at the first or last position
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = { "", "" },
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            hover = {
                -- enabled, but doesn't work (at least on windows Terminal)
                enabled = true,
                delay = 200,
                reveal = { 'close' }
            },
            sort_by = 'insert_after_current',
            --[[ custom_areas = {
                right = function()
                    local lspsaga = require("lspsaga")
                    local seve = require(lspsaga.symbol.winbar).get_bar()

                    return seve
                end,
            } ]]

            --[[ custom_areas = {
                right = function()
                    local result = {}
                    local seve = vim.diagnostic.severity
                    local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
                    local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
                    local info = #vim.diagnostic.get(0, { severity = seve.INFO })
                    local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

                    if error ~= 0 then
                        table.insert(result, { text = "  " .. error, fg = "#EC5241" })
                    end

                    if warning ~= 0 then
                        table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
                    end

                    if hint ~= 0 then
                        table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
                    end

                    if info ~= 0 then
                        table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
                    end
                    return result
                end,
            } ]]
            --[[ diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                        or (e == "warning" and " " or "")
                    s = s .. n .. sym
                end
                return s
            end ]]

        },

    })
end

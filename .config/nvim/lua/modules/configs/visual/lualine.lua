-- return function()
--     local colors = {
--         blue   = '#80a0ff',
--         cyan   = '#79dac8',
--         black  = '#080808',
--         white  = '#c6c6c6',
--         red    = '#ff5189',
--         violet = '#d183e8',
--         grey   = '#303030',
--     }
--
--     local bubbles_theme = {
--         normal = {
--             a = { fg = colors.black, bg = colors.violet },
--             b = { fg = colors.white, bg = colors.grey },
--             c = { fg = colors.black, bg = colors.black },
--             x = { fg = colors.white, bg = colors.grey },
--         },
--
--         insert = { a = { fg = colors.black, bg = colors.blue } }, -- c = { fg = colors.black, bg = colors.blue } },
--         visual = { a = { fg = colors.black, bg = colors.cyan } }, -- c = { fg = colors.black, bg = colors.cyan } },
--         replace = { a = { fg = colors.black, bg = colors.red } }, -- c = { fg = colors.black, bg = colors.red } },
--
--         inactive = {
--             a = { fg = colors.white, bg = colors.black },
--             b = { fg = colors.white, bg = colors.black },
--             c = { fg = colors.white, bg = colors.black },
--             x = { fg = colors.white, bg = colors.black },
--         },
--     }
--
--     local function diff_source()
--         local gitsigns = vim.b.gitsigns_status_dict
--         if gitsigns then
--             return {
--                 added = gitsigns.added,
--                 modified = gitsigns.changed,
--                 removed = gitsigns.removed,
--             }
--         end
--     end
--
--     require('lualine').setup {
--         options = {
--             theme = bubbles_theme,
--             component_separators = '|',
--             section_separators = { left = '', right = '' },
--         },
--         sections = {
--             lualine_a = {
--                 { 'mode', separator = { left = '' }, right_padding = 2 },
--             },
--             lualine_b = { 'filename', 'branch', {
--                 'diagnostics',
--                 sources = { 'nvim_diagnostic' },
--                 symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
--                 diagnostics_color = {
--                     color_error = { fg = colors.red },
--                     color_warn = { fg = colors.yellow },
--                     color_info = { fg = colors.cyan },
--                 },
--             } },
--             lualine_c = {},
--             lualine_x = {},
--             lualine_y = { {
--                 'diff',
--                 symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
--                 diff_color = {
--                     added = { fg = colors.green },
--                     modified = { fg = colors.orange },
--                     removed = { fg = colors.red },
--                 },
--                 source = diff_source,
--             }, 'filetype', 'progress' },
--             lualine_z = {
--                 { 'location', separator = { right = '' }, left_padding = 2 },
--             },
--         },
--         inactive_sections = {
--             lualine_a = { 'filename' },
--             lualine_b = {},
--             lualine_c = {},
--             lualine_x = {},
--             lualine_y = {},
--             lualine_z = { 'location' },
--         },
--         tabline = {},
--         extensions = {},
--     }
-- end

local icons = require("modules.utils.icons")
local gitIcons = icons.get("git", true)
local diff = {
    'diff',
    symbols = {
        added = gitIcons.Add,
        modified = gitIcons.Mod_alt,
        removed = gitIcons.Remove
    },
}

local uiIcons = icons.get("ui", true)
local filename = {
    'filename',
    symbols = {
        modified = uiIcons.Modified, -- Text to show when the file is modified.
        readonly = uiIcons.Lock,     -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]',       -- Text to show for unnamed buffers.
        newfile = uiIcons.NewFile,   -- Text to show for newly created file before first write
    }
}

return function()
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' }, -- { left = '│', right = '│' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', diff },
            lualine_c = { filename, 'searchcount' },
            lualine_x = { --[[ 'encoding', 'fileformat', ]] 'filetype' },
            lualine_y = { 'diagnostics', 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { filename, 'searchcount' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

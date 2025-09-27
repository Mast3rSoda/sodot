local config = function()
    local Shade = require("nightfox.lib.shade")
    require('nightfox').setup({
        options = {
            -- Compiled file's destination location
            compile_path = vim.fn.stdpath("cache") .. "/nightfox",
            compile_file_suffix = "_compiled", -- Compiled file suffix
            transparent = true,                -- Disable setting background
            terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
            dim_inactive = false,              -- Non focused panes set to alternative background
            module_default = true,             -- Default enable value for modules
            colorblind = {
                enable = false,                -- Enable colorblind support
                simulate_only = false,         -- Only show simulated colorblind colors and not diff shifted
                severity = {
                    protan = 0,                -- Severity [0,1] for protan (red)
                    deutan = 0,                -- Severity [0,1] for deutan (green)
                    tritan = 0,                -- Severity [0,1] for tritan (blue)
                },
            },
            styles = {               -- Style to be applied to different syntax groups
                comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                conditionals = "italic",
                constants = "bold",
                functions = "NONE",
                keywords = "NONE",
                numbers = "NONE",
                operators = "NONE",
                strings = "NONE",
                types = "NONE",
                variables = "NONE",
            },
            inverse = { -- Inverse highlight for different types
                match_paren = false,
                visual = false,
                search = false,
            },
            modules = { -- List of various plugins and additional options
                -- ...
            },
        },
        palettes = {
            --maybe someday?
            -- duskfox = {
            --     comment = "#6272A4",
            --     bg0 = "#20152B",
            --     bg1 = "#221D38",
            --     bg2 = "#242623",
            --     bg3 = "#3D2E63",
            --     bg4 = "#654099",
            --     fg0 = "#F8F8F2",
            --     fg1 = "#BBBBBB",
            --     fg2 = "#B491E5",
            --     fg3 = "#8E856E",
            --     sel0 = "#4A021A",
            --     sel1 = "#7A032B",
            -- }
            nightfox = {
                -- black = Shade.new("#080305", "#6f475a", -0.15),
                red = Shade.new("#FA7D63", "#6E58B2", -0.15), --return, error, bright interfaces
                -- btw #CD365E is a really nice color, no idea where to put it tho
                -- sel1 is the spot
                green = Shade.new("#8FBFC7", "#698D92", -0.15), -- strings
                yellow = Shade.new("#EBAE6F", "#E8B154", -0.15), -- structs
                blue = Shade.new("#AE4A7E", "#BF1D6B", -0.15), -- struct fields, bright methods
                magenta = Shade.new("#981F59", "#CB4B72", -0.15), -- type (word), bright if
                cyan = Shade.new("#C35087", "#DC5A98", -0.15), -- bright types
                white = Shade.new("#EBC0D4", "#FFDEEE", -0.15), -- text
                orange = Shade.new("#DD9041", "#D36C00", -0.15), -- numbers, bright constants/enumMembers
                pink = Shade.new("#0D4A5B", "#126B83", -0.15), -- import/package
                comment = "#715E66",
                bg0 = "#000000",
                bg1 = "#080305",
                bg2 = "#230D16",
                bg3 = "#330C1F", -- indents and nvimtree highlight
                bg4 = "#DDA3BB",
                fg0 = "#EBD0DC",
                fg1 = "#EBC0D4", -- nvimTree fileNames etc. set the same as white
                fg2 = "#EBC0D4", -- brackets etc.
                fg3 = "#AB7E93",
                sel0 = "#3A1021",
                sel1 = "#CD365E", -- active parameter highlight
            }
        },
        specs = {
            -- duskfox = {
            --     syntax = {

            --     },
            --     git = {

            --     }
            -- }
        },
        groups = {},
    })

    -- setup must be called before loading
    vim.cmd("colorscheme nightfox")
end


return config

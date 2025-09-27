return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = require("modules.configs.visual.catpuccin"),
        enabled = false
    },
    {
        "EdenEast/nightfox.nvim",
        name = "nightfox",
        priority = 1000,
        config = require("modules.configs.visual.nightfox")

    },
    { "dstein64/nvim-scrollview" },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("modules.configs.visual.nvimtree"),
    },
    {
        'nvim-lualine/lualine.nvim',
        config = require("modules.configs.visual.lualine"),
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "onsails/lspkind.nvim",
        lazy = true,
        config = require("modules.configs.visual.lsp-kind")
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = require("modules.configs.visual.webdevicons")
    },
    {
        "sphamba/smear-cursor.nvim",
        config = require("modules.configs.visual.smear-cursor")
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = require("modules.configs.visual.indent-blankline"),
        event = "BufAdd"
    },
    {
        "RRethy/vim-illuminate",
        config = require("modules.configs.visual.vim-illuminate"),
        event = "BufAdd"
    },
    {
        "karb94/neoscroll.nvim",
        config = require("modules.configs.visual.neoscroll"),
    }
}

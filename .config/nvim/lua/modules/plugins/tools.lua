return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        cmd = "Telescope",
        module = 'telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep'
            -- "nvim-tree/nvim-web-devicons"
        },
        config = require("modules.configs.tools.telescope"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufAdd",
        config = require("modules.configs.tools.treesitter")
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = require("modules.configs.tools.harpoon")
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufAdd",
        config = require("modules.configs.tools.gitsigns"),
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        event = "VeryLazy",
        config = require("modules.configs.tools.bufferline")
    },
    {
        "tiagovla/scope.nvim",
        event = "VeryLazy",
        config = require("modules.configs.tools.scope")
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true -- this is equalent to setup({}) function
    },
    {
        "numToStr/Comment.nvim",
        event = "BufEnter",
        config = require("modules.configs.tools.comment"),
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event = "BufAdd",
        config = require("modules.configs.tools.neogen"),
    },
    {
        'echasnovski/mini.bufremove',
        version = '*',
        event = "BufAdd",
        config = require("modules.configs.tools.bufremove"),
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = require("modules.configs.tools.trouble")
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "BurntSushi/ripgrep",
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = require("modules.configs.tools.todo")

    },
    {
        "ggandor/leap.nvim",
        dependencies = {
            "tpope/vim-repeat",
        },
        config = require("modules.configs.tools.leap")
    },
    -- {
    --     'nvimdev/lspsaga.nvim',
    --     config = function()
    --         require("modules.configs.tools.lspsaga")
    --     end,
    --     dependencies = {
    --         'nvim-treesitter/nvim-treesitter', -- optional
    --         'nvim-tree/nvim-web-devicons', -- optional
    --     }
    -- },
}

local global = require("core.global")
local vimpath = global.vim_path
local modules_dir = vimpath .. "/lua/modules"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local icons = {
    kind = require("modules.utils.icons").get("kind"),
    documents = require("modules.utils.icons").get("documents"),
    ui = require("modules.utils.icons").get("ui"),
    ui_sep = require("modules.utils.icons").get("ui", true),
    misc = require("modules.utils.icons").get("misc")
}

local LazyLoader = {
    plugins = {}
}

function LazyLoader:get_plugins()
    local list = {}
    local full_plugin_path = vim.split(vim.fn.glob(modules_dir .. "/plugins/*.lua"), "\n")

    -- get all plugins
    for _, v in ipairs(full_plugin_path) do
        list[#list + 1] = v:sub(#modules_dir - 6)
        list[#list] = list[#list]:sub(0, #list[#list] - 4)
    end

    for _, p in ipairs(list) do
        local mod = require(p)
        for _, v in pairs(mod) do
            self.plugins[#self.plugins + 1] = v
        end
    end
end

function LazyLoader:load_lazy()
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath })
    end

    self:get_plugins()

    local lazy_settings = {
        git = {
            log = { "-8" }, -- show the last 10 commits
            timeout = 120,
            url_format = "https://github.com/%s.git"
        },
        install = {
            -- install missing plugins on startup. This doesn't increase startup time.
            missing = true
        },
        ui = {
            -- a number <1 is a percentage., >1 is a fixed size
            size = {
                width = 0.88,
                height = 0.8
            },
            wrap = true, -- wrap the lines in the ui
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = "rounded",
            -- backdrop = 60, -- doesn't seem to work
            icons = {
                cmd = icons.misc.Code,
                config = icons.ui.Gear,
                event = icons.kind.Event,
                ft = icons.documents.Files,
                init = icons.misc.ManUp,
                import = icons.documents.Import,
                keys = icons.ui.Keyboard,
                loaded = icons.ui.Check,
                not_loaded = icons.misc.Ghost,
                plugin = icons.ui.Package,
                runtime = icons.misc.Vim,
                source = icons.kind.StaticMethod,
                start = icons.ui.Play,
                list = { icons.ui_sep.BigCircle, icons.ui_sep.BigUnfilledCircle, icons.ui_sep.Square,
                    icons.ui_sep.ChevronRight }
            },
            -- custom_keys = {
            --     ["<leader>l"] = {
            --         function(plugin)
            --             require("lazy.util").float_term({ "lazygit", "log" }, {
            --                 cwd = plugin.dir,
            --             })
            --         end,
            --         desc = "Open lazygit log",
            --     },
            -- }
        },
        -- checker = {
        --     -- automatically check for plugin updates
        --     enabled = false,
        --     concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        --     notify = true,        -- get a notification when new updates are found
        --     frequency = 3600,     -- check for updates every hour
        --     check_pinned = false, -- check for pinned packages that can't be updated
        -- },
        -- change_detection = {
        --     -- automatically check for config file changes and reload the ui
        --     enabled = true,
        --     notify = true, -- get a notification when changes are found
        -- },
        performance = {
            cache = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/lazy/cache",
                -- Once one of the following events triggers, caching will be disabled.
                -- To cache all modules, set this to `{}`, but that is not recommended.
                disable_events = { "UIEnter", "BufReadPre" },
                ttl = 3600 * 24 * 2 -- keep unused modules for up to 2 days
            },
            reset_packpath = true,  -- reset the package path to improve startup time
            rtp = {
                reset = true,       -- reset the runtime path to $VIMRUNTIME and the config directory
                ---@type string[]
                paths = {}          -- add any custom paths here that you want to include in the rtp
            }
        }
    }

    if global.is_mac then
        lazy_settings.concurrency = 20
    end

    vim.opt.rtp:prepend(lazypath)
    require("lazy").setup(LazyLoader.plugins, lazy_settings)
end

LazyLoader:load_lazy()

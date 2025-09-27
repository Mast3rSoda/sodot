return function()
    local harpoon = require("harpoon").setup(
        {
            settings = {
                save_on_toggle = false,
                sync_on_ui_close = false,
                key = function()
                    return vim.loop.cwd()
                end,
            }
        }
    )

    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --     local file_paths = {}
    --     for _, item in ipairs(harpoon_files.items) do
    --         table.insert(file_paths, item.value)
    --     end
    --
    --     require("telescope.pickers").new({}, {
    --         prompt_title = "Harpoon",
    --         finder = require("telescope.finders").new_table({
    --             results = file_paths,
    --         }),
    --         previewer = conf.file_previewer({}),
    --         sorter = conf.generic_sorter({}),
    --     }):find()
    -- end

    vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
        local exp = vim.fn.expand("%")
        local v, index = harpoon:list():get_by_value(exp)
        if v == nil then return end
        print("added", exp, "to harpoon at pos", index)
    end)

    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    -- { desc = "Open harpoon window" })

    vim.keymap.set("n", "<A-1>", function()
        harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<A-2>", function()
        harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<A-3>", function()
        harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<A-4>", function()
        harpoon:list():select(4)
    end)
    vim.keymap.set("n", "<A-h>", function()
        harpoon:nav_prev()
    end)
    vim.keymap.set("n", "<A-l>", function()
        harpoon:list():nav_next()
    end)
end

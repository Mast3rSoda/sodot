return function()
    local cmp = require('cmp')
    local luasnip = require("luasnip")

    -- local has_words_before = function()
    --     unpack = unpack or table.unpack
    --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- end

    cmp.setup({
        enabled = function()
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                local context = require 'cmp.config.context'
                return not context.in_treesitter_capture("comment")
                    and not context.in_syntax_group("Comment")
                    and not context.in_treesitter_capture("string")
                    and not context.in_syntax_group("String")
            end
        end,
        -- performance = {
        -- },

        preselect = cmp.PreselectMode.None,

        mapping = {
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm({
                        select = true,
                        behavior = cmp.ConfirmBehavior.Replace,
                    })
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                    -- NOTE: feel?
                    -- elseif has_words_before() then
                    --     cmp.complete()
                    --     if #cmp.get_entries() == 1 then
                    --         cmp.confirm({
                    --             select = true,
                    --         })
                    --     end
                else
                    fallback()
                end
            end, { "i", "s" }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ['<C-f>'] = cmp.mapping(
                function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            ['<C-b>'] = cmp.mapping(
                function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            ['<C-u>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(-4)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            ['<C-d>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(4)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
        },

        snippet = {
            expand = function(args)
                ---@diagnostic disable-next-line: undefined-field
                require("luasnip").lsp_expand(args.body)
            end,
        },

        completion = {
            keyword_length = 1,
            autocomplete = {
                cmp.TriggerEvent.TextChanged,
                cmp.TriggerEvent.InsertEnter
            },
            completeopt = "menu,menuone,noinsert,preview"
        },

        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                -- local menu_icon = {
                --     nvim_lsp = 'λ',
                --     luasnip = '⋗',
                --     buffer = 'Ω',
                --     path = '🖫',
                --     nvim_lua = 'Π',
                -- }
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"
                kind.menu = kind.menu .. string.rep(" ", 12 - #strings[2]) .. "[" .. (entry.source.name or "") .. "]"
                -- kind.menu = kind.menu .. string.rep(" ", 12 - #strings[2]) .. (menu_icon[entry.source.name] or "")
                return kind
            end,
        },

        sources = cmp.config.sources(
            {
                {
                    name = 'luasnip',
                    group_index = 1,
                    max_item_count = 4
                }, -- For luasnip users.
                {
                    name = 'nvim_lsp',
                    group_index = 2,
                    entry_filter = function(entry, ctx)
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    end
                },
                -- NOTE: either disabled string syntax group or this
                -- {
                --     name = 'buffer',
                --     group_index = 3,
                --     keyword_length = 2,
                --     max_item_count = 5,
                --     option = {
                --         get_bufnrs = function()
                --             local bufs = {}
                --             for _, win in ipairs(vim.api.nvim_list_wins()) do
                --                 bufs[vim.api.nvim_win_get_buf(win)] = true
                --             end
                --             return vim.tbl_keys(bufs)
                --         end
                --     }
                -- },
                -- { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'snippy' }, -- For snippy users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
            }
        ),

        view = {
            docs = {
                auto_open = 'true',
            },
            entries = {
                name = "custom",
                selection_order = 'top_down',
                follow_cursor = 'false',

            }
        },


        window = {
            completion = {
                border = 'rounded',
                scrollbar = '║',
                col_offset = -3,
                side_padding = 0,
            },
            documentation = { -- no border; native-style scrollbar
                border = 'rounded',
                scrollbar = '║',
                -- other options
            },
        },
        experimental = {
            ghost_text = true,
        }
    })

    local cmd_settings = {
        mapping = {
            ['<Tab>'] = {
                c = function()
                    if cmp.visible() then
                        if #cmp.get_entries() == 1 then
                            cmp.confirm({
                                select = true,
                            })
                        else
                            cmp.select_next_item()
                        end
                    else
                        cmp.complete()
                    end
                end,
            },
            ['<Space>'] = {
                c = function(fallback)
                    if cmp.visible() then
                        if cmp.get_selected_entry() ~= nil then
                            cmp.confirm({
                                select = true,
                                behavior = cmp.ConfirmBehavior.Insert,
                            })
                        else
                            fallback()
                        end
                    else
                        fallback()
                    end
                end,
            },

            ['<S-Tab>'] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        cmp.complete()
                    end
                end,
            },
        },
        completion_with_ac = {
            keyword_length = 2,
            autocomplete = {
                cmp.TriggerEvent.InsertEnter
            },
            completeopt = "menu,menuone,noselect,preview"
        },
        sources = cmp.config.sources({
            {
                name = 'path',
                group_index = 1
            }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!', }
                },
                group_index = 1,
            },
        }),

    }

    cmp.setup.cmdline('/', {
        mapping = cmd_settings.mapping,
        preselect = cmp.PreselectMode.None,

        completion = cmd_settings.completion_with_ac,


        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmd_settings.mapping,
        preselect = cmp.PreselectMode.None,

        completion = cmd_settings.completion_with_ac,
        -- matching = {
        --     disallow_symbol_nonprefix_matching = false
        -- },

        sources = cmd_settings.sources
    })


    cmp.event:on(
        'confirm_done',
        require('nvim-autopairs.completion.cmp').on_confirm_done()
    )

    vim.keymap.set({ "i", "s" }, "<leader>h", function()
        cmp.complete({
            config = {
                completion = {
                    completeopt = "menu,menuone,preview"
                },

                preselect = cmp.PreselectMode.None,
            }
        })
    end)

    vim.keymap.set({ "c" }, "<leader>h", function()
        cmp.complete({
            config = {
                mapping = cmd_settings.mapping,
                completion = {
                    completeopt = "menu,menuone,preview"
                },

                preselect = cmp.PreselectMode.None,
                sources = cmd_settings.sources
            }
        })
    end)

    -- Customization for Pmenu
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#330C1F", fg = "NONE" })
    vim.api.nvim_set_hl(0, "Pmenu", { fg = "#EBC0D4", bg = "#150B0F" })

    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#BF1D6B", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#BF1D6B", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#8FBFC7", bg = "NONE", italic = true })

    -- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
    -- vim.api.nvim_se330C1F330C1F330C1F330C1Ft_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })
    --
    -- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
end

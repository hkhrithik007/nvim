local M = {}

function M.setup()
  local blink = require("blink.cmp")
  local ok, luasnip = pcall(require, "luasnip")

  blink.setup({
    enabled = function()
      local filetype = vim.bo.filetype

      return not vim.tbl_contains({
        "TelescopePrompt",
        "minifiles",
        "snacks_picker_input",
        "NvimTree",
        "nvimtree",
        "DressingInput",
      }, filetype)
    end,

    sources = {
      default = {
        "ripgrep",
        "lsp",
        "snippets",
        "codeium",
      },

      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
        },

        codeium = {
          name = "Codeium",
          module = "codeium.blink",
          async = true,
        },

        snippets = {
          name = "snippets",
          enabled = true,
          module = "blink.cmp.sources.snippets",
        },

        ripgrep = {
          name = "Ripgrep",
          module = "blink-ripgrep",
        },

        cmdline = {
          name = "cmdline",
          module = "blink.cmp.sources.cmdline",
        },

        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets" },
          min_keyword_length = 2,

          opts = {
            trailing_slash = false,
            label_trailing_slash = true,

            get_cwd = function(context)
              if context and context.bufnr then
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end

              return vim.fn.getcwd()
            end,

            show_hidden_files_by_default = true,
          },
        },
      },
    },

    cmdline = {
      enabled = true,

      keymap = {
        preset = "inherit",
      },

      completion = {
        menu = {
          auto_show = true,
        },
      },
    },

    completion = {
      keyword = {
        range = "full",
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },

      accept = {
        auto_brackets = {
          enabled = true,
        },
      },

      menu = {
        border = "rounded",
        auto_show = true,

        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },

      documentation = {
        auto_show = true,

        window = {
          border = "single",
        },
      },

      ghost_text = {
        enabled = false,
      },
    },

    snippets = {
      preset = "luasnip",

      expand = function(snippet)
        if ok then
          luasnip.lsp_expand(snippet)
        end
      end,

      active = function(filter)
        if not ok then
          return false
        end

        if filter and filter.direction then
          return luasnip.jumpable(filter.direction)
        end

        return luasnip.in_snippet()
      end,

      jump = function(direction)
        if ok then
          luasnip.jump(direction)
        end
      end,
    },

    keymap = {
      preset = "enter",

      ["<Down>"] = { "snippet_forward", "fallback" },
      ["<Up>"] = { "snippet_backward", "fallback" },

      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },

      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<S-k>"] = { "scroll_documentation_up", "fallback" },
      ["<S-j>"] = { "scroll_documentation_down", "fallback" },

      ["<C-space>"] = {
        "show",
        "show_documentation",
        "hide_documentation",
      },

      ["<C-e>"] = { "hide", "fallback" },
    },

    appearance = {
      nerd_font_variant = "normal",
    },

    signature = {
      enabled = true,

      window = {
        border = "rounded",
      },
    },
  })
end

return M

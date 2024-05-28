local lazy = require("lazy")
return {
  --This is for Coding based plugins
  {
    "stevearc/conform.nvim",
    enabled = false,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "mfussenegger/nvim-jdtls",
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    event = "BufRead",
    config = function()
      require("configs.toggleterm")
    end,
  },
  {
    "jayp0521/mason-null-ls.nvim",
    lazy = "VeryLazy",
    enabled = true,
    dependencies = {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "nvimtools/none-ls-extras.nvim",
        lazy = true,
        event = { "BufRead" },
      },
      config = function()
        require("configs.null_ls")
      end,
    },
    event = { "InsertEnter", "BufRead", "BufnewFile" },
    opts = function()
      require("configs.mason_null_ls")
    end,
  },
  {
    {
      "CRAG666/code_runner.nvim",
      event = { "BufRead", "BufReadPre" },
      dependencies = "nvim-lua/plenary.nvim",
      cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
      config = function()
        require("configs.coderunner")
      end,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "kotlin-language-server",
        "jdtls",
        -- "html-lsp",
        -- "css-lsp",
        -- "prettier",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = "VeryLazy",
    requries = { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "java",
        "kotlin",
      },
    },
  },
  --This section is for Debug
  {
    {
      "rcarriga/nvim-dap-ui",
      lazy = "VeryLazy",
      event = "BufRead",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      config = function()
        require("configs.dapui")
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      lazy = "VeryLazy",
      event = "BufRead",
      dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
      config = function()
        require("configs.mason_dap")
      end,
    },
  },
  {
    { "williamboman/mason.nvim",           lazy = true },
    { "williamboman/mason-lspconfig.nvim", lazy = true },
  },
  --This is for UI
  {
    {
      "folke/noice.nvim",
      enabled = true,
      lazy = true,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      event = { "BufRead", "BufnewFile", "BufReadPre" },
      opts = {
        presets = { "inc_rename" },
        messages = {
          enabled = false,
        },
        notify = {
          enabled = true,
        },
        lsp = {
          progress = {
            enabled = true,
          },
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
      },
      keys = {
        {
          "<S-Enter>",
          function()
            require("noice").redirect(vim.fn.getcmdline())
          end,
          mode = "c",
          desc = "Redirect Cmdline",
        },
        {
          "<leader>snl",
          function()
            require("noice").cmd("last")
          end,
          desc = "Noice Last Message",
        },
        {
          "<leader>snh",
          function()
            require("noice").cmd("history")
          end,
          desc = "Noice History",
        },
        {
          "<leader>sna",
          function()
            require("noice").cmd("all")
          end,
          desc = "Noice All",
        },
        {
          "<c-f>",
          function()
            if not require("noice.lsp").scroll(4) then
              return "<c-f>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll forward",
          mode = { "i", "n", "s" },
        },
        {
          "<c-b>",
          function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-b>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll backward",
          mode = { "i", "n", "s" },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup()
    end,
  },
  {
    "yamatsum/nvim-cursorline",
    lazy = true,
    event = { "BufRead", "BufnewFile" },
    config = function()
      require("configs.cursorline")
    end,
  },
  {
    {
      "stevearc/dressing.nvim",
      lazy = true,
      event = { "BufRead", "BufnewFile" },
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "dressing.nvim" } })
          return vim.ui.input(...)
        end
      end,
    },
  },

  {
    "max397574/better-escape.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("configs.better-escape")
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    enabled = true,
    event = "VimEnter",
    config = function()
      -- config
      require("configs.dashboard")
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    lazy = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      dofile(vim.g.base46_cache .. "whichkey")
      require("configs.whichkey")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    lazy = "VeryLazy",
    event = { "BufRead", "BufnewFile", "InsertEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("configs.lualine")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs.webdevicons")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("configs.nvimtree")
    end,
  },
  --This is the section of indention scope
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "nvim-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  --This section is for Ai
  {
    {
      "Exafunction/codeium.vim",
      enabled = true,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      -- event = "BufEnter",
      event = { "InsertEnter" },
      -- config = function()
      -- require("codeium").setup()
      -- end,

      config = function()
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<C-;>", function()
          return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<C-,>", function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<C-x>", function()
          return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true })
        vim.keymap.set({ "i", "n" }, "<C-h", function()
          return vim.fn["codeium#Chat"]()
        end, { expr = true, silent = true })
      end,
    },
    {
      "David-Kunz/gen.nvim",
      enabled = true,
      event = { "BufRead", "BufNewFile" },
      lazy = "VeryLazy",
      config = function()
        vim.keymap.set(
          "n",
          "<leader>sm",
          ":lua require('gen').select_model()<cr>",
          { noremap = true, silent = true }
        )
      end,
    },
    -- {
    --   "codota/tabnine-nvim",
    --   lazy = "VeryLazy",
    --   build = "./dl_binaries.sh",
    --   enabled = false,
    --   config = function()
    --     require("configs.tabnine")
    --   end,
    -- },
    --game
    {
      "seandewar/killersheep.nvim",
      lazy = true,
      event = "BufRead",
      config = function()
        require("configs.killersheep")
      end,
    },
    --theme
    -- {
    --   "scottmckendry/cyberdream.nvim",
    --   lazy = true,
    --   enabled = false,
    --   -- priority = 1000,
    --   config = function()
    --     require("configs.cyberdream")
    --   end,
    -- },
    --mode
    -- {
    --   "folke/twilight.nvim",
    --   lazy = true,
    --   event = "BufRead",
    --   config = function()
    --     require("twilight").setup()
    --   end,
    -- },
    --addons
    {
      {
        "folke/flash.nvim",
        lazy = true,
        event = "BufRead",
        opts = {},
        -- stylua: ignore
        keys =
        {
          { "A",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
          { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
          { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
          { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
      },
      {
        "mrjones2014/smart-splits.nvim",
        event = "BufRead",
        lazy = "VeryLazy",
        config = function()
          require("configs.smart-split")
        end,
      },
      -- Add other plugins here...
    },
  },
}

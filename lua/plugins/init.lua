---@diagnostic disable-next-line: unused-local
local lazy = require "lazy"
return {
  --disabed plugins
  {

    {
      "numToStr/Comment.nvim",
      enabled = false,
      config = function()
        require "configs.comment"
      end,
    },
  },
  --This is for Coding based plugins
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      local PATH = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(PATH)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    lazy = "VeryLazy",
    enabled = true,
    config = function()
      require "configs.lint"
    end,
  },
  --this is for formating
  {
    "stevearc/conform.nvim",
    enabled = true,
    config = function()
      require "configs.conform"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = "VeryLazy",
    cmd = "ToggleTerm",
    -- event = "BufRead",
    config = function()
      require "configs.toggleterm"
    end,
  },
  {
    "CRAG666/code_runner.nvim",
    enabled = true,
    event = { "BufRead", "BufReadPre" },
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    config = function()
      require "configs.coderunner"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "luacheck",
        -- "kotlin-language-server",
        "jdtls",
        "java-debug-adapter",
        -- "ktfmt",
        "google-java-format",
        "trivy",
        "mypy",
        "debugpy",
        "black",
        "ruff",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    requries = { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "java",
        "kotlin",
        "python",
      },
    },
  },
  {
    "zeioth/garbage-day.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      aggressive_mode = true,
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
        require "configs.dapui"
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      lazy = "VeryLazy",
      -- event = "BufRead",
      dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
      config = function()
        require "configs.mason_dap"
      end,
    },
  },
  --This is for UI
  {
    {
      "folke/noice.nvim",
      enabled = true,
      lazy = "VeryLazy",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      -- event = { "BufRead", "BufnewFile", "BufReadPre" },
      opts = {
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
    },
  },
  {
    "dgox16/oldworld.nvim",
    enabled = true,
    lazy = "VeryLazy",
    config = function()
      require("oldworld").setup()
    end,
  },
  {
    "yamatsum/nvim-cursorline",
    lazy = true,
    event = { "BufRead", "BufnewFile" },
    config = function()
      require "configs.cursorline"
    end,
  },
  {
    {
      "stevearc/dressing.nvim",
      lazy = "VeryLazy",
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load { plugins = { "dressing.nvim" } }
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load { plugins = { "dressing.nvim" } }
          return vim.ui.input(...)
        end
      end,
    },
  },
  {
    "nvimdev/dashboard-nvim",
    enabled = true,
    event = "VimEnter",
    config = function()
      require "configs.dashboard"
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "folke/which-key.nvim",
    lazy = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      dofile(vim.g.base46_cache .. "whichkey")
      require "configs.whichkey"
    end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    enabled = true,
    lazy = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "live_grep_args"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    lazy = "VeryLazy",
    event = { "BufRead", "BufnewFile", "InsertEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.lualine"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "configs.webdevicons"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.nvimtree"
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
      commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2",
      event = { "InsertEnter" },
      config = function()
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<C-;>", function()
          return vim.fn["codeium#CycleCompletions"]
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<C-,>", function()
          return vim.fn["codeium#CycleCompletions"]
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
      -- lazy = "VeryLazy",
      config = function()
        vim.keymap.set("n", "<leader>sm", ":lua require('gen').select_model()<cr>", { noremap = true, silent = true })
      end,
    },
    --game
    {
      "seandewar/killersheep.nvim",
      event = "BufRead",
      config = function()
        require "configs.killersheep"
      end,
    },
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
          require "configs.smart-split"
        end,
      },
      -- Add other plugins here...
    },
    {
      "karb94/neoscroll.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require "configs.neoscroll"
      end,
    },
    {
      "p5quared/apple-music.nvim",
      enabled = false,
      lazy = "VeryLazy",
      dependencies = { "nvim-telescope/telescope.nvim" },
      config = true,
    },
  },
}

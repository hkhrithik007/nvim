return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "BufReadPre",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require "configs.noice"
    end,
  },
     {
    "saghen/blink.cmp",
    event = "InsertEnter",
    build = "cargo build --release", -- Uncomment this line
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
      {
        "saghen/blink.compat",
        main = "blink-compat",
        version = "*",
        opts = {
          impersonate_nvim_cmp = true,
          enable_events = true,
        },
      },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load "friendly-snippets"
        end,
      },
    },
    config = function()
      require("configs.blink").setup()
    end,
  },

  {
    "Exafunction/windsurf.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("codeium").setup {
        enable_cmp_source = true,
        virtual_text = { enabled = false },
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "mfussenegger/nvim-dap",
    ft = { ".java", "kt", "python" },
    lazy = true,
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require "configs.dap"
    end,
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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    -- opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = false },
    -- explorer = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- picker = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    -- },
    config = function(_, opts)
      require("configs.snacks").setup(opts)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    ft = { "java", "kotlin" },
    lazy = true,
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require "configs.dapui"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    ft = { "java", "kotlin" },
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require "configs.mason_dap"
    end,
  },
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
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
    event = "VimEnter",
    config = function()
      require "configs.dashboard"
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "BufRead",
    -- lazy = "VeryLazy",
    config = function()
      require "configs.split"
    end,
  },
  {
    "CRAG666/code_runner.nvim",
    event = { "BufRead", "BufReadPre" },
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    config = function()
      require "configs.coderunner"
    end,
  },
  {
    "folke/flash.nvim",
    enabled = true,
    lazy = true,
    vscode = true,
    event = "BufRead",
    opts = {},
    -- stylua: ignore
    keys =
    {
      { "A",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "T",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
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
        ":lua require('gen').select_model()<CR>",
        { desc = "Select LLM Model", noremap = true, silent = true }
      )
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = { "BufRead", "BufNewFile" },
    lazy = true,
    config = function()
      require "configs.neoscroll"
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = "VeryLazy",
    cmd = "ToggleTerm",
    config = function()
      require "configs.toggleterm"
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
  {
    "mrjones2014/smart-splits.nvim",
    event = "BufRead",
    lazy = "VeryLazy",
    config = function()
      require "configs.split"
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = "VeryLazy",
    config = function()
      require "configs.whichkey"
    end,
  },
  {
    "ngtuonghy/live-server-nvim",
    enabled = true,
    ft = "html",
    build = ":LiveServerInstall",
    config = function()
      require("live-server-nvim").setup {}
    end,
  },
}

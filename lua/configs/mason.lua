local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- If Blink.cmp is available, use its LSP capabilities
pcall(function()
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
end)

-- On attach
local function on_attach(client, bufnr)
  local opts = {
    buffer = bufnr,
    silent = true,
  }

  -- Navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  -- Hover
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover {
      border = "rounded",
    }
  end, opts)

  -- Signature help
  vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help {
      border = "rounded",
    }
  end, opts)

  -- Rename
  -- Intentionally disabled so <leader>rn does not appear
  -- inside the <leader>r Run menu.
  --
  -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  -- Code actions
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

  -- Format
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format {
      async = true,
    }
  end, opts)
end

-- Mason setup
mason.setup()

mason_lspconfig.setup {
  ensure_installed = {
    "pyright",
    "lua_ls",
    "jdtls",
    "ts_ls",
    "clangd",
  },
  automatic_installation = true,
}

-- LSP server configurations
local servers = {
  pyright = {
    capabilities = capabilities,
    on_attach = on_attach,
  },

  lua_ls = {
    capabilities = capabilities,
    on_attach = on_attach,

    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },

        telemetry = {
          enable = false,
        },

        diagnostics = {
          globals = {
            "vim",
          },
        },
      },
    },
  },

  jdtls = {
    capabilities = capabilities,
    on_attach = on_attach,
  },

  ts_ls = {
    capabilities = capabilities,
    on_attach = on_attach,
  },

  clangd = {
    capabilities = capabilities,
    on_attach = on_attach,

    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--fallback-style=llvm",
    },

    filetypes = {
      "c",
      "cpp",
      "objc",
      "objcpp",
    },
  },
}

-- Configure and enable LSP servers
for server_name, config in pairs(servers) do
  vim.lsp.config(server_name, config)
  vim.lsp.enable(server_name)
end

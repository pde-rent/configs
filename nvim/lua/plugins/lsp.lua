return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Core languages
          "lua_ls",          -- Lua
          "ts_ls",           -- TypeScript/JavaScript
          "pyright",         -- Python
          "gopls",           -- Go
          "rust_analyzer",   -- Rust
          "zls",             -- Zig
          "clangd",          -- C/C++

          -- Web development
          "html",            -- HTML
          "cssls",           -- CSS
          "somesass_ls",     -- SCSS (correct name)
          "jsonls",          -- JSON

          -- Additional languages
          "bashls",          -- Bash/Shell
          "sqlls",           -- SQL
          "yamlls",           -- YAML
          "taplo",           -- TOML
          -- "glslls",       -- GLSL (CMake version issue)
          -- "ruby_lsp",     -- Ruby (needs Ruby >= 3.1)
          -- "solidity_ls",  -- Solidity (Node.js v23 issue)
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "prettier",        -- JS/TS/JSON/HTML/CSS/YAML/Markdown/Solidity
          "stylua",          -- Lua
          "ruff",            -- Python
          "shfmt",           -- Shell/Bash
          "rustfmt",         -- Rust
          "clang-format",    -- C/C++
          "taplo",           -- TOML
          "sql-formatter",   -- SQL
          -- "rubocop",      -- Ruby (needs Ruby >= 2.7)

          -- Linters
          "eslint",          -- JavaScript/TypeScript
          "pylint",          -- Python
          "shellcheck",      -- Shell
          "htmlhint",        -- HTML
          "stylelint",       -- CSS/SCSS
          "yamllint",        -- YAML
          "jsonlint",        -- JSON
          "sqlfluff",        -- SQL
          "golangci-lint",   -- Go
          -- "luacheck",     -- Lua (needs luarocks)
          -- "solhint",      -- Solidity
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          local bufopts = { noremap = true, silent = true, buffer = bufnr }

          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)

          -- Documentation / Hover
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)

          -- Code actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

          -- Completion
          if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
          end

          -- Auto-show hover documentation on cursor hold
          if client:supports_method("textDocument/hover") then
            vim.api.nvim_create_autocmd("CursorHold", {
              buffer = bufnr,
              callback = function()
                -- Only show if no floating window is already open
                local wins = vim.api.nvim_list_wins()
                for _, win in ipairs(wins) do
                  if vim.api.nvim_win_get_config(win).relative ~= "" then
                    return  -- A floating window is already open
                  end
                end
                vim.lsp.buf.hover()
              end,
            })
          end
        end,
      })

      -- LSP server capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Global LSP configuration
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Language-specific configurations
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
            },
          },
        },
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      })

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })

      vim.lsp.config("ruby_lsp", {
        capabilities = capabilities,
      })

      vim.lsp.config("solidity_ls", {
        capabilities = capabilities,
      })

      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      -- Enable all configured servers
      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "pyright",
        "gopls",
        "rust_analyzer",
        "zls",
        "clangd",
        "bashls",
        "html",
        "cssls",
        "somesass_ls",
        "jsonls",
        "sqlls",
        "taplo",
        "yamlls",
        -- "ruby_lsp",     -- Disabled: needs Ruby >= 3.1
        -- "solidity_ls",  -- Disabled: Node.js v23 compatibility issue
      })
    end,
  },
}

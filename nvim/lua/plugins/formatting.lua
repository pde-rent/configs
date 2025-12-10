return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          -- Web development
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          jsx = { "prettier" },
          tsx = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },

          -- Python
          python = { "ruff_format", "ruff_organize_imports" },

          -- Compiled languages
          c = { "clang-format" },
          cpp = { "clang-format" },
          h = { "clang-format" },
          hpp = { "clang-format" },
          rust = { "rustfmt" },
          go = { "gofmt" },
          zig = { "zigfmt" },

          -- Database & Query languages
          sql = { "sql-formatter" },
          pqt = { "prettier" },

          -- Shaders
          glsl = { "clang-format" },

          -- Markup & Config
          toml = { "taplo" },
          csv = { "prettier" },

          -- Shells
          bash = { "shfmt" },
          sh = { "shfmt" },
          zsh = { "shfmt" },

          -- Scripting languages
          lua = { "stylua" },
          -- ruby = { "rubocop" },  -- Disabled: needs Ruby >= 2.7

          -- Blockchain
          -- solidity = { "prettier" },  -- Can enable if prettier-plugin-solidity installed
        },

        formatters = {
          ["clang-format"] = {
            prepend_args = { "--style=file" },
          },
          prettier = {
            extra_args = { "--prose-wrap", "always" },
          },
          shfmt = {
            prepend_args = { "-i", "2" },
          },
        },

        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      -- Format command
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        conform.format({ async = true, lsp_fallback = true })
      end, { noremap = true, silent = true })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- Python
        python = { "ruff", "pylint" },

        -- JavaScript/TypeScript
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        json = { "jsonlint" },
        jsonc = { "jsonlint" },

        -- Shells
        bash = { "shellcheck" },
        sh = { "shellcheck" },
        zsh = { "shellcheck" },

        -- Markup
        html = { "htmlhint" },
        css = { "stylelint" },
        scss = { "stylelint" },
        yaml = { "yamllint" },
        toml = { "taplo" },

        -- SQL
        sql = { "sqlfluff" },

        -- C/C++ (linting via clangd LSP)
        -- clang-tidy runs automatically via clangd

        -- Go
        go = { "golangci_lint" },

        -- Ruby (disabled: needs Ruby >= 2.7)
        -- ruby = { "rubocop" },

        -- Lua (disabled: needs luarocks)
        -- lua = { "luacheck" },

        -- Solidity (disabled: needs npm)
        -- solidity = { "solhint" },
      }

      -- Create autocommand for linting on save
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { noremap = true, silent = true })
    end,
  },
}

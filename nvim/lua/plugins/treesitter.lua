return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Core
          "vim",
          "vimdoc",
          "query",
          "lua",

          -- Web development
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "scss",
          "json",
          "jsonc",
          "yaml",

          -- Python
          "python",

          -- Compiled languages
          "c",
          "cpp",
          "go",
          "rust",
          "zig",

          -- Shells & scripting
          "bash",

          -- Interpreted languages
          "ruby",

          -- Data languages
          "sql",
          "toml",

          -- Shader languages
          "glsl",

          -- Documentation & markup
          "markdown",
          "markdown_inline",

          -- Other
          "solidity",
          "diff",
          "git_config",
          "git_rebase",
          "gitignore",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        -- Text objects
        textobjects = {
          enable = true,
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = "@statement.outer",
            },
          },
        },
      })
    end,
  },
}

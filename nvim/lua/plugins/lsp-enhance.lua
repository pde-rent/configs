return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({
        ui = {
          theme = "round",
          border = "rounded",
          winblend = 0,
          expand = "",
          collapse = "",
          code_action = "💡",
          actionfix = " ",
          lines = { "┗", "┣", "┃", "━", "┏" },
          kind = {},
          imp_sign = "󰳛 ",
        },
        hover = {
          max_width = 0.6,
          max_height = 0.8,
          open_link = "gx",
          open_cmd = "!open",
        },
        diagnostic = {
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          max_width = 0.7,
          max_height = 0.6,
          text_hl_follow = true,
          border_follow = true,
          diagnostic_only_current = false,
          keys = {
            exec_action = "o",
            quit = "q",
            toggle_or_jump = "<CR>",
          },
        },
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          extend_gitsigns = false,
          keys = {
            quit = "q",
            exec = "<CR>",
          },
        },
        lightbulb = {
          enable = true,
          enable_in_insert = true,
          sign = true,
          sign_priority = 40,
          virtual_text = false,
        },
        rename = {
          in_select = true,
          auto_save = false,
          keys = {
            quit = "<Esc>",
            exec = "<CR>",
            select = "x",
          },
        },
        outline = {
          win_position = "right",
          win_width = 30,
          auto_preview = true,
          detail = true,
          auto_close = true,
          close_after_jump = false,
          keys = {
            toggle_or_jump = "<CR>",
            quit = "q",
          },
        },
        symbol_in_winbar = {
          enable = false,
        },
        beacon = {
          enable = true,
          frequency = 7,
        },
      })

      -- Keybindings for lspsaga
      vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<cr>", { desc = "LSP Finder" })
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover Documentation" })
      vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek Definition" })
      vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<cr>", { desc = "Go to Definition" })
      vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" })
      vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
      vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", { desc = "Outline" })
      vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Previous Diagnostic" })
      vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic" })
      vim.keymap.set("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, { desc = "Previous Error" })
      vim.keymap.set("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, { desc = "Next Error" })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup({
        input_buffer_type = "dressing",
        post_hook = function()
          vim.cmd("normal! zz")
        end,
      })

      vim.keymap.set("n", "<leader>rr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "Incremental Rename" })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "➤ ",
          win_options = {
            winblend = 0,
          },
        },
        select = {
          enabled = true,
          backend = { "telescope", "builtin" },
          telescope = require("telescope.themes").get_cursor(),
        },
      })
    end,
  },
}

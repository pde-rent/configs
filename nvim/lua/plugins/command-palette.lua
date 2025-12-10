return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "LinArcX/telescope-command-palette.nvim",
    },
    config = function()
      local telescope = require("telescope")

      -- Load the command palette extension
      telescope.load_extension("command_palette")

      -- Setup command palette with VS Code-like commands
      require("telescope").setup({
        extensions = {
          command_palette = {
            {
              "File",
              { "Find Files", ":Telescope find_files" },
              { "Recent Files", ":Telescope oldfiles" },
              { "Live Grep", ":Telescope live_grep" },
              { "File Browser", ":NvimTreeToggle" },
              { "Save File", ":w" },
              { "Save All", ":wa" },
              { "Close Buffer", ":bd" },
              { "New File", ":enew" },
            },
            {
              "LSP",
              { "Go to Definition", ":Lspsaga goto_definition" },
              { "Peek Definition", ":Lspsaga peek_definition" },
              { "Find References", ":Telescope lsp_references" },
              { "Rename Symbol", ":Lspsaga rename" },
              { "Code Action", ":Lspsaga code_action" },
              { "Show Diagnostics", ":Telescope diagnostics" },
              { "Format Document", ":lua vim.lsp.buf.format()" },
              { "LSP Info", ":LspInfo" },
              { "Outline", ":Lspsaga outline" },
            },
            {
              "Git",
              { "Git Status", ":Telescope git_status" },
              { "Git Commits", ":Telescope git_commits" },
              { "Git Branches", ":Telescope git_branches" },
            },
            {
              "View",
              { "Toggle File Tree", ":NvimTreeToggle" },
              { "Toggle Diagnostics", ":Telescope diagnostics" },
              { "Symbols Outline", ":Lspsaga outline" },
              { "Buffers", ":Telescope buffers" },
            },
            {
              "Search",
              { "Search in Files", ":Telescope live_grep" },
              { "Search Buffers", ":Telescope buffers" },
              { "Search Commands", ":Telescope commands" },
              { "Search Help", ":Telescope help_tags" },
              { "Search Keymaps", ":Telescope keymaps" },
            },
            {
              "Help",
              { "Neovim Help", ":Telescope help_tags" },
              { "Key Mappings", ":Telescope keymaps" },
              { "Commands", ":Telescope commands" },
              { "Check Health", ":checkhealth" },
              { "Mason", ":Mason" },
              { "Lazy", ":Lazy" },
            },
          },
        },
      })

      -- Command Palette keybinding (Cmd+Shift+P like VS Code)
      vim.keymap.set("n", "<D-S-p>", ":Telescope command_palette<CR>", { desc = "Command Palette" })
      vim.keymap.set("n", "<leader>cp", ":Telescope command_palette<CR>", { desc = "Command Palette" })

      -- Additional useful Telescope commands
      vim.keymap.set("n", "<leader>:", ":Telescope commands<CR>", { desc = "Search Commands" })
      vim.keymap.set("n", "<leader>?", ":Telescope keymaps<CR>", { desc = "Search Keymaps" })
    end,
  },
}

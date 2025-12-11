-- Keybindings configuration
local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Telescope keybindings (VS Code style with macOS Command key)
map("n", "<D-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files (Cmd+P)" })
map("n", "<D-k>", "<cmd>Telescope live_grep<cr>", { desc = "Global fuzzy search (Cmd+K)" })
map("n", "<D-F>", "<cmd>Telescope live_grep<cr>", { desc = "Live grep search (Cmd+Shift+F)" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })

-- File tree (nvim-tree)
map("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree (Ctrl+B)" })
map("n", "<D-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree (Cmd+B)" })

-- Cmd+B: Toggle file tree (via Alacritty)
local cmd_b = vim.api.nvim_replace_termcodes("<Esc>[98;9u", true, false, true)
map("n", cmd_b, "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree (Cmd+B)" })
map("i", cmd_b, "<Esc><cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree (Cmd+B)" })
map("v", cmd_b, "<Esc><cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree (Cmd+B)" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to right window" })

-- LSP keybindings (Lspsaga will override these with enhanced versions)
-- These are fallbacks in case Lspsaga doesn't load
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- Formatting
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format document" })

-- Quick diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

-- Escape from terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- VSCode-like keybindings (via Alacritty CSI u encoding)
-- ============================================================================

-- Cmd+A: Select all
local cmd_a = vim.api.nvim_replace_termcodes("<Esc>[97;9u", true, false, true)
map("n", cmd_a, "ggVG", { desc = "Select all (Cmd+A)" })
map("v", cmd_a, "<Esc>ggVG", { desc = "Select all (Cmd+A)" })
map("i", cmd_a, "<Esc>ggVG", { desc = "Select all (Cmd+A)" })

-- Cmd+O: Open file
local cmd_o = vim.api.nvim_replace_termcodes("<Esc>[111;9u", true, false, true)
map("n", cmd_o, "<cmd>Telescope find_files<cr>", { desc = "Open file (Cmd+O)" })
map("i", cmd_o, "<Esc><cmd>Telescope find_files<cr>", { desc = "Open file (Cmd+O)" })
map("v", cmd_o, "<Esc><cmd>Telescope find_files<cr>", { desc = "Open file (Cmd+O)" })

-- Cmd+Z: Undo (using vim.keycode for proper escape sequence handling)
local cmd_z = vim.api.nvim_replace_termcodes("<Esc>[122;9u", true, false, true)
local cmd_shift_z = vim.api.nvim_replace_termcodes("<Esc>[122;10u", true, false, true)
local cmd_y = vim.api.nvim_replace_termcodes("<Esc>[121;9u", true, false, true)

map("n", cmd_z, "u", { desc = "Undo (Cmd+Z)" })
map("i", cmd_z, "<Esc>ui", { desc = "Undo (Cmd+Z)" })
map("v", cmd_z, "<Esc>u", { desc = "Undo (Cmd+Z)" })

-- Cmd+Shift+Z: Redo
map("n", cmd_shift_z, "<C-r>", { desc = "Redo (Cmd+Shift+Z)" })
map("i", cmd_shift_z, "<Esc><C-r>i", { desc = "Redo (Cmd+Shift+Z)" })
map("v", cmd_shift_z, "<Esc><C-r>", { desc = "Redo (Cmd+Shift+Z)" })

-- Cmd+Y: Redo (alternative)
map("n", cmd_y, "<C-r>", { desc = "Redo (Cmd+Y)" })
map("i", cmd_y, "<Esc><C-r>i", { desc = "Redo (Cmd+Y)" })
map("v", cmd_y, "<Esc><C-r>", { desc = "Redo (Cmd+Y)" })

-- Buffer management (Ctrl+Shift+W/T/N to avoid conflicts with terminal Cmd keys)
-- Ctrl+Shift+W: Close buffer
local ctrl_shift_w = vim.api.nvim_replace_termcodes("<Esc>[87;6u", true, false, true)
map("n", ctrl_shift_w, "<cmd>bdelete<cr>", { desc = "Close buffer (Ctrl+Shift+W)" })
map("i", ctrl_shift_w, "<Esc><cmd>bdelete<cr>", { desc = "Close buffer (Ctrl+Shift+W)" })
map("v", ctrl_shift_w, "<Esc><cmd>bdelete<cr>", { desc = "Close buffer (Ctrl+Shift+W)" })

-- Ctrl+Shift+T: New buffer/tab
local ctrl_shift_t = vim.api.nvim_replace_termcodes("<Esc>[84;6u", true, false, true)
map("n", ctrl_shift_t, "<cmd>enew<cr>", { desc = "New buffer (Ctrl+Shift+T)" })
map("i", ctrl_shift_t, "<Esc><cmd>enew<cr>", { desc = "New buffer (Ctrl+Shift+T)" })
map("v", ctrl_shift_t, "<Esc><cmd>enew<cr>", { desc = "New buffer (Ctrl+Shift+T)" })

-- Ctrl+Shift+N: New file
local ctrl_shift_n = vim.api.nvim_replace_termcodes("<Esc>[78;6u", true, false, true)
map("n", ctrl_shift_n, "<cmd>enew<cr>", { desc = "New file (Ctrl+Shift+N)" })
map("i", ctrl_shift_n, "<Esc><cmd>enew<cr>", { desc = "New file (Ctrl+Shift+N)" })
map("v", ctrl_shift_n, "<Esc><cmd>enew<cr>", { desc = "New file (Ctrl+Shift+N)" })

-- Ctrl+X: Cut
map("v", "<C-x>", '"+d', { desc = "Cut (Ctrl+X)" })

-- Ctrl+C: Copy (in visual mode only, keeps Ctrl+C as interrupt in normal/insert)
map("v", "<C-c>", '"+y', { desc = "Copy (Ctrl+C)" })

-- Ctrl+V: Paste
map("n", "<C-v>", '"+p', { desc = "Paste (Ctrl+V)" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste (Ctrl+V)" })

-- Cmd+X: Cut (macOS style)
local cmd_x = vim.api.nvim_replace_termcodes("<Esc>[120;9u", true, false, true)
map("v", cmd_x, '"+d', { desc = "Cut (Cmd+X)" })  -- Cut and exit visual mode
map("n", cmd_x, '"+dd', { desc = "Cut line (Cmd+X)" })

-- Cmd+C: Copy (macOS style)
local cmd_c = vim.api.nvim_replace_termcodes("<Esc>[99;9u", true, false, true)
map("v", cmd_c, '"+y<Esc>', { desc = "Copy (Cmd+C)" })  -- Copy and exit visual mode (VSCode-like)
map("n", cmd_c, '"+yy', { desc = "Copy line (Cmd+C)" })

-- Cmd+V: Paste (macOS style)
local cmd_v = vim.api.nvim_replace_termcodes("<Esc>[118;9u", true, false, true)
map("n", cmd_v, '"+p', { desc = "Paste (Cmd+V)" })
map("i", cmd_v, '<C-r>+', { desc = "Paste (Cmd+V)" })
map("v", cmd_v, '"_d"+P', { desc = "Paste over selection (Cmd+V)" })  -- Replace selection without yanking

-- Cmd+Left/Right: Start/End of line (VS Code style)
map("n", "<D-Left>", "^", { desc = "Go to start of line (Cmd+Left)" })
map("n", "<D-Right>", "$", { desc = "Go to end of line (Cmd+Right)" })
map("i", "<D-Left>", "<C-o>^", { desc = "Go to start of line (Cmd+Left)" })
map("i", "<D-Right>", "<C-o>$", { desc = "Go to end of line (Cmd+Right)" })
map("v", "<D-Left>", "^", { desc = "Go to start of line (Cmd+Left)" })
map("v", "<D-Right>", "$", { desc = "Go to end of line (Cmd+Right)" })

-- Arrow down on last line goes to EOL, arrow up on first line goes to SOL
map("n", "<Down>", function()
  local line = vim.fn.line(".")
  local last_line = vim.fn.line("$")
  if line == last_line then
    return "$"
  else
    return "j"
  end
end, { expr = true, desc = "Down or EOL on last line" })

map("n", "<Up>", function()
  local line = vim.fn.line(".")
  if line == 1 then
    return "^"
  else
    return "k"
  end
end, { expr = true, desc = "Up or SOL on first line" })

-- Cmd+A: Select all (standard macOS behavior - fallback for GUI nvim)
map("n", "<D-a>", "ggVG", { desc = "Select all (Cmd+A)" })
map("v", "<D-a>", "<Esc>ggVG", { desc = "Select all (Cmd+A)" })
map("i", "<D-a>", "<Esc>ggVG", { desc = "Select all (Cmd+A)" })

-- ============================================================================
-- Shift+Arrow Selection (VSCode-like)
-- ============================================================================

-- Shift+Left: Start/extend selection left
map("n", "<S-Left>", "vh", { desc = "Select left" })
map("v", "<S-Left>", "h", { desc = "Extend selection left" })
map("i", "<S-Left>", "<Esc>vh", { desc = "Select left" })

-- Shift+Right: Start/extend selection right
map("n", "<S-Right>", "vl", { desc = "Select right" })
map("v", "<S-Right>", "l", { desc = "Extend selection right" })
map("i", "<S-Right>", "<Esc>lvh", { desc = "Select right" })

-- Shift+Up: Start/extend selection up
map("n", "<S-Up>", "vk", { desc = "Select up" })
map("v", "<S-Up>", "k", { desc = "Extend selection up" })
map("i", "<S-Up>", "<Esc>vk", { desc = "Select up" })

-- Shift+Down: Start/extend selection down
map("n", "<S-Down>", "vj", { desc = "Select down" })
map("v", "<S-Down>", "j", { desc = "Extend selection down" })
map("i", "<S-Down>", "<Esc>vj", { desc = "Select down" })

-- Cmd+Shift+Left: Select to beginning of line
local cmd_shift_left = vim.api.nvim_replace_termcodes("<Esc>[1;10D", true, false, true)
map("n", cmd_shift_left, "v^", { desc = "Select to start of line" })
map("v", cmd_shift_left, "^", { desc = "Extend selection to start of line" })
map("i", cmd_shift_left, "<Esc>v^", { desc = "Select to start of line" })

-- Cmd+Shift+Right: Select to end of line
local cmd_shift_right = vim.api.nvim_replace_termcodes("<Esc>[1;10C", true, false, true)
map("n", cmd_shift_right, "v$", { desc = "Select to end of line" })
map("v", cmd_shift_right, "$", { desc = "Extend selection to end of line" })
map("i", cmd_shift_right, "<Esc>lv$", { desc = "Select to end of line" })

-- Shift+Home: Select to beginning of line
map("n", "<S-Home>", "v^", { desc = "Select to start of line" })
map("v", "<S-Home>", "^", { desc = "Extend selection to start of line" })
map("i", "<S-Home>", "<Esc>v^", { desc = "Select to start of line" })

-- Shift+End: Select to end of line
map("n", "<S-End>", "v$", { desc = "Select to end of line" })
map("v", "<S-End>", "$", { desc = "Extend selection to end of line" })
map("i", "<S-End>", "<Esc>lv$", { desc = "Select to end of line" })

-- ============================================================================
-- Go to Definition (VSCode-like)
-- ============================================================================

-- Ctrl+Click: Go to definition (terminal Neovim)
map("n", "<C-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition (Ctrl+Click)" })

-- Cmd+Click: Go to definition (GUI Neovim like Neovide)
map("n", "<D-LeftMouse>", "<LeftMouse><cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition (Cmd+Click)" })

-- F12: Go to definition
map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition (F12)" })

-- Shift+F12: Go to references
map("n", "<S-F12>", vim.lsp.buf.references, { desc = "Go to references (Shift+F12)" })

-- ============================================================================
-- Option+Arrow Word Navigation (VSCode-like)
-- ============================================================================

-- Option+Left: Move to beginning of previous word
local opt_left = vim.api.nvim_replace_termcodes("<Esc>[1;3D", true, false, true)
map("n", opt_left, "b", { desc = "Previous word (Opt+Left)" })
map("i", opt_left, "<C-o>b", { desc = "Previous word (Opt+Left)" })
map("v", opt_left, "b", { desc = "Previous word (Opt+Left)" })

-- Option+Right: Move to beginning of next word
local opt_right = vim.api.nvim_replace_termcodes("<Esc>[1;3C", true, false, true)
map("n", opt_right, "w", { desc = "Next word (Opt+Right)" })
map("i", opt_right, "<C-o>w", { desc = "Next word (Opt+Right)" })
map("v", opt_right, "w", { desc = "Next word (Opt+Right)" })

-- Option+Shift+Left: Select previous word
local opt_shift_left = vim.api.nvim_replace_termcodes("<Esc>[1;4D", true, false, true)
map("n", opt_shift_left, "vb", { desc = "Select previous word (Opt+Shift+Left)" })
map("i", opt_shift_left, "<Esc>vb", { desc = "Select previous word (Opt+Shift+Left)" })
map("v", opt_shift_left, "b", { desc = "Extend selection to previous word" })

-- Option+Shift+Right: Select next word
local opt_shift_right = vim.api.nvim_replace_termcodes("<Esc>[1;4C", true, false, true)
map("n", opt_shift_right, "vw", { desc = "Select next word (Opt+Shift+Right)" })
map("i", opt_shift_right, "<Esc>lvw", { desc = "Select next word (Opt+Shift+Right)" })
map("v", opt_shift_right, "w", { desc = "Extend selection to next word" })

-- ============================================================================
-- VSCode-like Visual Mode Behavior
-- ============================================================================

-- Delete/Backspace in visual mode deletes selection (VSCode-like)
map("v", "<Del>", "d", { desc = "Delete selection" })
map("v", "<BS>", "d", { desc = "Delete selection" })

-- Esc exits visual mode (already default, but explicit for clarity)
map("v", "<Esc>", "<Esc>", { desc = "Cancel selection" })

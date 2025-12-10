# Neovim Configuration

A modern Lua-based Neovim setup with VS Code-like features and Monokai theme.

## Features

### Core Functionality
- **Package Manager**: lazy.nvim (fast, modern plugin management)
- **LSP Support**: Mason + nvim-lspconfig with support for:
  - TypeScript/JavaScript (ts_ls + typescript-tools.nvim)
  - Python (Pyright)
  - Go (gopls)
  - Rust (rust_analyzer)
  - Zig (zls)
  - C/C++ (clangd)
  - Solidity
  - Bash/Shell
  - Lua

### Enhanced LSP Experience
- **lspsaga.nvim**: VS Code-like LSP UI with:
  - Beautiful hover documentation windows
  - Code action lightbulb 💡
  - Peek definition (preview without jumping)
  - Enhanced diagnostics with source info
  - Interactive rename with preview
- **inc-rename.nvim**: Incremental renaming with live preview
- **dressing.nvim**: Better UI for inputs and selections

### Visual Enhancements
- **Theme**: Monokai (Sublime Text style)
- **bufferline.nvim**: Tab-like buffer bar at the top with:
  - File icons and diagnostics indicators
  - Modified file indicators
  - Mouse support for switching/closing buffers
- **lualine.nvim**: Enhanced status line showing:
  - Git branch and diff stats
  - LSP server status
  - Diagnostics (errors/warnings)
  - File info and cursor position
- **indent-blankline.nvim**: Indentation guides for better code readability
- **nvim-web-devicons**: File type icons throughout the UI
- **gitsigns.nvim**: Git integration in the gutter
- **nvim-notify**: Beautiful notification popups
- **noice.nvim**: Enhanced command line and messages

### Navigation and Search
- **Telescope**: Fuzzy finder with:
  - File search (Cmd+P)
  - Live grep (Cmd+Shift+F)
  - Buffer search (Cmd+K)
  - Command palette (Cmd+Shift+P)
  - LSP integration
- **nvim-tree**: File explorer sidebar
- **Auto-completion**: nvim-cmp with LuaSnip snippets
- **Syntax Highlighting**: nvim-treesitter

### Code Quality
- **Formatting**: formatter.nvim (Prettier, Black, Stylua, Rustfmt)
- **Linting**: nvim-lint (Pylint, ESLint, ShellCheck)

## Keybindings

### File Navigation (VS Code style)
**macOS Command Key Shortcuts:**
- `Cmd+P` (`<D-p>`): Find files
- `Cmd+K` (`<D-k>`): Search buffers
- `Cmd+Shift+F` (`<D-f>`): Live grep search in project
- `Cmd+B` (`<D-b>`): Toggle file tree

**Alternative Leader Key Shortcuts:**
- `<leader>ff`: Find files
- `<leader>fb`: Find buffers
- `<leader>fg`: Live grep
- `<leader>fh`: Help tags
- `<leader>fr`: LSP references
- `<leader>fd`: Diagnostics
- `<leader>fs`: Document symbols
- `<C-b>`: Toggle file tree

### LSP (Lspsaga Enhanced)
- `K`: Hover documentation (beautiful floating window)
- `gd`: Peek definition (preview in floating window)
- `gD`: Go to definition (jump to file)
- `gh`: LSP Finder (find references, implementations, etc.)
- `gi`: Go to implementation
- `gt`: Go to type definition
- `<leader>ca`: Code actions (with lightbulb 💡)
- `<leader>rn`: Lspsaga rename (interactive)
- `<leader>rr`: Inc-rename (incremental with live preview)
- `<leader>o`: Symbol outline
- `[e` / `]e`: Navigate diagnostics (all)
- `[E` / `]E`: Navigate errors only
- `<leader>e`: Show diagnostic float
- `<leader>f`: Format document

### Buffer Management (VS Code style)
- `Cmd+W` (`<D-w>`): Close current buffer
- `Cmd+Shift+T` (`<D-S-t>`): New buffer
- `Cmd+]` (`<D-]>`): Next buffer
- `Cmd+[` (`<D-[>`): Previous buffer
- `<leader>bp`: Pin buffer
- `<leader>bP`: Close all non-pinned buffers

### Command Palette
- `Cmd+Shift+P` (`<D-S-p>`): Open command palette (VS Code style)
- `<leader>cp`: Open command palette (alternative)
- `<leader>:`: Search all commands
- `<leader>?`: Search keymaps

### Git Integration
- `]c` / `[c`: Next/previous hunk
- `<leader>gs`: Stage hunk
- `<leader>gr`: Reset hunk
- `<leader>gS`: Stage buffer
- `<leader>gp`: Preview hunk
- `<leader>gb`: Blame line
- `<leader>gtb`: Toggle line blame
- `<leader>gd`: Diff this

### Editing
- `<Tab>` / `<S-Tab>`: Navigate completion menu
- `<CR>`: Confirm completion
- `<C-Space>`: Trigger completion

### Window Navigation
- `<C-h/j/k/l>`: Navigate between splits

## First Time Setup

When you first start Neovim, lazy.nvim will automatically install all plugins. This may take a few minutes.

Then, Mason will install language servers. You can manually install additional servers with:
```vim
:Mason
```

## Installation

The configuration is already set up at `~/.config/nvim/`. To use it:

1. **Install a Nerd Font** (required for icons):
   - Download from: https://www.nerdfonts.com/
   - Recommended: `JetBrainsMono Nerd Font`, `FiraCode Nerd Font`, or `Hack Nerd Font`
   - Configure your terminal to use the Nerd Font

2. **Start Neovim**:
   ```bash
   ~/.local/nvim/bin/nvim
   ```

3. **Wait for plugins to install** (first run only)
   - lazy.nvim will download all plugins
   - Mason will install language servers
   - This takes 2-5 minutes

4. **Restart Neovim** to ensure everything loads properly

5. **Enjoy your VS Code-like Neovim!**

## Terminal Compatibility

For the best experience with Command key (Cmd) shortcuts on macOS:

- **Recommended terminals**:
  - **Kitty**: Best native support for `<D-key>` mappings
  - **WezTerm**: Excellent support with configuration
  - **iTerm2**: Requires keymap configuration

- **Note**: Some terminals may not support all Command key combinations. In those cases, use the `<leader>` key alternatives (Space key).

## Plugin Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         # Editor settings
│   │   └── keymaps.lua         # Keybindings
│   └── plugins/
│       ├── theme.lua           # Monokai theme
│       ├── lsp.lua             # LSP configuration
│       ├── lsp-enhance.lua     # Lspsaga, inc-rename
│       ├── completion.lua      # nvim-cmp
│       ├── telescope.lua       # Fuzzy finder
│       ├── command-palette.lua # Command palette
│       ├── treesitter.lua      # Syntax highlighting
│       ├── ui.lua              # Bufferline, lualine, indent-blankline
│       ├── git.lua             # Gitsigns
│       ├── notifications.lua   # nvim-notify, noice
│       ├── formatting.lua      # Formatter & linter
│       └── typescript.lua      # TypeScript tools
```

## Key Features Explained

### 💡 Code Actions with Lightbulb
When your cursor is on a line with available code actions, you'll see a lightbulb (💡) indicator. Press `<leader>ca` to see and apply fixes.

### 🔍 Peek Definition
Use `gd` to peek at a definition in a floating window without leaving your current file. Use `gD` to jump to the actual file.

### 🔄 Incremental Rename
Use `<leader>rr` to rename a symbol with live preview showing all occurrences being renamed as you type.

### 📋 Buffer Tabs
The top bar shows all your open buffers like tabs in VS Code. Click to switch, or use `Cmd+]` and `Cmd+[` to navigate.

### 🎨 Status Line
The bottom status line shows:
- Current mode
- Git branch and changes
- LSP server status
- Diagnostics (errors/warnings)
- File encoding and type
- Cursor position

## Notes

- All language servers are auto-installed by Mason
- The configuration uses Monokai theme from `tanvirtin/monokai.nvim`
- Formatting requires formatter plugins (prettier, black, stylua, etc.) to be installed via Mason
- LSP diagnostics appear automatically in the gutter, buffer tabs, and status line
- Icons require a Nerd Font installed in your terminal

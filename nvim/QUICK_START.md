# Quick Start Guide - Neovim IDE Setup

## Getting Started

1. **First Run Setup**
   ```bash
   ~/.config/nvim/setup-tools.sh
   ```

2. **Start Neovim**
   ```bash
   nvim
   ```

3. **Let Lazy.nvim install plugins**
   - Neovim will automatically download and install all plugins on first run
   - This may take a few minutes

## Essential Keybinds

### Formatting & Linting
| Key | Action |
|-----|--------|
| `<leader>f` | Format current buffer |
| `<leader>l` | Lint current file |

### Navigation (Intellisense)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Show hover documentation |
| `<C-k>` | Show signature help |

### Code Actions
| Key | Action |
|-----|--------|
| `<leader>ca` | Code actions (refactor, fix, etc.) |
| `<leader>rn` | Rename symbol |

### Completion
| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion menu |
| `<Tab>` | Next completion / expand snippet |
| `<S-Tab>` | Previous completion |
| `<CR>` | Confirm completion |

## Supported Languages

✓ Python
✓ JavaScript / TypeScript / JSX / TSX
✓ Go
✓ Rust
✓ C / C++
✓ Ruby
✓ Lua
✓ Bash / Shell / Zsh
✓ HTML / CSS / SCSS
✓ JSON / YAML / TOML
✓ SQL
✓ Solidity
✓ Zig

## Managing Tools

### View Installed Tools
```vim
:Mason
```

### Install a Language Server
```vim
:MasonInstall <server-name>
```

### Check LSP Status
```vim
:LspInfo
```

### View Formatting Info
```vim
:ConformInfo
```

### Check Linting Diagnostics
```vim
:lua vim.diagnostic.open_float()
```

## Common Tasks

### Format on Save
✓ Already enabled by default (500ms timeout)

### Auto-lint on Save
✓ Already enabled automatically

### Disable Formatting for a File
Add to the file:
```lua
-- conform: noformat
```

### View All Diagnostics
```vim
:lua vim.diagnostic.open_float()
```

### Go to Next Error
```vim
]d
```

### Go to Previous Error
```vim
[d
```

## Troubleshooting

**Formatter not working?**
- Run `:ConformInfo` to check status
- Ensure tool is installed: `:Mason`

**LSP showing wrong diagnostics?**
- Run `:LspInfo` to verify servers are running
- Try `:e` to reload the buffer

**Completion not showing?**
- Press `<C-Space>` to manually trigger
- Check `:LspInfo` that language server is active

**Want to uninstall a tool?**
- Use `:Mason` and press `u` on the tool to uninstall

## Documentation

For detailed configuration documentation:
- Read `LANGUAGE_SUPPORT.md` in this directory
- View configuration files in `lua/plugins/`

## Getting Help

- `:help conform` - Formatting help
- `:help lsp` - LSP help
- `:LspInfo` - Show LSP configuration
- `:Mason` - Tool management interface

# VS Code Features in Neovim

This document maps VS Code features to their Neovim equivalents in this configuration.

## File Navigation

| VS Code | Neovim | Description |
|---------|--------|-------------|
| `Cmd+P` | `Cmd+P` or `<leader>ff` | Quick file finder |
| `Cmd+Shift+F` | `Cmd+Shift+F` or `<leader>fg` | Search in files (live grep) |
| `Cmd+Shift+P` | `Cmd+Shift+P` or `<leader>cp` | Command palette |
| `Cmd+B` | `Cmd+B` or `<C-b>` | Toggle sidebar |
| `Cmd+K Cmd+S` | `<leader>?` | Keyboard shortcuts |
| `Ctrl+Tab` | `Cmd+]` or `<leader>fb` | Switch between buffers |
| `Cmd+W` | `Cmd+W` | Close current file |

## Editor Features

| VS Code | Neovim | Plugin |
|---------|--------|--------|
| Tab bar | Bufferline at top | bufferline.nvim |
| File tree | `<C-b>` or `Cmd+B` | nvim-tree.lua |
| Status bar | Bottom bar | lualine.nvim |
| Minimap | Not implemented | - |
| Breadcrumbs | Symbol outline (`<leader>o`) | lspsaga.nvim |
| Git gutter | Left gutter signs | gitsigns.nvim |
| Notifications | Top-right popups | nvim-notify |

## LSP Features

| VS Code | Neovim | Plugin |
|---------|--------|--------|
| Go to Definition | `gd` (peek) or `gD` (jump) | lspsaga.nvim |
| Find References | `gh` or `gr` | lspsaga.nvim |
| Hover | `K` | lspsaga.nvim |
| Code Actions 💡 | `<leader>ca` | lspsaga.nvim |
| Rename Symbol | `<leader>rn` or `<leader>rr` | lspsaga + inc-rename |
| Format Document | `<leader>f` | formatter.nvim |
| Problems Panel | `<leader>fd` | Telescope diagnostics |
| Outline | `<leader>o` | lspsaga.nvim |
| Auto-completion | Automatic | nvim-cmp |
| Signature Help | `<C-k>` | lspsaga.nvim |

## Git Integration

| VS Code | Neovim | Plugin |
|---------|--------|--------|
| Gutter indicators | Automatic | gitsigns.nvim |
| View changes | `<leader>gp` | gitsigns.nvim |
| Stage hunk | `<leader>gs` | gitsigns.nvim |
| Git blame | `<leader>gb` | gitsigns.nvim |
| Diff view | `<leader>gd` | gitsigns.nvim |

## Editing Features

| VS Code | Neovim | Description |
|---------|--------|-------------|
| IntelliSense | nvim-cmp | Auto-completion with LSP |
| Snippets | LuaSnip | Code snippets |
| Multiple cursors | Not implemented | Use macros/substitute |
| Find & Replace | `:%s/old/new/g` | Vim native |
| Auto-format on save | Can be configured | formatter.nvim |
| Indent guides | Automatic | indent-blankline.nvim |

## Visual Features

| Feature | Implementation | Plugin |
|---------|----------------|--------|
| Color theme | Monokai | monokai.nvim |
| File icons | Nerd Font icons | nvim-web-devicons |
| Tab bar | Buffer tabs at top | bufferline.nvim |
| Status line | Enhanced bottom bar | lualine.nvim |
| Command palette | Fuzzy searchable | telescope-command-palette |
| Notifications | Beautiful popups | nvim-notify + noice.nvim |
| Floating windows | LSP hover, diagnostics | lspsaga.nvim |

## Missing Features (Limitations)

Some VS Code features are not available or have different implementations:

1. **Native GUI**: Neovim is terminal-based (use terminal with good font support)
2. **Extensions Marketplace**: Use lazy.nvim for plugins
3. **Integrated Terminal**: Use tmux or terminal splits
4. **Multiple Cursors**: Use macros, visual block mode, or substitute
5. **Settings UI**: Edit `~/.config/nvim/lua/config/options.lua`
6. **Welcome Screen**: Not implemented (add alpha-nvim if desired)

## Advantages Over VS Code

1. **Performance**: Much faster, especially for large files
2. **Modal editing**: Powerful Vim motions
3. **Customization**: Full Lua scripting
4. **Terminal integration**: Native terminal application
5. **Memory usage**: Significantly lower RAM consumption
6. **Keyboard-centric**: Less mouse dependency
7. **Remote editing**: Better SSH/remote development

## Next Steps

1. Learn Vim motions: `vimtutor` in terminal
2. Customize keybindings in `lua/config/keymaps.lua`
3. Add language servers via `:Mason`
4. Explore plugins in `:Lazy`
5. Read `:help` for Neovim documentation

## Resources

- Neovim docs: `:help`
- This config: `~/.config/nvim/README.md`
- Lazy.nvim: `:Lazy`
- Mason (LSP): `:Mason`
- Telescope commands: `<leader>:`
- Key mappings: `<leader>?`

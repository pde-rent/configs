# Development Environment Configs

Portable config files and setup script for macOS and Debian/Ubuntu.

## Quick Start

```bash
git clone https://github.com/pde-rent/configs ~/configs
cd ~/configs && ./scripts/setup.sh
```

## What's Installed

| Category | Tools |
|----------|-------|
| Shell | Zsh, Oh-My-Zsh (bureau theme), tmux |
| Editor | Neovim, Alacritty, VSCode settings |
| Languages | Rust, Go, Zig, Lua, Ruby (rbenv), Python (uv), Java (SDKMAN) |
| JS Runtime | Bun (replaces Node/npm/npx) |
| Blockchain | Foundry (Solidity) |
| Containers | Docker |
| Utilities | musikcube, rtorrent, 7zip, ffmpeg |

## Structure

```
~/configs/
├── alacritty/       # Terminal config
├── nvim/            # Neovim config (VSCode-like)
├── tmux/            # Tmux config (Monokai Pro theme)
├── vscode/          # VSCode settings.json
├── jetbrains/       # JetBrains theme
├── fonts/           # JetBrains Mono, Nerd Symbols, Inter, Mozilla
├── scripts/
│   └── setup.sh     # Main installer
├── .zshrc           # Shell config
└── space-wp.jpg     # Wallpaper
```

## Key Aliases

```bash
# Bun replaces Node
node/npm/npx → bun/bun/bunx

# Python via uv
python/pip → uv run python / uv pip

# Editor
vi/vim → nvim

# Modern CLI
ls → eza    cat → bat    cd → z (zoxide)
```

## Font Patching

The setup patches JetBrains Mono with Nerd Font icons (requires Docker or FontForge):

```bash
./scripts/setup.sh              # Full setup + patching
./scripts/setup.sh --no-patch   # Skip patching
./scripts/setup.sh --patch-fonts # Patch fonts only
```

## Keybindings

### Terminal (Alacritty)
| Key | Action |
|-----|--------|
| `Cmd+T` | New window |
| `Cmd+N` | New window |
| `Cmd+W` | Close window |
| `Cmd+C/V/X` | Copy/Paste/Cut (terminal) |

### Neovim
| Key | Action |
|-----|--------|
| `Cmd+P` | Find files |
| `Cmd+Shift+F` | Global search |
| `Cmd+B` | Toggle file tree |
| `Cmd+Z/Shift+Z` | Undo/Redo |
| `Cmd+C/V/X` | Copy/Paste/Cut |
| `Ctrl+Shift+W` | Close buffer |
| `Ctrl+Shift+T` | New buffer |
| `Ctrl+Shift+N` | New file |
| `F12` | Go to definition |
| `Shift+F12` | References |
| `Opt+Left/Right` | Word navigation |
| `Del/Backspace` (visual) | Delete selection |
| `Esc` (visual) | Cancel selection |

## Supported Platforms

- macOS (Intel & Apple Silicon)
- Ubuntu / Debian
- WSL2

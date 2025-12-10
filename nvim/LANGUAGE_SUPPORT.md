# Neovim Language Support Configuration

This document outlines the comprehensive language support configured for your Neovim setup.

## Supported Languages

### Web Development
- **JavaScript** - Prettier (format), ESLint (lint)
- **TypeScript** - Prettier (format), ESLint (lint)
- **JSX/TSX** - Prettier (format), ESLint (lint)
- **HTML** - Prettier (format), HTMLHint (lint)
- **CSS** - Prettier (format), Stylelint (lint)
- **SCSS** - Prettier (format), Stylelint (lint)
- **JSON/JSONC** - Prettier (format), JSONLint (lint)
- **YAML** - Prettier (format), YAMLLint (lint)

### Programming Languages
- **Python** - Ruff (format + organize imports), Pylint (lint)
- **Go** - Gofmt (format), Golangci-lint (lint), GoLSP (intellisense)
- **Rust** - Rustfmt (format), Rust Analyzer (intellisense)
- **C/C++** - Clang-format (format), Clang-tidy (lint)
- **Zig** - Zigfmt (format)
- **Ruby** - Rubocop (format + lint)
- **Lua** - Stylua (format), Luacheck (lint)

### Database & Query Languages
- **SQL** - sql-formatter (format), sqlfluff (lint)
- **PQT** - Prettier (format)
- **CSV** - Prettier (format)

### Blockchain
- **Solidity** - Prettier (format), Solhint (lint)

### Markup & Config
- **Markdown** - Prettier (format)
- **TOML** - Taplo (format + lint)

### Shells & Scripting
- **Bash** - Shfmt (format), Shellcheck (lint)
- **Sh** - Shfmt (format), Shellcheck (lint)
- **Zsh** - Shfmt (format), Shellcheck (lint)

### Shader Languages
- **GLSL** - Clang-format (format)

## Features by Language

### Formatting
Use `<leader>f` to format code. All configured languages support formatting with appropriate formatters listed above.

### Linting
Use `<leader>l` to lint code. Linting runs automatically on save and on text change.

### Syntax Highlighting
All languages above have Tree-sitter parsers installed for accurate syntax highlighting.

### Intellisense/Completion
Supported via LSP with these servers:
- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `pyright` - Python
- `gopls` - Go
- `rust_analyzer` - Rust
- `zls` - Zig
- `clangd` - C/C++
- `bashls` - Bash/Shell
- `html` - HTML
- `cssls` - CSS
- `scss_ls` - SCSS
- `jsonls` - JSON
- `sqlls` - SQL
- `taplo` - TOML
- `ruby_lsp` - Ruby
- `solidity_ls` - Solidity

## Navigation & IDE Features
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Go to references
- `gt` - Go to type definition
- `K` - Hover documentation
- `<C-k>` - Signature help
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

## Completion Features
- `<C-Space>` - Trigger completion
- `<Tab>` - Select next item / expand snippet
- `<S-Tab>` - Select previous item
- `<CR>` - Confirm selection
- `<C-b>` / `<C-f>` - Scroll documentation

## Installation

Run the setup script to install all tools:

```bash
~/.config/nvim/setup-tools.sh
```

## Manual Tool Installation

If you prefer to install tools manually:

### Formatters (Homebrew)
```bash
brew install prettier stylua black rustfmt shfmt clang-format taplo rubocop
npm install -g sql-formatter
```

### Linters (Homebrew)
```bash
brew install eslint pylint shellcheck yamllint sqlfluff golangci-lint luacheck
npm install -g htmlhint stylelint solhint
```

### Language Servers (via Mason inside Neovim)
```vim
:Mason
" Then install: lua_ls ts_ls pyright gopls rust_analyzer zls clangd bashls
" html cssls scss_ls jsonls sqlls taplo glslls ruby_lsp solidity_ls
```

## Configuration Files

- `lua/plugins/formatting.lua` - Conform.nvim & nvim-lint setup
- `lua/plugins/lsp.lua` - LSP configuration with Mason integration
- `lua/plugins/treesitter.lua` - Syntax highlighting setup
- `lua/plugins/completion.lua` - Completion engine (nvim-cmp)

## Troubleshooting

### Formatter not working
1. Check if the tool is installed: `:MasonCheck` in Neovim
2. Run `:ConformInfo` to see format status
3. Use `:help conform` for more details

### LSP not working
1. Check status: `:LspInfo`
2. Install missing servers: `:MasonInstall <server-name>`
3. Check logs: `:LspLog`

### Linting not working
1. Check configured linters: `:lua require('lint').linters_by_ft`
2. Run manually: `<leader>l`
3. View diagnostics: `:lua vim.diagnostic.open_float()`

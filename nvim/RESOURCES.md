# Neovim Setup - Resources & References

## Official Documentation

### Neovim Core
- [Neovim LSP Documentation](https://neovim.io/doc/user/lsp.html)
- [Neovim Tree-sitter Documentation](https://neovim.io/doc/user/treesitter.html)
- [Neovim Official Website](https://neovim.io/)

### Plugin Documentation
- [Conform.nvim - Modern Formatter Plugin](https://github.com/stevearc/conform.nvim)
- [nvim-lspconfig - Official LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Tree-sitter - Syntax Highlighting](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-cmp - Completion Engine](https://github.com/hrsh7th/nvim-cmp)
- [nvim-lint - Linting Framework](https://github.com/mfussenegger/nvim-lint)

### Package Managers
- [Mason.nvim - Tool Manager](https://github.com/williamboman/mason.nvim)
- [lazy.nvim - Plugin Manager](https://github.com/folke/lazy.nvim)

## Setup Guides & References

### General Setup
- [Minimalistic Modern LSP Setup in Neovim with lazy.nvim](https://www.jakmaz.com/blog/nvim-lsp)
- [A Comprehensive Guide to Neovim's LSP Client](https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/)
- [Neovim Config for 2025](https://rdrn.me/neovim-2025/)

### Language-Specific Guides
- [TypeScript and Neovim LSP 2024](https://blog.ffff.lt/posts/typescript-and-neovim-lsp-2024/)
- [Setting up LSPs for Modern JavaScript Tooling in Neovim](https://nathan-long.com/blog/modern-javascript-tooling-in-neovim/)
- [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)

### Formatting & Linting
- [Automagically formatting on save with Neovim and LSP](https://www.jvt.me/posts/2022/03/01/neovim-format-on-save/)
- [Ruff Editor Setup](https://docs.astral.sh/ruff/editors/setup/)

### Code Completion
- [Code Completion for Neovim using Lazy](https://medium.com/@shaikzahid0713/code-completion-for-neovim-6127401ebec2)
- [Autocomplete in neovim with built-in LSP client](https://coffeeandcontemplation.dev/2021/01/14/autocomplete-in-neovim/)

### Advanced Topics
- [Neovim Spaghetti - LSP, Linters, Formatters, and Treesitter](https://roobert.github.io/2022/12/03/Extending-Neovim/)
- [Syntax Highlighting with Tree-sitter](https://slar.se/syntax-highlight-anything-with-tree-sitter/)

## Tools & Language Servers

### Formatters
- [Prettier](https://prettier.io/) - Web development
- [Ruff](https://docs.astral.sh/ruff/) - Python
- [Rustfmt](https://rust-lang.github.io/rustfmt/) - Rust
- [Clang-format](https://clang.llvm.org/docs/ClangFormat/) - C/C++
- [Stylua](https://github.com/JohnnyMorganz/StyLua) - Lua
- [Taplo](https://taplo.tamasfe.dev/) - TOML
- [Rubocop](https://rubocop.org/) - Ruby
- [Shfmt](https://github.com/mvdan/sh) - Shell

### Language Servers
- [pyright](https://github.com/microsoft/pyright) - Python
- [ts_ls](https://github.com/typescript-language-server/typescript-language-server) - TypeScript/JavaScript
- [gopls](https://github.com/golang/tools/tree/master/gopls) - Go
- [rust-analyzer](https://rust-analyzer.github.io/) - Rust
- [clangd](https://clangd.llvm.org/) - C/C++
- [lua_ls](https://github.com/LuaLS/lua-language-server) - Lua
- [ruby-lsp](https://github.com/Shopify/ruby-lsp) - Ruby
- [solidity-ls](https://github.com/NomicFoundation/hardhat-vscode) - Solidity

### Linters
- [ESLint](https://eslint.org/) - JavaScript/TypeScript
- [Pylint](https://www.pylint.org/) - Python
- [Shellcheck](https://www.shellcheck.net/) - Shell
- [Clippy](https://doc.rust-lang.org/clippy/) - Rust (built-in)
- [Clang-tidy](https://clang.llvm.org/extra/clang-tidy/) - C/C++
- [Golangci-lint](https://golangci-lint.run/) - Go
- [Luacheck](https://github.com/mpeterv/luacheck) - Lua
- [Solhint](https://www.solhint.org/) - Solidity

## Community Resources

### Neovim Communities
- [r/neovim](https://reddit.com/r/neovim/) - Subreddit
- [Neovim Discord](https://discord.gg/onivim) - Community chat
- [GitHub Discussions](https://github.com/neovim/neovim/discussions) - Official discussions

### Learning Resources
- [Neovim from scratch](https://github.com/nvim-lua/kickstart.nvim) - Minimal config template
- [NvChad](https://nvchad.com/) - Preconfigured setup
- [LazyVim](https://www.lazyvim.org/) - Opinionated setup

### Tips & Tricks
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) - Curated list of plugins
- [Neovim Plugin Roundups](https://www.reddit.com/r/neovim/search?q=plugin+roundup&sort=new) - Community recommendations

## Configuration Snippets Used

### Key Technologies in This Setup

1. **Conform.nvim** - Modern formatting engine with LSP fallback
2. **nvim-lint** - Asynchronous linting framework
3. **nvim-cmp** - Fast, extensible completion engine
4. **Tree-sitter** - Incremental parsing for accurate syntax highlighting
5. **Mason** - Cross-platform package manager for LSP servers and tools
6. **lazy.nvim** - Fast and minimal plugin manager

### Modern Neovim Standards (2025)
- Uses `vim.lsp.config()` instead of deprecated `require('lspconfig')`
- Leverages built-in completion engine (`vim.lsp.completion`)
- Format-on-save with LSP fallback
- Auto-linting with diagnostic display
- Text objects with Tree-sitter

## Getting Help

### In Neovim
```vim
:help lsp              " LSP documentation
:help conform         " Formatting documentation
:help cmp             " Completion documentation
:LspInfo              " Show LSP status
:ConformInfo          " Show formatter status
:Mason                " Tool management
:Lazy                 " Plugin management
```

### Online
- Search GitHub issues for your problem
- Ask on r/neovim with detailed error messages
- Check nvim-lspconfig server-specific docs
- Consult tool documentation (Ruff, Prettier, etc.)

## Keeping Up to Date

### Regular Updates
```bash
# Update plugins
nvim +Lazy sync

# Update Mason packages
# Inside Neovim: :MasonUpdate

# Update Neovim itself
brew upgrade neovim
```

### Staying Informed
- Follow [Neovim releases](https://github.com/neovim/neovim/releases)
- Subscribe to LSP-focused blogs
- Check [ThePrimeagen](https://github.com/ThePrimeagen) for config ideas
- Monitor plugin repositories for updates

## Notes on This Configuration

### Why These Tools?
- **Conform**: Most actively maintained formatter plugin (successor to null-ls)
- **nvim-lint**: Lightweight, focused on asynchronous linting
- **nvim-cmp**: Most mature and extensible completion solution
- **Mason**: Simplifies tool installation across platforms
- **lazy.nvim**: Modern plugin management with performance optimizations

### Performance Considerations
- All plugins use lazy-loading
- Formatters run asynchronously
- Linting debounced to avoid excessive runs
- Completion only triggers on demand
- Tree-sitter incremental parsing

### Future Improvements
- Consider adding debugging support (nvim-dap)
- Test integration improvements
- Git integration enhancements (already configured)
- Custom snippet library expansion

---

**Last Updated**: December 2025
**Configuration Version**: 2.0 (Solidity, Go, Lua, Ruby added)
**Neovim Version**: 0.11.5+

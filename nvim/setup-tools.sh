#!/bin/bash

# Comprehensive setup script for Neovim formatters and language servers
# This script installs all tools needed for the complete Neovim IDE setup

set -e

echo "🔧 Installing Neovim development tools and language servers..."

# Detect package manager
if command -v brew &> /dev/null; then
    PM="brew"
    echo "📦 Using Homebrew"
elif command -v apt-get &> /dev/null; then
    PM="apt"
    echo "📦 Using apt"
else
    echo "❌ Neither Homebrew nor apt found. Please install Homebrew or use your system's package manager."
    exit 1
fi

# Function to install with appropriate package manager
install_tool() {
    local tool=$1
    local brew_name=${2:-$tool}
    local apt_name=${3:-$tool}

    if command -v "$tool" &> /dev/null; then
        echo "✓ $tool already installed"
        return 0
    fi

    echo "Installing $tool..."
    if [ "$PM" = "brew" ]; then
        brew install "$brew_name" || echo "⚠️  Failed to install $tool via brew"
    else
        sudo apt-get install -y "$apt_name" || echo "⚠️  Failed to install $tool via apt"
    fi
}

# Install formatters
echo ""
echo "📝 Installing Formatters..."
install_tool "prettier" "prettier" "node-prettier"
install_tool "stylua" "stylua" "stylua"
install_tool "black" "black" "black"
install_tool "rustfmt" "rustfmt" "rustfmt"
install_tool "shfmt" "shfmt" "shfmt"
install_tool "clang-format" "clang-format" "clang-format"
install_tool "taplo" "taplo" "taplo"
install_tool "rubocop" "rubocop" "rubocop"

# SQL formatter (may need npm)
if ! command -v sql-formatter &> /dev/null; then
    echo "Installing sql-formatter via npm..."
    npm install -g sql-formatter || echo "⚠️  Failed to install sql-formatter"
else
    echo "✓ sql-formatter already installed"
fi

# Install linters
echo ""
echo "🔍 Installing Linters..."
install_tool "eslint" "eslint" "eslint"
install_tool "pylint" "pylint" "pylint"
install_tool "shellcheck" "shellcheck" "shellcheck"
install_tool "yamllint" "yamllint" "yamllint"
install_tool "sqlfluff" "sqlfluff" "sqlfluff"
install_tool "golangci-lint" "golangci-lint" "golangci-lint"
install_tool "luacheck" "luacheck" "luacheck"

# HTML/CSS linters (may need npm)
if ! command -v htmlhint &> /dev/null; then
    echo "Installing htmlhint via npm..."
    npm install -g htmlhint || echo "⚠️  Failed to install htmlhint"
else
    echo "✓ htmlhint already installed"
fi

if ! command -v stylelint &> /dev/null; then
    echo "Installing stylelint via npm..."
    npm install -g stylelint || echo "⚠️  Failed to install stylelint"
else
    echo "✓ stylelint already installed"
fi

# Solidity linter (may need npm)
if ! command -v solhint &> /dev/null; then
    echo "Installing solhint via npm..."
    npm install -g solhint || echo "⚠️  Failed to install solhint"
else
    echo "✓ solhint already installed"
fi

# Install language servers via Mason (in Neovim)
echo ""
echo "📚 Installing Language Servers (via Mason)..."
echo "Opening Neovim to install language servers..."

/Users/derpa/.local/nvim/bin/nvim --headless -c 'MasonInstall lua_ls ts_ls pyright gopls rust_analyzer zls clangd bashls html cssls scss_ls jsonls sqlls taplo glslls ruby_lsp solidity_ls' -c 'qa!'

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Summary of installed tools:"
echo "   Formatters: prettier, stylua, black, rustfmt, shfmt, clang-format, taplo, rubocop, sql-formatter"
echo "   Linters: eslint, pylint, shellcheck, yamllint, sqlfluff, htmlhint, stylelint, golangci-lint, luacheck, solhint"
echo "   Language Servers: lua_ls, ts_ls, pyright, gopls, rust_analyzer, zls, clangd, bashls, html, cssls, scss_ls, jsonls, sqlls, taplo, glslls, ruby_lsp, solidity_ls"
echo ""
echo "🚀 Next steps:"
echo "   1. Start Neovim: nvim"
echo "   2. Run :Mason to manage tools"
echo "   3. Use <leader>f to format code"
echo "   4. Use <leader>l to lint code"
echo "   5. Use gd, gi, K for IDE features"

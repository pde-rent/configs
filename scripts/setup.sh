#!/usr/bin/env bash
#
# Universal Development Environment Setup Script
# Supports: macOS (Intel/Apple Silicon) and Debian-based Linux (Ubuntu, etc.)
#
# Usage: curl -fsSL https://raw.githubusercontent.com/pde-rent/configs/main/scripts/setup.sh | bash
#    or: ./setup.sh
#
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect OS and architecture
detect_os() {
    case "$(uname -s)" in
        Darwin*)    OS="macos" ;;
        Linux*)     OS="linux" ;;
        *)          OS="unknown" ;;
    esac

    case "$(uname -m)" in
        x86_64)     ARCH="amd64" ;;
        arm64)      ARCH="arm64" ;;
        aarch64)    ARCH="arm64" ;;
        *)          ARCH="unknown" ;;
    esac

    log_info "Detected OS: $OS, Architecture: $ARCH"
}

# Package manager wrapper
pkg_install() {
    if [[ "$OS" == "macos" ]]; then
        brew install "$@"
    else
        sudo apt-get install -y "$@"
    fi
}

pkg_update() {
    if [[ "$OS" == "macos" ]]; then
        brew update
    else
        sudo apt-get update
    fi
}

# =============================================================================
# macOS Setup
# =============================================================================
setup_macos() {
    log_info "Setting up macOS environment..."

    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for Apple Silicon
        if [[ "$ARCH" == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi

    brew update
    brew upgrade

    # Core tools
    log_info "Installing core tools..."
    brew install \
        git \
        curl \
        wget \
        jq \
        tree \
        htop \
        ripgrep \
        fd \
        fzf \
        bat \
        eza \
        zoxide \
        tmux \
        neovim \
        alacritty \
        7zip \
        p7zip

    # Development languages and tools
    log_info "Installing development tools..."

    # Rust (via rustup)
    if ! command -v rustc &> /dev/null; then
        log_info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi

    # Go
    brew install go

    # Zig
    brew install zig

    # Lua
    brew install lua luarocks

    # Ruby (latest via rbenv)
    brew install rbenv ruby-build
    rbenv install -s $(rbenv install -l | grep -v - | tail -1) || true
    rbenv global $(rbenv install -l | grep -v - | tail -1) || true

    # Bun (Node.js replacement)
    if ! command -v bun &> /dev/null; then
        log_info "Installing Bun..."
        curl -fsSL https://bun.sh/install | bash
    fi

    # Python via uv
    if ! command -v uv &> /dev/null; then
        log_info "Installing uv (Python manager)..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi

    # SDKMAN for JDK
    if [[ ! -d "$HOME/.sdkman" ]]; then
        log_info "Installing SDKMAN..."
        curl -s "https://get.sdkman.io" | bash
    fi

    # Foundry (Solidity)
    if ! command -v forge &> /dev/null; then
        log_info "Installing Foundry (Solidity)..."
        curl -L https://foundry.paradigm.xyz | bash
        ~/.foundry/bin/foundryup
    fi

    # Docker
    if ! command -v docker &> /dev/null; then
        log_info "Installing Docker..."
        brew install --cask docker
    fi

    # Media and utilities
    log_info "Installing media tools..."
    brew install \
        musikcube \
        rtorrent \
        ffmpeg

    log_success "macOS setup complete!"
}

# =============================================================================
# Linux (Debian/Ubuntu) Setup
# =============================================================================
setup_linux() {
    log_info "Setting up Linux (Debian-based) environment..."

    # Update system
    sudo apt-get update
    sudo apt-get upgrade -y

    # Core dependencies
    log_info "Installing core dependencies..."
    sudo apt-get install -y \
        build-essential \
        curl \
        wget \
        git \
        jq \
        tree \
        htop \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        unzip \
        zip \
        p7zip-full \
        p7zip-rar \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev \
        libyaml-dev \
        libffi-dev \
        libgdbm-dev \
        libncurses5-dev \
        libsqlite3-dev \
        libbz2-dev \
        liblzma-dev \
        tk-dev

    # Modern CLI tools
    log_info "Installing modern CLI tools..."
    sudo apt-get install -y ripgrep fd-find fzf bat

    # Create symlinks for fd and bat (Ubuntu uses different names)
    sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd 2>/dev/null || true
    sudo ln -sf /usr/bin/batcat /usr/local/bin/bat 2>/dev/null || true

    # eza (modern ls replacement)
    if ! command -v eza &> /dev/null; then
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo apt-get update
        sudo apt-get install -y eza
    fi

    # zoxide
    if ! command -v zoxide &> /dev/null; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi

    # Neovim (latest from GitHub releases)
    log_info "Installing Neovim..."
    NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name')
    if [[ "$ARCH" == "arm64" ]]; then
        curl -LO "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-arm64.tar.gz"
        sudo tar -C /usr/local -xzf nvim-linux-arm64.tar.gz
        rm nvim-linux-arm64.tar.gz
    else
        curl -LO "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
        sudo tar -C /usr/local -xzf nvim-linux-x86_64.tar.gz
        rm nvim-linux-x86_64.tar.gz
    fi
    sudo ln -sf /usr/local/nvim-linux-*/bin/nvim /usr/local/bin/nvim

    # Alacritty
    log_info "Installing Alacritty..."
    sudo add-apt-repository -y ppa:aslatter/ppa 2>/dev/null || true
    sudo apt-get update
    sudo apt-get install -y alacritty || log_warn "Alacritty PPA not available, will build from source if needed"

    # tmux
    sudo apt-get install -y tmux

    # Rust
    if ! command -v rustc &> /dev/null; then
        log_info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi

    # Go
    log_info "Installing Go..."
    GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -1)
    if [[ "$ARCH" == "arm64" ]]; then
        curl -LO "https://go.dev/dl/${GO_VERSION}.linux-arm64.tar.gz"
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-arm64.tar.gz"
        rm "${GO_VERSION}.linux-arm64.tar.gz"
    else
        curl -LO "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-amd64.tar.gz"
        rm "${GO_VERSION}.linux-amd64.tar.gz"
    fi

    # Zig
    log_info "Installing Zig..."
    ZIG_VERSION=$(curl -s https://ziglang.org/download/index.json | jq -r '.master.version')
    if [[ "$ARCH" == "arm64" ]]; then
        curl -LO "https://ziglang.org/builds/zig-linux-aarch64-${ZIG_VERSION}.tar.xz"
        sudo tar -C /usr/local -xf "zig-linux-aarch64-${ZIG_VERSION}.tar.xz"
        sudo ln -sf "/usr/local/zig-linux-aarch64-${ZIG_VERSION}/zig" /usr/local/bin/zig
        rm "zig-linux-aarch64-${ZIG_VERSION}.tar.xz"
    else
        curl -LO "https://ziglang.org/builds/zig-linux-x86_64-${ZIG_VERSION}.tar.xz"
        sudo tar -C /usr/local -xf "zig-linux-x86_64-${ZIG_VERSION}.tar.xz"
        sudo ln -sf "/usr/local/zig-linux-x86_64-${ZIG_VERSION}/zig" /usr/local/bin/zig
        rm "zig-linux-x86_64-${ZIG_VERSION}.tar.xz"
    fi

    # Lua
    sudo apt-get install -y lua5.4 luarocks

    # Ruby (via rbenv)
    log_info "Installing Ruby..."
    if [[ ! -d "$HOME/.rbenv" ]]; then
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    fi
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    RUBY_VERSION=$(rbenv install -l 2>/dev/null | grep -v - | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+\s*$' | tail -1 | tr -d ' ')
    rbenv install -s "$RUBY_VERSION" || true
    rbenv global "$RUBY_VERSION" || true

    # Bun
    if ! command -v bun &> /dev/null; then
        log_info "Installing Bun..."
        curl -fsSL https://bun.sh/install | bash
    fi

    # Python via uv
    if ! command -v uv &> /dev/null; then
        log_info "Installing uv (Python manager)..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi

    # SDKMAN for JDK
    if [[ ! -d "$HOME/.sdkman" ]]; then
        log_info "Installing SDKMAN..."
        curl -s "https://get.sdkman.io" | bash
    fi

    # Foundry (Solidity)
    if ! command -v forge &> /dev/null; then
        log_info "Installing Foundry (Solidity)..."
        curl -L https://foundry.paradigm.xyz | bash
        ~/.foundry/bin/foundryup
    fi

    # Docker
    if ! command -v docker &> /dev/null; then
        log_info "Installing Docker..."
        curl -fsSL https://get.docker.com | sh
        sudo usermod -aG docker "$USER"
    fi

    # Media tools
    log_info "Installing media tools..."

    # musikcube
    MUSIKCUBE_VERSION=$(curl -s https://api.github.com/repos/clangen/musikcube/releases/latest | jq -r '.tag_name')
    if [[ "$ARCH" == "arm64" ]]; then
        curl -LO "https://github.com/clangen/musikcube/releases/download/${MUSIKCUBE_VERSION}/musikcube_${MUSIKCUBE_VERSION}_arm64.deb" 2>/dev/null || \
        curl -LO "https://github.com/clangen/musikcube/releases/download/${MUSIKCUBE_VERSION}/musikcube_arm64.deb" 2>/dev/null || \
        log_warn "musikcube arm64 package not found"
        sudo dpkg -i musikcube*.deb 2>/dev/null || true
        rm -f musikcube*.deb
    else
        curl -LO "https://github.com/clangen/musikcube/releases/download/${MUSIKCUBE_VERSION}/musikcube_${MUSIKCUBE_VERSION}_amd64.deb" 2>/dev/null || \
        curl -LO "https://github.com/clangen/musikcube/releases/download/${MUSIKCUBE_VERSION}/musikcube_amd64.deb" 2>/dev/null || \
        log_warn "musikcube package not found"
        sudo dpkg -i musikcube*.deb 2>/dev/null || sudo apt-get install -f -y
        rm -f musikcube*.deb
    fi

    # rtorrent
    sudo apt-get install -y rtorrent

    # ffmpeg
    sudo apt-get install -y ffmpeg

    log_success "Linux setup complete!"
}

# =============================================================================
# ZSH and Oh-My-Zsh Setup
# =============================================================================
setup_zsh() {
    log_info "Setting up ZSH and Oh-My-Zsh..."

    # Install ZSH
    if [[ "$OS" == "macos" ]]; then
        brew install zsh
    else
        sudo apt-get install -y zsh
    fi

    # Install Oh-My-Zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Set ZSH as default shell
    if [[ "$SHELL" != *"zsh"* ]]; then
        chsh -s "$(which zsh)" || sudo chsh -s "$(which zsh)" "$USER"
    fi

    log_success "ZSH setup complete!"
}

# =============================================================================
# Install SDKMAN and Eclipse Temurin JDK
# =============================================================================
setup_java() {
    log_info "Setting up Java via SDKMAN..."

    # Source SDKMAN
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

    if command -v sdk &> /dev/null; then
        # Install latest LTS Eclipse Temurin
        TEMURIN_VERSION=$(sdk list java 2>/dev/null | grep -o 'tem$' | head -1 || echo "")
        if [[ -z "$TEMURIN_VERSION" ]]; then
            # Get latest Temurin LTS version
            sdk install java $(sdk list java | grep -E '^\s*\|\s+[0-9]+\.' | grep 'tem' | head -1 | awk '{print $NF}') || \
            sdk install java 21-tem || \
            log_warn "Could not install Temurin JDK automatically"
        fi
    else
        log_warn "SDKMAN not available, skipping Java setup"
    fi

    log_success "Java setup complete!"
}

# =============================================================================
# Install Fonts
# =============================================================================
setup_fonts() {
    log_info "Installing fonts..."

    FONTS_DIR="$HOME/configs/fonts"

    # Destination directory
    if [[ "$OS" == "macos" ]]; then
        FONT_DEST="$HOME/Library/Fonts"
    else
        FONT_DEST="$HOME/.local/share/fonts"
        mkdir -p "$FONT_DEST"
    fi

    # Copy fonts from repo if available
    if [[ -d "$FONTS_DIR" ]]; then
        log_info "Installing fonts from configs repo..."
        cp "$FONTS_DIR"/*.ttf "$FONT_DEST/" 2>/dev/null || true

        # Install fontconfig for Nerd Font symbols fallback (Linux only)
        if [[ "$OS" == "linux" && -f "$FONTS_DIR/10-nerd-font-symbols.conf" ]]; then
            sudo mkdir -p /etc/fonts/conf.d
            sudo cp "$FONTS_DIR/10-nerd-font-symbols.conf" /etc/fonts/conf.d/
        fi
    else
        # Download fonts if not in repo
        log_info "Downloading fonts..."
        mkdir -p "$FONTS_DIR"

        # JetBrains Mono Variable
        curl -fLo "$FONTS_DIR/JetBrainsMono[wght].ttf" \
            "https://github.com/JetBrains/JetBrainsMono/raw/master/fonts/variable/JetBrainsMono%5Bwght%5D.ttf"
        curl -fLo "$FONTS_DIR/JetBrainsMono-Italic[wght].ttf" \
            "https://github.com/JetBrains/JetBrainsMono/raw/master/fonts/variable/JetBrainsMono-Italic%5Bwght%5D.ttf"

        # Inter Variable
        curl -fLo "$FONTS_DIR/InterVariable.ttf" \
            "https://github.com/rsms/inter/raw/master/docs/font-files/InterVariable.ttf"

        # Nerd Font Symbols
        curl -fLo "$FONTS_DIR/NerdFontsSymbolsOnly.zip" \
            "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip"
        unzip -o "$FONTS_DIR/NerdFontsSymbolsOnly.zip" -d "$FONTS_DIR" -x "*.md" "*.txt" "LICENSE"
        rm "$FONTS_DIR/NerdFontsSymbolsOnly.zip"

        cp "$FONTS_DIR"/*.ttf "$FONT_DEST/" 2>/dev/null || true
    fi

    # Refresh font cache on Linux
    if [[ "$OS" == "linux" ]]; then
        fc-cache -fv
    fi

    log_success "Fonts installed!"
}

# =============================================================================
# Patch Fonts with Nerd Font Symbols
# =============================================================================
patch_fonts() {
    log_info "Patching JetBrains Mono with Nerd Font symbols..."

    FONTS_DIR="$HOME/configs/fonts"
    PATCHED_DIR="$FONTS_DIR/patched"
    mkdir -p "$PATCHED_DIR"

    # Destination directory
    if [[ "$OS" == "macos" ]]; then
        FONT_DEST="$HOME/Library/Fonts"
    else
        FONT_DEST="$HOME/.local/share/fonts"
    fi

    # Check if already patched
    if [[ -f "$PATCHED_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
        log_info "Patched fonts already exist, copying to destination..."
        cp "$PATCHED_DIR"/*.ttf "$FONT_DEST/" 2>/dev/null || true
        if [[ "$OS" == "linux" ]]; then
            fc-cache -fv
        fi
        log_success "Patched fonts installed!"
        return
    fi

    # Check if Docker is available (preferred method)
    if command -v docker &> /dev/null; then
        log_info "Using Docker to patch fonts..."

        # Patch regular weight
        if [[ -f "$FONTS_DIR/JetBrainsMono[wght].ttf" ]]; then
            docker run --rm \
                -v "$FONTS_DIR:/in:Z" \
                -v "$PATCHED_DIR:/out:Z" \
                nerdfonts/patcher \
                --complete --careful \
                --name "JetBrainsMono" \
                "/in/JetBrainsMono[wght].ttf"
        fi

        # Patch italic
        if [[ -f "$FONTS_DIR/JetBrainsMono-Italic[wght].ttf" ]]; then
            docker run --rm \
                -v "$FONTS_DIR:/in:Z" \
                -v "$PATCHED_DIR:/out:Z" \
                nerdfonts/patcher \
                --complete --careful \
                --name "JetBrainsMono" \
                "/in/JetBrainsMono-Italic[wght].ttf"
        fi

        # Copy patched fonts to destination
        if ls "$PATCHED_DIR"/*.ttf &> /dev/null; then
            cp "$PATCHED_DIR"/*.ttf "$FONT_DEST/"
            log_success "Patched fonts installed!"
        else
            log_warn "Font patching produced no output, using symbols fallback instead"
        fi

    # Fallback: Use FontForge directly if installed
    elif command -v fontforge &> /dev/null; then
        log_info "Using FontForge to patch fonts..."

        # Download the patcher script
        PATCHER_DIR="$HOME/.local/share/nerd-fonts-patcher"
        if [[ ! -d "$PATCHER_DIR" ]]; then
            mkdir -p "$PATCHER_DIR"
            curl -fLo "$PATCHER_DIR/FontPatcher.zip" \
                "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FontPatcher.zip"
            unzip -o "$PATCHER_DIR/FontPatcher.zip" -d "$PATCHER_DIR"
            rm "$PATCHER_DIR/FontPatcher.zip"
        fi

        # Patch fonts
        cd "$PATCHER_DIR"
        if [[ -f "$FONTS_DIR/JetBrainsMono[wght].ttf" ]]; then
            fontforge -script font-patcher "$FONTS_DIR/JetBrainsMono[wght].ttf" \
                --complete --careful --outputdir "$PATCHED_DIR" || true
        fi
        if [[ -f "$FONTS_DIR/JetBrainsMono-Italic[wght].ttf" ]]; then
            fontforge -script font-patcher "$FONTS_DIR/JetBrainsMono-Italic[wght].ttf" \
                --complete --careful --outputdir "$PATCHED_DIR" || true
        fi
        cd -

        # Copy patched fonts
        if ls "$PATCHED_DIR"/*.ttf &> /dev/null; then
            cp "$PATCHED_DIR"/*.ttf "$FONT_DEST/"
            log_success "Patched fonts installed!"
        else
            log_warn "Font patching failed, using symbols fallback instead"
        fi

    else
        log_warn "Neither Docker nor FontForge available for font patching"
        log_info "Using Symbols Nerd Font as fallback (already installed)"
        log_info "To patch fonts later, install Docker and run: ./scripts/setup.sh --patch-fonts"
    fi

    # Refresh font cache on Linux
    if [[ "$OS" == "linux" ]]; then
        fc-cache -fv
    fi
}

# =============================================================================
# Create .zshrc with all configurations
# =============================================================================
setup_zshrc() {
    log_info "Creating .zshrc configuration..."

    cat > "$HOME/.zshrc" << 'ZSHRC_EOF'
# =============================================================================
# ZSH Configuration
# =============================================================================

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bureau"
plugins=(git docker rust golang python pip npm)
source $ZSH/oh-my-zsh.sh

# =============================================================================
# Environment Variables
# =============================================================================

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# User
export USER=$(/usr/bin/whoami)

# Paths
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby (rbenv)
if [[ -d "$HOME/.rbenv" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# uv (Python)
export PATH="$HOME/.local/bin:$PATH"

# Foundry (Solidity)
export PATH="$HOME/.foundry/bin:$PATH"

# SDKMAN (Java) - must be at the end
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# =============================================================================
# Aliases - Node/NPM to Bun
# =============================================================================

alias node="bun"
alias npm="bun"
alias npx="bunx"
alias yarn="bun"

# =============================================================================
# Aliases - General
# =============================================================================

alias vi="nvim"
alias vim="nvim"
alias v="nvim"
alias clr="clear"
alias cls="clear"
alias ll="eza -la --icons --git"
alias ls="eza --icons"
alias la="eza -a --icons"
alias lt="eza -T --icons --level=2"
alias cat="bat --style=plain"

# Git
alias gcl="git clone"
alias gst="git status"
alias gco="git checkout"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gf="git fetch"
alias gd="git diff"
alias gl="git log --oneline -10"

# Python (via uv)
alias python="uv run python"
alias py="uv run python"
alias pip="uv pip"

# Config shortcuts
alias zshconfig="nvim ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias nvimconfig="nvim ~/.config/nvim"
alias alacrittyconfig="nvim ~/.config/alacritty/alacritty.toml"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# =============================================================================
# Functions
# =============================================================================

# Create and enter directory
mkcd() { mkdir -p "$1" && cd "$1"; }

# Quick find
ff() { find . -name "*$1*" 2>/dev/null; }

# Extract any archive
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# =============================================================================
# Tool Initializations
# =============================================================================

# zoxide (smart cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LS_COLORS
export LS_COLORS="$LS_COLORS:ow=01;36;40"

# =============================================================================
# Platform-specific
# =============================================================================

# WSL detection
if grep -iq Microsoft /proc/version 2>/dev/null; then
    export WIN_HOME="/mnt/c/Users/$USER"
fi

# macOS specific
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Homebrew
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

ZSHRC_EOF

    log_success ".zshrc created!"
}

# =============================================================================
# Deploy Configs
# =============================================================================
deploy_configs() {
    log_info "Deploying configuration files..."

    CONFIGS_DIR="$HOME/configs"

    # Alacritty
    mkdir -p "$HOME/.config/alacritty"
    if [[ -f "$CONFIGS_DIR/alacritty/alacritty.toml" ]]; then
        cp "$CONFIGS_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/"
    fi

    # Neovim
    mkdir -p "$HOME/.config/nvim"
    if [[ -d "$CONFIGS_DIR/nvim" ]]; then
        cp -r "$CONFIGS_DIR/nvim/"* "$HOME/.config/nvim/"
    fi

    # Tmux
    if [[ -f "$CONFIGS_DIR/tmux/tmux.conf" ]]; then
        cp "$CONFIGS_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    fi

    # VSCode
    if [[ "$OS" == "macos" ]]; then
        VSCODE_DIR="$HOME/Library/Application Support/Code/User"
    else
        VSCODE_DIR="$HOME/.config/Code/User"
    fi
    mkdir -p "$VSCODE_DIR"
    if [[ -f "$CONFIGS_DIR/vscode/settings.json" ]]; then
        cp "$CONFIGS_DIR/vscode/settings.json" "$VSCODE_DIR/"
    fi

    log_success "Configs deployed!"
}

# =============================================================================
# Help
# =============================================================================
show_help() {
    echo "Usage: ./setup.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --help          Show this help message"
    echo "  --patch-fonts   Only patch fonts with Nerd Font symbols"
    echo "  --fonts-only    Only install/patch fonts"
    echo "  --no-patch      Skip font patching (use symbols fallback)"
    echo ""
    echo "Examples:"
    echo "  ./setup.sh                  # Full setup"
    echo "  ./setup.sh --patch-fonts    # Only patch fonts"
    echo "  ./setup.sh --no-patch       # Full setup without font patching"
}

# =============================================================================
# Main
# =============================================================================
main() {
    # Parse arguments
    PATCH_ONLY=false
    FONTS_ONLY=false
    SKIP_PATCH=false

    for arg in "$@"; do
        case $arg in
            --help)
                show_help
                exit 0
                ;;
            --patch-fonts)
                PATCH_ONLY=true
                ;;
            --fonts-only)
                FONTS_ONLY=true
                ;;
            --no-patch)
                SKIP_PATCH=true
                ;;
        esac
    done

    echo ""
    echo "============================================="
    echo "  Development Environment Setup Script"
    echo "============================================="
    echo ""

    detect_os

    if [[ "$OS" == "unknown" ]]; then
        log_error "Unsupported operating system"
        exit 1
    fi

    # Handle --patch-fonts only
    if [[ "$PATCH_ONLY" == true ]]; then
        patch_fonts
        echo ""
        log_success "Font patching complete!"
        return
    fi

    # Handle --fonts-only
    if [[ "$FONTS_ONLY" == true ]]; then
        setup_fonts
        if [[ "$SKIP_PATCH" != true ]]; then
            patch_fonts
        fi
        echo ""
        log_success "Fonts setup complete!"
        return
    fi

    # Full setup
    if [[ "$OS" == "macos" ]]; then
        setup_macos
    else
        setup_linux
    fi

    # Common setup
    setup_zsh
    setup_java
    setup_fonts

    # Patch fonts unless skipped
    if [[ "$SKIP_PATCH" != true ]]; then
        patch_fonts
    fi

    setup_zshrc
    deploy_configs

    echo ""
    echo "============================================="
    log_success "Setup complete!"
    echo "============================================="
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. For Java, run: sdk install java 21-tem"
    echo "  3. For Python, run: uv python install 3.12"
    echo ""
    if [[ "$SKIP_PATCH" == true ]]; then
        echo "Note: Font patching was skipped. To patch fonts later, run:"
        echo "  ./scripts/setup.sh --patch-fonts"
        echo ""
    fi
}

main "$@"

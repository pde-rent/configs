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

# Project directories
alias godesktop="cd ~/Desktop"
alias godownloads="cd ~/Downloads"
alias godocuments="cd ~/Documents"
alias goprojects="cd ~/Projects"
alias goconfig="cd ~/configs"

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

# Backup configs to git
backup_config() {
    local configs_dir="$HOME/configs"
    if [[ -d "$configs_dir/.git" ]]; then
        cd "$configs_dir"
        cp ~/.zshrc .
        cp -r ~/.config/alacritty/* alacritty/ 2>/dev/null
        cp -r ~/.config/nvim/* nvim/ 2>/dev/null
        git add -A
        git commit -m "config backup $(date +%Y-%m-%d)"
        git push
        cd -
    else
        echo "Error: $configs_dir is not a git repository"
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

#!/usr/bin/env bash
set -e

# Helper function to check if a command exists in the system path
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

echo "=== [1/7] Cleaning Up Conflicting Legacy Apps ==="
if is_installed snap; then
    sudo snap remove nvim 2>/dev/null || true
    sudo snap remove neovim 2>/dev/null || true
fi
sudo apt remove -y neovim 2>/dev/null || true
sudo rm -f /usr/bin/nvim

echo "=== [2/7] Refreshing and Injecting System Dependencies ==="
sudo apt update
sudo apt install -y curl tar git make gcc ripgrep unzip xclip build-essential ninja-build lua5.4 liblua5.4-dev

echo "=== [3/7] Checking Neovim (nvim) ==="
if is_installed nvim && [ -x /usr/local/bin/nvim ]; then
    echo "✅ Neovim is already installed at /usr/local/bin/nvim. Skipping."
else
    echo "📥 Neovim not found. Installing latest pre-compiled binary package..."
    cd /tmp
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    sudo mv /opt/nvim-linux-x86_64 /opt/nvim
    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    echo "✅ Neovim binary structured successfully."
fi

echo "=== [4/7] Checking Node.js, NPM & Pyright LSP ==="
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! is_installed nvm; then
    echo "📥 NVM missing. Provisioning framework..."
    curl -o- https://githubusercontent.com | bash
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

if ! is_installed node; then
    echo "📥 Runtime node environment engine missing. Setting up LTS release..."
    nvm install --lts
    nvm use --lts
fi

if is_installed pyright; then
    echo "✅ Pyright language server is already active. Skipping."
else
    echo "📥 Injecting Pyright server platform globally via npm..."
    npm install -g pyright
fi

echo "=== [5/7] Checking Fuzzy Finder (fzf) via Native APT ==="
if is_installed fzf; then
    echo "✅ fzf is already installed via native package paths. Skipping."
else
    echo "📥 Installing fzf utilizing native apt package index..."
    sudo apt install -y fzf
fi

echo "=== [6/7] Checking GitHub Copilot CLI (Custom Directory Setup) ==="
# Ensure custom directory exists and is added to the user's path config
mkdir -p "$HOME/custom/bin"

if is_installed copilot && [[ "$(command -v copilot)" == *"$HOME/custom/bin"* ]]; then
    echo "✅ GitHub Copilot CLI is already operational inside custom path target. Skipping."
else
    echo "📥 Injecting GitHub Copilot CLI version v0.0.369 into your custom prefix..."
    
    # Run the installation using your exact parameters
    curl -fsSL https://gh.io/copilot-install | VERSION="v0.0.369" PREFIX="$HOME/custom" bash
    
    # Ensure the user's .zshrc maps the custom bin directory
    if ! grep -q 'export PATH="$HOME/custom/bin:$PATH"' "$HOME/.zshrc"; then
        echo 'export PATH="$HOME/custom/bin:$PATH"' >> "$HOME/.zshrc"
        echo "🔹 Appended custom prefix directory to your ~/.zshrc configuration."
    fi
fi

echo "=== [7/7] Checking Lua Language Server ==="
if is_installed lua-language-server || [ -f "$HOME/.local/share/lua-language-server/bin/lua-language-server" ]; then
    echo "✅ Lua Language Server found. Skipping."
    mkdir -p "$HOME/.local/bin"
    if [ ! -f "$HOME/.local/bin/lua-language-server" ]; then
        ln -sf "$HOME/.local/share/lua-language-server/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
    fi
else
    echo "📥 Compiling Lua Language Server workspace from source core..."
    mkdir -p "$HOME/.local/share"
    cd "$HOME/.local/share"
    if [ ! -d "lua-language-server" ]; then
        git clone https://github.com
    fi
    cd lua-language-server
    ./make.sh
    
    mkdir -p "$HOME/.local/bin"
    ln -sf "$HOME/.local/share/lua-language-server/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
    echo "✅ Built Lua Language Server successfully."
fi

echo "=================================================="
echo " Environment setup complete! Run the following:   "
echo "                                                  "
echo " source ~/.zshrc                                  "
echo " rehash                                           "
echo "=================================================="


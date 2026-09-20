#!/usr/bin/env bash
set -e

# Helper function to check if a command exists in the system path
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

echo "=== [1/6] Cleaning Up Conflicting Legacy Apps ==="
# We always make sure the broken snap versions are gone
if is_installed snap; then
    sudo snap remove nvim 2>/dev/null || true
    sudo snap remove neovim 2>/dev/null || true
fi
sudo apt remove -y neovim 2>/dev/null || true
sudo rm -f /usr/bin/nvim

echo "=== [2/6] Checking Base System Dependencies ==="
sudo apt update
sudo apt install -y curl tar git make gcc ripgrep unzip xclip build-essential ninja-build lua5.4 liblua5.4-dev

echo "=== [3/6] Checking Neovim (nvim) ==="
if is_installed nvim && [ -x /usr/local/bin/nvim ]; then
    echo "✅ Neovim is already installed at /usr/local/bin/nvim. Skipping."
else
    echo "📥 Neovim not found or misconfigured. Installing latest binary package..."
    cd /tmp
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    sudo mv /opt/nvim-linux-x86_64 /opt/nvim
    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    echo "✅ Neovim installed successfully."
fi

echo "=== [4/6] Checking Node.js, NPM & Pyright ==="
# Load NVM environment variables if they exist so we can check accurately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! is_installed nvm; then
    echo "📥 NVM (Node Version Manager) not found. Installing..."
    curl -o- https://githubusercontent.com | bash
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

if ! is_installed node; then
    echo "📥 Node.js not found. Installing LTS version via NVM..."
    nvm install --lts
    nvm use --lts
fi

if is_installed pyright; then
    echo "✅ Pyright language server is already installed. Skipping."
else
    echo "📥 Pyright not found. Installing globally via npm..."
    npm install -g pyright
fi

echo "=== [5/6] Checking Command Line Fuzzy Finder (fzf) ==="
if is_installed fzf; then
    echo "✅ fzf is already installed in your path. Skipping."
else
    echo "📥 fzf not found. Cloning and installing tool locally..."
    if [ ! -d "$HOME/.fzf" ]; then
        git clone --depth 1 https://github.com ~/.fzf
    fi
    ~/.fzf/install --key-bindings --completion --update-rc --no-bash
fi

echo "=== [6/6] Checking Lua Language Server (lua-language-server) ==="
if is_installed lua-language-server || [ -f "$HOME/.local/share/lua-language-server/bin/lua-language-server" ]; then
    echo "✅ Lua Language Server is already installed. Skipping."
    
    # Optional: ensure it's linked to your local bin so nvim can find it easily
    mkdir -p "$HOME/.local/bin"
    if [ ! -f "$HOME/.local/bin/lua-language-server" ]; then
        ln -sf "$HOME/.local/share/lua-language-server/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
    fi
else
    echo "📥 Lua Language Server not found. Compiling from source framework..."
    mkdir -p "$HOME/.local/share"
    cd "$HOME/.local/share"
    if [ ! -d "lua-language-server" ]; then
        git clone https://github.com
    fi
    cd lua-language-server
    ./make.sh
    
    mkdir -p "$HOME/.local/bin"
    ln -sf "$HOME/.local/share/lua-language-server/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
    echo "✅ Lua Language Server built and linked successfully."
fi

echo "=================================================="
echo " Smart check complete! If anything updated, run:  "
echo " source ~/.zshrc                                  "
echo "=================================================="


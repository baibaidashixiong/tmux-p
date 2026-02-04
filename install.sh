#!/bin/bash
set -e

CONFIG_DIR="$HOME/.config/tmux"
PLUGINS_DIR="$CONFIG_DIR/plugins"
TMUX_CONF="$HOME/.tmux.conf"

echo "Installing Tmux configuration..."

# 1. Backup existing config
if [ -f "$TMUX_CONF" ]; then
    echo "Backing up existing .tmux.conf to $TMUX_CONF.bak"
    mv "$TMUX_CONF" "$TMUX_CONF.bak"
fi

if [ -d "$CONFIG_DIR" ]; then
    echo "Backing up existing config dir to $CONFIG_DIR.bak"
    # Remove old backup if exists to avoid error
    rm -rf "$CONFIG_DIR.bak"
    mv "$CONFIG_DIR" "$CONFIG_DIR.bak"
fi

# 2. Create directories
echo "Creating config directories..."
mkdir -p "$PLUGINS_DIR"

# 3. Copy files
echo "Copying plugins..."
# We are currently in the repo root
# $0 is the script path, so dirname $0 is the repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure we are copying the content of plugins/ into the destination plugins/
# We use -r to copy recursively.
cp -r "$REPO_ROOT/plugins/"* "$PLUGINS_DIR/"
cp "$REPO_ROOT/.tmux.conf" "$TMUX_CONF"

echo "Installation complete!"
echo "Plugin paths set to: $PLUGINS_DIR"
echo "Config file: $TMUX_CONF"
echo "Please reload tmux (tmux source ~/.tmux.conf) or restart it."

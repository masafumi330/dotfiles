#!/bin/bash

set -e

echo "Starting dotfiles setup for macOS..."

# Homebrew チェック & インストール
check_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "🔄 Running brew update..."
  brew update

  # echo "⏫ Running brew upgrade..."
  # brew upgrade

  # echo "🧹 Running brew cache cleanup..."
  # brew cleanup --prune=all
}

# 各ツールのインストール
install_alacritty() {
  brew install --cask font-hack-nerd-font
  if ! command -v alacritty &>/dev/null; then
    echo "Installing Alacritty..."
    # --cask GUIアプリとしてインストール
    brew install --cask alacritty
  fi
}

install_tmux() {
  if ! command -v tmux &>/dev/null; then
    echo "Installing tmux..."
    brew install tmux
  fi
}

install_neovim() {
  if ! command -v nvim &>/dev/null; then
    echo "Installing Neovim..."
    brew install neovim
  fi
}

install_lazyvim() {
  local nvim_config="$HOME/.config/nvim"
  if [ ! -d "$nvim_config/lazy" ]; then
    echo "Installing LazyVim..."
    # required. Make a backup of your current Neovim files if exists:
    if [ -d "$HOME/.config/nvim" ]; then
      mv $HOME/.config/nvim{,.bak}
    fi
    git clone https://github.com/LazyVim/starter "$nvim_config"
    # Remove the .git folder, so you can add it to your own repo later
    rm -rf ~/.config/nvim/.git
  fi
}

apply_vscode_settings() {
  local settings_src=".vscode/settings.json"
  local settings_dest="$HOME/Library/Application Support/Code/User/settings.json"
  local keybindings_src=".vscode/keybindings.json"
  local keybindings_dest="$HOME/Library/Application Support/Code/User/keybindings.json"

  if [ -f "$DOTFILES_DIR/$settings_src" ]; then
    echo "Linking VS Code user settings..."
    link_dotfile "$settings_src" "$settings_dest"
  else
    echo "VS Code settings not found at $DOTFILES_DIR/$settings_src. Skipping."
  fi

  if [ -f "$DOTFILES_DIR/$keybindings_src" ]; then
    echo "Linking VS Code keybindings..."
    link_dotfile "$keybindings_src" "$keybindings_dest"
  else
    echo "VS Code keybindings not found at $DOTFILES_DIR/$keybindings_src. Skipping."
  fi
}

# dotfiles ディレクトリ
DOTFILES_DIR=$(
  cd "$(dirname "$0")"
  pwd
)

# シンボリックリンク作成
link_dotfile() {
  src=$1
  dest=$2
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $dest to $backup"
    mv "$dest" "$backup"
  fi
  if [ ! -L "$dest" ]; then
    echo "Linking $src -> $dest"
    ln -sf "$DOTFILES_DIR/$src" "$dest"
  fi
}

# 実行
check_homebrew
install_alacritty
install_tmux
install_neovim
install_lazyvim

link_dotfile .tmux.conf "$HOME/.tmux.conf"
link_dotfile .myclirc "$HOME/.myclirc"
link_dotfile nvim "$HOME/.config/nvim"
link_dotfile alacritty "$HOME/.config/alacritty"
link_dotfile .codex/AGENTS.md "$HOME/.codex/AGENTS.md"
link_dotfile .codex/prompts "$HOME/.codex/prompts"
apply_vscode_settings

echo "✅ Dotfiles setup complete on macOS!"

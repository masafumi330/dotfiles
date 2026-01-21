# dotfiles (Development Environment 2026)

このリポジトリは macOS 上での開発環境「現状 2026」を再現するための dotfiles 集です。Alacritty + tmux + zsh/oh-my-zsh を中心に、Neovim(Lazy.nvim)と GitHub Copilot を軸とした AI ワークフローをまとめています。

## 構成概要

| パス / ファイル | 役割 |
| --- | --- |
| `.zshrc` | zsh + oh-my-zsh の設定。各プラグインのロードやエイリアスを定義 |
| `.tmux.conf` | tmux のキーバインドと UI 調整 |
| `alacritty/` | `alacritty.toml` とテーマ設定 |
| `nvim/` | LazyVim ベースの Neovim 設定。`lazyvim.json` で Extras を管理 |

## Terminal / Shell

- **Terminal エミュレータ**: [Alacritty](https://alacritty.org/)（Hack Nerd Font + 透過を含むカスタムテーマ）
- **Terminal Multiplexer**: [tmux](https://github.com/tmux/tmux)（`.tmux.conf` でプレフィックスやステータスラインを統一）
- **Shell**: zsh + [oh-my-zsh](https://ohmyz.sh/)
  - プラグイン
    - `git` — Git エイリアスと補助関数
    - `docker` — Docker/Compose サブコマンド補助
    - `zsh-completions` — コマンド補完強化
    - `zsh-autosuggestions` — 履歴からの自動提案

## Neovim (Editor)

- **エディタ**: Neovim 0.9+
- **Plugin Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim)
- **セットアップ方針**: LazyExtras のみを最小構成で追加（シンプルに）
- **AI**
  - `lazyvim.plugins.extras.ai.copilot` … コード補完
  - `lazyvim.plugins.extras.ai.sidekick` … サイドパネルで AI チャット
- **Language Extras**（よく使う言語に限定）
  - `lang.go`
  - `lang.tailwind`
  - `lang.typescript`
  - `lang.json`
  - `lang.markdown`

## AI エージェント

- **GitHub Copilot**（会社で許可されている唯一の AI。エディタ内補完と Copilot Chat を活用）

## ブラウザ

- Arc（メイン。ワークスペース分離）
- Google Chrome（サブ。検証用）

## TODO(2026現在)

- [] dotfilesをchezmoiで管理する

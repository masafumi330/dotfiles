# About

This is my dotfiles!

# Tools

| Category | Tool |
| --- | --- |
| Terminal | WezTerm |
| Shell | zsh |
| Editor | NeoVim |
| Browser | Arc |

# Setup

```sh
# 1. Install chezmoi
brew install chezmoi

# 2. Apply
chezmoi init --apply git@github.com/masafumi330/dotfiles
```

# Workflow

```sh
# 1. sync remote setting
chezmoi update && chezmoi apply

# 2. edit(example) 
chezmoi edit ~/.wezterm.lua --apply

# 3. commit changes
chezmoi cd 
git add .
git commit -m "commit message"
```

# 💤 My LazyVim Configuration

This is my personal Neovim configuration, built on top of the excellent [LazyVim](https://github.com/LazyVim/LazyVim) starter template. It is customized for my development workflow, with specific enhancements for web development, including Laravel and Tailwind CSS.

## ✨ Features

-   **Base**: Powered by [LazyVim](https://github.com/LazyVim/LazyVim) for a fast, modern, and full-featured IDE experience.
-   **Laravel Support**: Includes custom configurations for Laravel Blade templates (`blade-definition.lua`).
-   **Tailwind CSS**: Integrated Tailwind CSS support via LSP (`lsp-tailwindcss.lua`).
-   **Debugging**: Configured Debug Adapter Protocol (DAP) for debugging support (`dap.lua`).
-   **Formatting & Linting**: robust formatting and linting setup (`formatting.lua`).
-   **Treesitter**: Advanced syntax highlighting and code parsing (`treesitter.lua`).
-   **UI Enhancements**: Custom UI tweaks and editor settings (`ui.lua`, `editor.lua`, `colorscheme.lua`).

## 📂 Structure

The configuration follows the standard LazyVim structure:

-   `lua/config/`: Core configuration (options, keymaps, autocmds, lazy.nvim setup).
-   `lua/plugins/`: Plugin specifications and configurations.
    -   `blade-definition.lua`: Custom Blade directive definitions.
    -   `lsp-tailwindcss.lua`: Tailwind CSS LSP configuration.
    -   `dap.lua`: Debugging configurations.
    -   `lsp.lua`: Language Server Protocol settings.
    -   ...and more.

## 🚀 Installation

If you are cloning this dotfiles repository, symlink the `nvim` directory to your config path:

```sh
# Linux / macOS
ln -s ~/path/to/dotfiles/.config/nvim ~/.config/nvim

# Windows (PowerShell)
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Target C:\path\to\dotfiles\.config\nvim
```

Make sure you have [Neovim](https://neovim.io/) installed (version 0.9.0+ recommended).

## ⚡ Requirements

-   Neovim >= 0.9.0
-   Git
-   A [Nerd Font](https://www.nerdfonts.com/) (optional, but recommended for icons)
-   Build tools (gcc, make, etc.) for compiling Telescope fzf-native and Treesitter parsers.

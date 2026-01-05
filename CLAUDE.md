# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS, containing shell configurations, utility scripts, and application settings.

## Key Architecture

### Shell Configuration (zsh)

The shell setup follows this load order:
1. `.zshenv` - Environment variables, PATH setup, exports (loaded first, always)
2. `.zshrc` - Interactive shell config, loads oh-my-zsh, zplug plugins, aliases
3. `.zplugrc` - Plugin manager configuration (powerlevel10k theme, autosuggestions, completions, forgit)
4. `.fzfrc` - fzf fuzzy finder configuration (uses fd for file discovery)
5. `.aliases` - Shell aliases and helper functions
6. `lib-includes` - Sources all library files from `lib/`

### Directory Structure

- `bin/` - Executable scripts added to PATH
- `lib/` - Shell library files sourced at startup (docker helpers, pomodoro, note-taking, etc.)
- `zfuncs/` - Autoloaded zsh functions (bubu, brewfind, halp, man, etc.)
- `zsh.custom/` - oh-my-zsh custom directory
- `config/` - Application configs (iina, etc.)
- `setup/` - Installation scripts

### Custom Commands

- `bubu` - Updates homebrew and oh-my-zsh (run `bubu -v` for verbose)
- `brewfind` / `brinfo` - Search homebrew packages
- `halp` - Help/cheatsheet viewer
- `fprev` - fzf file preview
- `cheat` - Cheatsheet lookup

## Setup

Initial setup is handled by `setup/setup-dotfiles.sh` which:
1. Installs oh-my-zsh
2. Installs zplug
3. Symlinks dotfiles to home directory
4. Sets up neovim configuration

## Conventions

- Shell scripts use `shellcheck` directives for linting
- Library files in `lib/` are sourced via `lib-includes`
- Custom zsh functions go in `zfuncs/` and are autoloaded
- The `DOTFILES` environment variable points to this repository (`~/dotfiles`)

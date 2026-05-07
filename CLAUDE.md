# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim, a single-file starting point that has been modularized into a plugin-based structure. The configuration uses lazy.nvim as the plugin manager and follows a base + custom plugin architecture.

## Setup and Installation

### Installing the Configuration

Use the `setupConfig.sh` script to symlink this directory to `~/.config/nvim`:

```bash
./setupConfig.sh
```

This removes any existing `~/.config/nvim` and creates a symlink to the repository directory.

### Managing Plugins

All plugin management is handled via lazy.nvim:

```vim
:Lazy          " View plugin status
:Lazy update   " Update all plugins
:Lazy sync     " Install missing plugins and clean unused ones
```

### LSP and Tool Management

LSP servers and external tools are managed via Mason:

```vim
:Mason         " Open Mason UI
:checkhealth   " Verify installation health
```

Configured LSP servers:
- `ts_ls` - TypeScript/JavaScript
- `lua_ls` - Lua
- `bashls` - Bash

Additional tools auto-installed via mason-tool-installer:
- `stylua` - Lua formatter
- `shfmt` - Shell script formatter

## Architecture

### Plugin Organization

The configuration uses a three-tier plugin structure:

1. **Base plugins** (`lua/base/plugins/`) - Core plugins required for basic functionality
2. **Kickstart plugins** (`lua/kickstart/plugins/`) - Optional plugins from kickstart.nvim
3. **Custom plugins** (`lua/custom/plugins/`) - User-added plugins and customizations

Plugins are auto-loaded via lazy.nvim imports in `init.lua`:
```lua
{ import = 'base.plugins' }
{ import = 'custom.plugins' }
```

### Key Base Plugins

- **blink.cmp** - Completion engine (provides LSP capabilities)
- **nvim-lspconfig** - LSP configuration with Mason integration
- **conform.nvim** - Auto-formatting (format on save)
- **nvim-lint** - Linting support
- **telescope.nvim** - Fuzzy finder for files, LSP symbols, etc.
- **nvim-treesitter** - Syntax highlighting and code understanding
- **which-key.nvim** - Keybinding help popup
- **gitsigns** - Git integration in sign column

### Configuration Files

- `init.lua` - Main entry point with core settings and plugin setup
- `lsp.lua` - Commented-out legacy LSP config (not currently in use)
- `lua/base/plugins/*.lua` - Individual plugin configurations
- `lua/custom/plugins/*.lua` - User customizations

## Development

### Formatting

Formatting is handled by conform.nvim:
- Format on save is enabled by default (except for C/C++)
- Manual format: `<leader>F` in normal mode
- Configured formatters:
  - Lua: `stylua`
  - Markdown: `markdownlint`
  - JavaScript: `prettierd` or `prettier`
  - Shell: `shfmt`

### Linting

Linting via nvim-lint:
- Markdown: `markdownlint`
- Runs on `BufEnter`, `BufWritePost`, and `InsertLeave` events

### ASDF Integration

The configuration supports ASDF version management. See `ASDF.md` for details on configuring Neovim to use ASDF shims for tools like `markdownlint` and `node`.

To enable (currently commented out in init.lua):
```lua
local asdf_shims = vim.env.HOME .. '/.asdf/shims'
vim.env.PATH = asdf_shims .. ':' .. vim.env.PATH
```

## Key Keybindings

Leader key: `<space>`

### LSP
- `grn` - Rename symbol
- `gra` - Code action
- `grr` - Find references (Telescope)
- `grd` - Go to definition (Telescope)
- `gri` - Go to implementation (Telescope)
- `grt` - Go to type definition (Telescope)
- `grD` - Go to declaration
- `gO` - Document symbols (Telescope)
- `gW` - Workspace symbols (Telescope)
- `<leader>th` - Toggle inlay hints

### General
- `<leader>F` - Format buffer
- `<leader>r` - Replace all occurrences in file
- `<leader>q` - Open diagnostic quickfix list
- `<leader>,` - Previous buffer
- `<leader>.` - Next buffer
- `<leader>n` - New buffer
- `<Esc>` - Clear search highlights
- `<C-h/j/k/l>` - Navigate between windows

### Telescope
- `<leader>sh` - Search help

## Configuration Preferences

- Tab width: 2 spaces (expandtab enabled)
- Line numbers: enabled
- Scrolloff: 10 lines
- Mouse: enabled
- Clipboard: synced with OS
- Cursorline: enabled
- Confirm on unsaved changes: enabled

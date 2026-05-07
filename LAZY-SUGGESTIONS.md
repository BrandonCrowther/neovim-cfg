# LazyVim Feature Comparison

This document tracks features available in LazyVim that are not yet implemented in this Kickstart-based configuration.

## Current Status

### What You Have

- ✅ Bufferline (VSCode-style tab bar)
- ✅ Neo-tree (file explorer)
- ✅ Trouble (better diagnostics view)
- ✅ Todo-comments
- ✅ Mini.nvim suite (ai, surround, statusline)
- ✅ Telescope with file browser
- ✅ Which-key (keybinding helper)
- ✅ LSP with Mason
- ✅ Conform (formatting)
- ✅ Nvim-lint
- ✅ Blink.cmp (completion)
- ✅ Treesitter
- ✅ Gitsigns

## Major Missing Features

### 1. Visual Buffer/Tab Line

**Plugin:** `bufferline.nvim`
**Impact:** High - Shows open buffers as tabs at the top (like VSCode)
**Status:** ✅ Implemented - `lua/base/plugins/bufferline.lua`

### 2. File Explorer

**Plugin:** `neo-tree.nvim`
**Impact:** High - Visual file tree explorer
**Status:** ✅ Enabled - `lua/kickstart/plugins/neo-tree.lua`

### 3. Integrated Terminal

**Plugin:** `toggleterm.nvim`
**Impact:** Medium - Floating terminal (like Ctrl+` in VSCode)
**Status:** Not implemented

### 4. Better Notifications

**Plugin:** `noice.nvim`
**Impact:** Medium - Prettier command line and notifications
**Status:** Not implemented

### 5. Dashboard/Start Screen

**Plugin:** `alpha-nvim` or `dashboard-nvim`
**Impact:** Low - Welcome screen with recent files
**Status:** Not implemented

## Nice-to-Have Features

### Git Integration

**Plugin:** `lazygit.nvim`
**Impact:** Medium - Full git UI inside Neovim
**Status:** Not implemented

### Enhanced Navigation

**Plugin:** `flash.nvim` or `leap.nvim`
**Impact:** Medium - Jump to any position with a few keystrokes
**Status:** Not implemented

### Session Management

**Plugin:** `persistence.nvim`
**Impact:** Medium - Restore your workspace between sessions
**Status:** Not implemented

### Better UI Components

**Plugin:** `dressing.nvim`
**Impact:** Low - Better UI for select/input dialogs
**Status:** Not implemented

### Word Highlighting

**Plugin:** `vim-illuminate`
**Impact:** Low - Highlight other uses of word under cursor
**Status:** Not implemented

### Advanced Code Folding

**Plugin:** `nvim-ufo`
**Impact:** Low - Better code folding with fold preview
**Status:** Not implemented

### Project-Wide Search/Replace

**Plugin:** `nvim-spectre`
**Impact:** Medium - Search and replace across entire project
**Status:** Not implemented

### LSP Breadcrumbs

**Plugin:** `nvim-navic` or `barbecue.nvim`
**Impact:** Low - Shows your current code location in statusline
**Status:** Not implemented

## Implementation Plan

1. ✅ Document missing features (this file)
2. ✅ Add bufferline.nvim - Visual buffer tabs
3. ✅ Enable neo-tree.nvim - File explorer
4. ⏸️ Add toggleterm.nvim - Integrated terminal
5. ⏸️ Add lazygit.nvim - Git UI
6. ⏸️ Evaluate other plugins based on need

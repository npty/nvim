# Npty's Keybindings Reference

This document provides a comprehensive list of all keybindings in the Neovim configuration. The `<leader>` key is mapped to `<Space>`.

## Table of Contents

- [General](#general)
- [Navigation](#navigation)
- [LSP](#lsp)
- [Git](#git)
- [Files and Search](#files-and-search)
- [Terminal](#terminal)
- [Code Actions](#code-actions)
- [UI Toggles](#ui-toggles)
- [Window Management](#window-management)
- [Plugin-Specific](#plugin-specific)

## General

| Keybinding   | Mode | Description                 |
| ------------ | ---- | --------------------------- |
| `<Space>`    | N    | Leader key                  |
| `jk`         | I    | Exit insert mode            |
| `<Esc><Esc>` | T    | Exit terminal mode          |
| `<leader>f`  | N    | Format buffer               |
| `<C-c>`      | I    | Trigger completion manually |

## Navigation

| Keybinding | Mode | Description                |
| ---------- | ---- | -------------------------- |
| `vif`      | N    | Select inside function     |
| `vaf`      | N    | Select around function     |
| `vic`      | N    | Select inside class        |
| `vac`      | N    | Select around class        |
| `]f`       | N    | Go to next function        |
| `[f`       | N    | Go to previous function    |
| `]c`       | N    | Go to next class           |
| `[c`       | N    | Go to previous class       |
| `}`        | N    | Next function (Aerial)     |
| `{`        | N    | Previous function (Aerial) |

## LSP

| Keybinding   | Mode | Description              |
| ------------ | ---- | ------------------------ |
| `gd`         | N    | Go to definition         |
| `gr`         | N    | Find references          |
| `gI`         | N    | Go to implementation     |
| `<leader>D`  | N    | Type definition          |
| `<leader>rn` | N    | Rename                   |
| `<leader>ca` | N    | Code action              |
| `K`          | N    | Show hover documentation |
| `<C-k>`      | N/I  | Show signature help      |
| `<leader>ds` | N    | Document symbols         |
| `<leader>ws` | N    | Workspace symbols        |

## Git

| Keybinding   | Mode | Description       |
| ------------ | ---- | ----------------- |
| `<leader>hs` | N    | Stage hunk        |
| `<leader>hr` | N    | Reset hunk        |
| `<leader>hb` | N    | Blame line        |
| `<leader>hp` | N    | Preview hunk      |
| `<leader>hd` | N    | Show diff         |
| `<leader>tb` | N    | Toggle line blame |
| `<leader>gh` | N    | Open in browser   |
| `<leader>dv` | N    | Open DiffView     |

## Files and Search

| Keybinding   | Mode | Description          |
| ------------ | ---- | -------------------- |
| `<leader>sf` | N    | Search files         |
| `<leader>sg` | N    | Live grep            |
| `<leader>sd` | N    | Search diagnostics   |
| `<leader>sh` | N    | Search help          |
| `<leader>/`  | N    | Fuzzy find in buffer |
| `<leader>s.` | N    | Search recent files  |
| `<C-m>`      | N    | Toggle file tree     |
| `<leader>sn` | N    | Search Neovim files  |

## Terminal

| Keybinding   | Mode | Description        |
| ------------ | ---- | ------------------ |
| `<C-\>`      | N    | Toggle terminal    |
| `<Esc><Esc>` | T    | Exit terminal mode |

## Code Actions

| Keybinding   | Mode | Description             |
| ------------ | ---- | ----------------------- |
| `<leader>ai` | N    | Add missing imports     |
| `<leader>f`  | N/V  | Format code             |
| `<leader>xx` | N    | Show diagnostics        |
| `<leader>xX` | N    | Show buffer diagnostics |

## UI Toggles

| Keybinding   | Mode | Description          |
| ------------ | ---- | -------------------- |
| `<leader>tw` | N    | Toggle twilight mode |
| `<leader>tc` | N    | Toggle completion    |
| `<leader>th` | N    | Toggle inlay hints   |
| `<leader>l`  | N    | Toggle Aerial        |
| `<leader>nh` | N    | Open Noice history   |
| `<leader>nd` | N    | Dismiss all messages |

## Window Management

| Keybinding   | Mode | Description           |
| ------------ | ---- | --------------------- |
| `<leader>vs` | N    | Vertical split        |
| `<leader>hs` | N    | Horizontal split      |
| `<C-t>`      | N    | New tab               |
| `<C-w>>`     | N    | Increase window width |
| `<C-w><`     | N    | Decrease window width |

## Plugin-Specific

### Telescope

| Keybinding   | Mode | Description        |
| ------------ | ---- | ------------------ |
| `<leader>sg` | N    | Live grep          |
| `<leader>sf` | N    | Find files         |
| `<leader>sr` | N    | Resume last search |
| `<leader>sh` | N    | Search help        |
| `<leader>sk` | N    | Search keymaps     |

### Trouble

| Keybinding   | Mode | Description           |
| ------------ | ---- | --------------------- |
| `<leader>xx` | N    | Toggle trouble        |
| `<leader>xw` | N    | Workspace diagnostics |
| `<leader>xd` | N    | Document diagnostics  |
| `<leader>xq` | N    | Quickfix list         |

### CodeCompanion

| Keybinding | Mode | Description |
| ---------- | ---- | ----------- |
| `<C-g>c`   | N/V  | New chat    |
| `<C-g>t`   | N/V  | Toggle chat |
| `<C-g>p`   | N/V  | Chat paste  |

### OSC Yank

| Keybinding   | Mode | Description    |
| ------------ | ---- | -------------- |
| `<leader>c`  | N    | Yank operator  |
| `<leader>cc` | N    | Yank line      |
| `<leader>c`  | V    | Yank selection |

## Mode Legend

- N: Normal mode
- I: Insert mode
- V: Visual mode
- T: Terminal mode

## Notes

- Some keybindings may vary based on your specific modifications
- Plugin-specific keybindings may require the respective plugins to be installed and configured
- Use `:WhichKey` to see available keybindings in real-time
- Custom keybindings can be added in your configuration file

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

| Keybinding   | Mode | Description             |
| ------------ | ---- | ----------------------- |
| `<Space>`    | N    | Leader key              |
| `jk`         | I    | Exit insert mode        |
| `<Esc><Esc>` | T    | Exit terminal mode      |
| `<Esc>`      | N    | Clear search highlights |

## Navigation

| Keybinding  | Mode | Description                        |
| ----------- | ---- | ---------------------------------- |
| `vif`       | N    | Select inside function             |
| `vaf`       | N    | Select around function             |
| `vic`       | N    | Select inside class                |
| `vac`       | N    | Select around class                |
| `]f`        | N    | Go to next function                |
| `[f`        | N    | Go to previous function            |
| `]c`        | N    | Go to next class                   |
| `[c`        | N    | Go to previous class               |
| `[c`        | N    | Go to context (treesitter-context) |
| `}`         | N    | Next symbol (Aerial)               |
| `{`         | N    | Previous symbol (Aerial)           |
| `<leader>E` | N    | Explorer (Current File)            |

## LSP

<<<<<<< HEAD
o
=======

> > > > > > > Snippet
> > > > > > > | Keybinding | Mode | Description |
> > > > > > > | ------------ | ---- | ------------------------ |
> > > > > > > | `gd` | N | Go to definition (Snacks) |
> > > > > > > | `gr` | N | Find references (Snacks) |
> > > > > > > | `gI` | N | Go to implementation (Snacks) |
> > > > > > > | `<leader>D` | N | Type definition (Snacks) |
> > > > > > > | `gD` | N | Go to declaration |
> > > > > > > | `<leader>rn` | N | Rename |
> > > > > > > | `<leader>ca` | N | Code action |
> > > > > > > | `K` | N | Show hover documentation (Built-in)|
> > > > > > > | `<C-k>` | N/I | Show signature help |
> > > > > > > | `<leader>ds` | N | Document symbols (Snacks) |
> > > > > > > | `<leader>ws` | N | Workspace symbols (Snacks) |
> > > > > > > | `<leader>th` | N | Toggle Inlay Hints |

## Git

| Keybinding   | Mode | Description           |
| ------------ | ---- | --------------------- |
| `<leader>gg` | N    | Toggle Lazygit        |
| `<leader>bl` | N    | Git Blame Line        |
| `<leader>gh` | N    | Open in browser       |
| `<leader>dv` | N    | Open DiffView         |
| `<leader>dg` | N    | Git Diff (Hunks)      |
| `<leader>gl` | N    | Git Log (Snacks)      |
| `<leader>gb` | N    | Git Branches (Snacks) |

## Files and Search

| Keybinding         | Mode | Description                    |
| ------------------ | ---- | ------------------------------ |
| `<leader>sf`       | N    | Search files                   |
| `<leader>sg`       | N    | Live grep                      |
| `<leader>sd`       | N    | Search diagnostics (Snacks)    |
| `<leader>ss`       | N    | Search Select Pickers (Snacks) |
| `<leader>sw`       | N    | Search current Word (Snacks)   |
| `<leader>rf`       | N    | Search Recent Files (Snacks)   |
| `<leader><leader>` | N    | Find existing buffers (Snacks) |
| `<leader>s/`       | N    | Search in Open Files (Snacks)  |
| `<leader>sh`       | N    | Search help (Snacks)           |
| `<leader>sk`       | N    | Search keymaps (Snacks)        |
| `<leader>sr`       | N    | Resume last search (Snacks)    |
| `<leader>/`        | N    | Fuzzy find in buffer (Snacks)  |
| `<C-m>`            | N    | Toggle Explorer (Snacks)       |

## Terminal

| Keybinding   | Mode | Description              |
| ------------ | ---- | ------------------------ |
| `<leader>tt` | N    | Toggle terminal (Snacks) |
| `<Esc><Esc>` | T    | Exit terminal mode       |
| `<left>`     | N    | echo "Use h to move!!"   |
| `<right>`    | N    | echo "Use l to move!!"   |
| `<up>`       | N    | echo "Use k to move!!"   |
| `<down>`     | N    | echo "Use j to move!!"   |

## Code Actions & Diagnostics

| Keybinding   | Mode | Description                         | Plugin   |
| ------------ | ---- | ----------------------------------- | -------- |
| `<leader>ai` | N    | Add missing imports                 | LSP      |
| `<leader>q`  | N    | Open diagnostic Quickfix list       | Built-in |
| `<leader>xx` | N    | Diagnostics toggle                  | Trouble  |
| `<leader>xX` | N    | Buffer Diagnostics toggle           | Trouble  |
| `<leader>cs` | N    | Symbols toggle                      | Trouble  |
| `<leader>cl` | N    | LSP Definitions / references toggle | Trouble  |
| `<leader>xL` | N    | Location List toggle                | Trouble  |
| `<leader>xQ` | N    | Quickfix List toggle                | Trouble  |

## UI Toggles & Notifications

| Keybinding   | Mode | Description                | Plugin   |
| ------------ | ---- | -------------------------- | -------- |
| `<leader>tw` | N    | Toggle twilight mode       | Twilight |
| `<leader>l`  | N    | Toggle Aerial              | Aerial   |
| `<leader>nh` | N    | Notification History       | Snacks   |
| `<leader>nd` | N    | Notification Dismiss All   | Snacks   |
| `<leader>ne` | N    | Notification Errors Only   | Snacks   |
| `<leader>nw` | N    | Notification Warnings Only | Snacks   |
| `<leader>nt` | N    | Notification Test          | Snacks   |
| `<leader>nu` | N    | Notification Update Test   | Snacks   |

## Window Management

| Keybinding   | Mode | Description           |
| ------------ | ---- | --------------------- |
| `<leader>vs` | N    | Vertical split        |
| `<leader>hs` | N    | Horizontal split      |
| `<C-t>`      | N    | New tab               |
| `<C-w>>`     | N    | Increase window width |
| `<C-w><`     | N    | Decrease window width |

## Plugin-Specific

<<<<<<< HEAD

### OSC Yank

=======

### OSC Yank (Clipboard)

> > > > > > > Snippet

| Keybinding   | Mode | Description    |
| ------------ | ---- | -------------- |
| `<leader>c`  | N    | Yank operator  |
| `<leader>cc` | N    | Yank line      |
| `<leader>c`  | V    | Yank selection |

### Other Snacks & Misc

| Keybinding   | Mode | Description          | Plugin |
| ------------ | ---- | -------------------- | ------ |
| `<leader>u`  | N    | Undo History         | Snacks |
| `<leader>m`  | N    | Jump to Mark         | Snacks |
| `<leader>A`  | N    | Toggle foldmethod    |        |
| `<leader>sr` | N    | Reload Neovim Config | Lazy   |

### Snack Notify

| Keybinding   | Mode | Description                |
| ------------ | ---- | -------------------------- |
| `<leader>nd` | N    | Clear notifications        |
| `<leader>ne` | N    | Notification Errors Only   |
| `<leader>nw` | N    | Notification Warnings Only |
| `<leader>nt` | N    | Notification Test          |
| `<leader>nu` | N    | Notification Update Test   |

### Theme Switcher

| Keybinding   | Mode | Description               |
| ------------ | ---- | ------------------------- |
| `<leader>th` | N    | Toggle theme              |
| `<leader>sr` | N    | Reload config             |
| `<leader>aX` | N    | Clear Avante conversation |

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

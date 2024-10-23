# Neovim Shortcuts and Tips Guide

## 🎯 Essential Shortcuts

### Basic Operations

- `jk` - Exit insert mode (custom mapping)
- `<Esc>` - Clear search highlights in normal mode
- `<C-\>` - Toggle terminal
- `<leader>` is mapped to Space
- Arrow keys are disabled in normal mode to encourage hjkl usage

### File Navigation

- `<C-m>` - Toggle NvimTree file explorer
- `<leader>sf` - Search files
- `<leader>sg` - Live grep (search in files)
- `<leader>s/` - Search in open files
- `<leader>s.` - Search recent files
- `<leader>sn` - Search Neovim config files
- `<leader><leader>` - List open buffers

### Window Management

- `<leader>vs` - Vertical split
- `<leader>hs` - Horizontal split
- `<C-t>` - New tab
- Split navigation handled by tmux.nvim

## 🔍 LSP Features

### Code Navigation

- `gd` - Go to definition (using Telescope)
- `gr` - Find references (using Telescope)
- `gI` - Go to implementation
- `<leader>D` - Type definition
- `gD` - Go to declaration

### Code Actions and Completion

- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<C-k>` - Show signature help (works in both normal and insert mode)
- `<leader>ai` - Add missing imports
- `<leader>f` - Format buffer
- `<C-n>` - Next completion item
- `<C-p>` - Previous completion item
- `<C-y>` - Confirm completion
- `<C-Space>` - Trigger completion manually
- `<C-l>` - Expand snippet or jump forward
- `<C-h>` - Jump backward in snippet

## 🌲 NvimTree Commands

- `g?` - Toggle help
- `<C-]>` - CD into the directory under the cursor
- `<C-v>` - Open in vertical split
- `<C-x>` - Open in horizontal split
- `<C-t>` - Open in new tab
- `<BS>` - Close current opened directory
- `a` - Create file/directory
- `d` - Delete
- `D` - Trash (if configured)
- `r` - Rename
- `R` - Refresh
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `y` - Copy name
- `Y` - Copy relative path
- `gy` - Copy absolute path
- `]c` - Next git item
- `[c` - Prev git item
- `-` - Navigate up to parent directory
- `s` - Open in system default application
- `.` - Toggle dotfiles
- `H` - Toggle hidden files
- `I` - Toggle gitignore files

## 🔄 Git Integration

### Fugitive

- `:G` or `:Git` - Main Git command
- `:Gwrite` or `:Gw` - Git add
- `:Gread` or `:Gr` - Git checkout (revert)
- `:Gdiff` - Git diff
- `:Gblame` - Git blame
- `:Gremove` - Git rm
- `:Gmove` - Git mv
- `cc` - Create commit (in Git status window)
- `ca` - Amend last commit
- `]]` - Next hunk
- `[[` - Previous hunk

### Gitsigns

Default mappings in normal mode:

- `]c` - Next hunk
- `[c` - Previous hunk
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hS` - Stage buffer
- `<leader>hu` - Undo stage hunk
- `<leader>hR` - Reset buffer
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `<leader>tb` - Toggle current line blame
- `<leader>hd` - Diff this
- `<leader>hD` - Diff this ~
- `<leader>td` - Toggle deleted

Visual mode:

- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk

### DiffView

- `<leader>dv` - Open DiffView
- `<tab>` - Next file
- `<s-tab>` - Previous file
- `<leader>e` - Toggle file panel
- `<leader>b` - Toggle file history panel

## 🤖 AI and GP Integration

### GP (AI Assistant) in Visual Mode

- `<C-g><C-t>` - ChatNew tabnew
- `<C-g><C-v>` - ChatNew vsplit
- `<C-g><C-x>` - ChatNew split
- `<C-g>a` - Visual Append
- `<C-g>b` - Visual Prepend
- `<C-g>c` - Visual Chat New
- `<C-g>i` - Implement selection
- `<C-g>r` - Visual Rewrite

### GP Whisper Commands (Visual Mode)

- `<C-g>wa` - Whisper Append
- `<C-g>wb` - Whisper Prepend
- `<C-g>wn` - Whisper New
- `<C-g>wp` - Whisper Popup
- `<C-g>wr` - Whisper Rewrite

### GP Normal Mode Commands

- `<C-g>c` - New Chat
- `<C-g>f` - Chat Finder
- `<C-g>n` - Next Agent
- `<C-g>r` - Inline Rewrite
- `<C-g>t` - Toggle Chat

## 🔎 Search and Navigation

### Telescope

Core mappings (in Telescope window):

- `<C-n>/<Down>` - Next item
- `<C-p>/<Up>` - Previous item
- `j/k` - Next/previous (normal mode)
- `H/M/L` - Select High/Middle/Low
- `gg/G` - Select first/last item
- `<CR>` - Confirm selection
- `<C-x>` - Split horizontal
- `<C-v>` - Split vertical
- `<C-t>` - Open in new tab
- `<C-u>` - Scroll up preview window
- `<C-d>` - Scroll down preview window
- `<C-/>` - Show mappings
- `?` - Show help

Insert mode special mappings:

- `<C-c>` - Close telescope
- `<Tab>` - Toggle selection + next
- `<S-Tab>` - Toggle selection + prev
- `<C-space>` - Preview scroll up
- `<M-space>` - Preview scroll down
- `<C-q>` - Send to quickfix list

### Spectre (Search and Replace)

- `<leader>S` - Toggle Spectre
- `<leader>sw` - Search current word
- `<leader>sp` - Search in current file
  Inside Spectre window:
- `dd` - Toggle current item
- `<leader>R` - Replace all
- `<leader>rc` - Replace current line
- `<leader>v` - Change view mode

## 📝 Code Organization

### Aerial (Code Outline)

- `<leader>a` - Toggle Aerial window
- `{` - Previous symbol
- `}` - Next symbol
- `[[` - Previous item at same level
- `]]` - Next item at same level
- `o` - Jump to symbol and close
- `O` - Jump to symbol and stay
- `<C-j>` - Next location same symbol
- `<C-k>` - Prev location same symbol

### Mini.nvim Features

#### mini.surround

- `sa` - Add surrounding
- `sd` - Delete surrounding
- `sr` - Replace surrounding
- `sn` - Update `n` lines
- `sF` - Find surrounding
- `sf` - Find surrounding to the right
- `sh` - Highlight surrounding
- `sH` - Highlight surrounding to the right

#### mini.ai (Text Objects)

- `a)` or `i)` - Around/inside parentheses
- `a]` or `i]` - Around/inside brackets
- `a}` or `i}` - Around/inside braces
- `a'` or `i'` - Around/inside single quotes
- `a"` or `i"` - Around/inside double quotes
- `a>` or `i>` - Around/inside angle brackets
- `at` or `it` - Around/inside tags

## 🎨 Other Features

### Marks

- `mx` - Set mark x
- `'x` - Jump to line of mark x
- `` `x `` - Jump to position of mark x
- `m,` - Set the next available alphabetical mark
- `m;` - Toggle the next available mark at the current line
- `m]` - Move to next mark
- `m[` - Move to previous mark
- `m:` - Preview mark
- `m/` - Show all marks in quickfix window

### LeetCode

- `:LeetCodeList` - Browse problems
- `:LeetCodeTest` - Test solution
- `:LeetCodeSubmit` - Submit solution
- `:LeetCodeSignIn` - Sign in

### Markdown Preview

- `:MarkdownPreview` - Start preview
- `:MarkdownPreviewStop` - Stop preview
- `:MarkdownPreviewToggle` - Toggle preview

### Terminal

- `<C-\>` - Toggle terminal
- `<Esc><Esc>` - Exit terminal mode
  Terminal window commands:
- `<C-h>/<C-j>/<C-k>/<C-l>` - Window navigation
- `<C-w>N` - Terminal normal mode
- `i` or `a` - Back to terminal mode

## 💡 Pro Tips

1. **File Navigation**

   - Use `<leader>sf` for quick file access
   - NvimTree + Telescope combination for efficient navigation
   - Use marks for quick position jumping

2. **LSP and Completion**

   - Use `<C-k>` for signature help
   - Auto-pairs automatically close brackets/quotes
   - Use snippets for common code patterns

3. **Git Workflow**

   - Fugitive for complex git operations
   - Gitsigns for inline changes
   - DiffView for detailed change review

4. **AI Integration**

   - GP chat for code assistance
   - Use visual mode selections for context
   - Whisper mode for voice commands

5. **Performance**
   - Toggle features when needed
   - Use lazy loading for plugins
   - Twilight mode for focus

## ⌨️ Key Mapping Conventions

- `<leader>` - Space key
- `<CR>` - Enter key
- `<C-x>` - Control + x
- `<M-x>` - Alt/Meta + x
- `<S-x>` - Shift + x

## 🚀 Getting Started

1. First Steps

   - Run `:Tutor` for Vim basics
   - Use `<leader>sh` to search help
   - Check `:checkhealth` for issues

2. Language Setup

   - Install language servers via `:Mason`
   - Configure formatting via `:ConformInfo`
   - Set up project-specific settings

3. Customization
   - Check `:Lazy` for plugin status
   - Modify keymaps in your config
   - Explore plugin documentation

## 🔧 Maintenance Commands

```vim
:checkhealth          " System diagnostics
:Lazy                " Plugin management
:Mason               " LSP/DAP/Linter management
:LspInfo            " LSP status
:TSUpdate           " Update treesitter parsers
:ConformInfo        " Formatter status
```

## 📦 Plugin Updates

- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync plugins
- `:Lazy clean` - Remove unused plugins
- `:TSUpdate` - Update treesitter parsers
- `:MasonUpdate` - Update Mason packages

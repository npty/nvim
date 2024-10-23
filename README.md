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

### Document Symbols and Diagnostics

- `<leader>ds` - Document symbols (using Telescope)
- `<leader>ws` - Workspace symbols
- `<leader>q` - Open diagnostic quickfix list

## 🔄 Git Integration

### Gitsigns

- `<leader>h` prefix for Git hunk operations
- `<leader>gh` - Open in browser (GBrowse)

### DiffView

- `<leader>dv` - Open DiffView

## 🤖 AI and Completion

### GP (AI Assistant)

GP commands use `<C-g>` prefix:

Visual Mode:

- `<C-g><C-t>` - New chat in tab
- `<C-g>r` - Rewrite selection
- `<C-g>a` - Append
- `<C-g>b` - Prepend

Normal Mode:

- `<C-g>c` - New chat
- `<C-g>f` - Chat finder
- `<C-g>t` - Toggle chat

### Completion Control

- `<leader>tc` - Toggle completion
- `<C-c>` - Manual completion trigger

## 🔎 Search and Replace

### Telescope

- `<leader>sh` - Search help tags
- `<leader>sk` - Search keymaps
- `<leader>sr` - Resume last search
- `<leader>/` - Fuzzy search in current buffer with dropdown

### Spectre (Global Search/Replace)

- `<leader>S` - Toggle Spectre
- `<leader>sw` - Search current word
- `<leader>sp` - Search in current file

## 📝 Code Focus and Organization

### Aerial (Code Outline)

- `<leader>a` - Toggle Aerial outline
- `{` - Previous symbol
- `}` - Next symbol

### Twilight (Focus Mode)

- `<leader>tw` - Toggle Twilight focus mode

### Folding

- `<leader>A` - Show current fold method
- Treesitter-based folding enabled by default

## 🎨 Other Features

### OSC Yank (Terminal Copy)

- `<leader>c` - OSC yank operator
- `<leader>cc` - OSC yank line

### Surroundings (mini.surround)

- `sa` - Add surroundings
- `sd` - Delete surroundings
- `sr` - Replace surroundings

## 💡 Pro Tips

1. **LSP and Completion**

   - Native LSP with nvim-cmp provides powerful completion
   - Use `<C-k>` to view function signatures
   - Completion sources include LSP, buffer, path, and snippets

2. **File Navigation**

   - NvimTree (`<C-m>`) shows project structure with git status
   - Telescope fuzzy finding is powerful for quick navigation
   - Use `<leader>sf` for quick file access

3. **Git Workflow**

   - Gitsigns provides inline git information
   - DiffView gives comprehensive diff viewing
   - Use `<leader>gh` for quick GitHub access

4. **Terminal Integration**

   - Toggle terminal with `<C-\>`
   - Terminal exists in float mode by default
   - Use `<Esc><Esc>` to exit terminal mode

5. **AI Assistance**
   - GP commands (`<C-g>` prefix) provide powerful AI features
   - Use visual selection with GP for context-aware operations
   - Whisper mode available for voice-to-text

## ⚙️ Common Commands

```vim
:Mason                 " Package manager for LSP servers
:Lazy                 " Plugin manager
:checkhealth          " Diagnostic tool
:LspInfo             " LSP status
:GpChatNew           " New GP chat
:NvimTreeToggle      " Toggle file explorer
:Twilight            " Toggle focus mode
```

## 🎨 Theme and Appearance

Current colorscheme: Neofusion

Change colorscheme:

```vim
:colorscheme <scheme-name>
```

## 🔧 Performance Tips

1. Toggle completion if editor feels slow: `<leader>tc`
2. Use Twilight mode for better focus and performance
3. Lazy loading is configured for many plugins
4. Use Mason to manage LSP servers efficiently

## 🚀 Getting Started

1. Run `:Tutor` for Vim basics
2. Use `<leader>sh` to search help
3. Check `:checkhealth` for any issues
4. Install language servers via `:Mason`
5. Configure LSP settings per project needs

## 📦 Plugin Management

- Use `:Lazy` to manage plugins
- Update plugins: `:Lazy update`
- Check plugin status: `:Lazy check`

# Npty's Neovim Configuration

A modern Neovim configuration optimized for TypeScript and blockchain development. This setup includes LSP support, intelligent code navigation, Git integration, and various quality-of-life improvements.

## 🚀 Features

- Full TypeScript/JavaScript support with LSP
- Smart code navigation with Treesitter
- Git integration with enhanced visualization
- Modern UI improvements
- Tmux integration
- Efficient fuzzy finding
- Enhanced terminal support

## 📋 Prerequisites

- Neovim >= 0.9.0
- Git
- Node.js (for TypeScript/JavaScript LSP)
- ripgrep (for Telescope file searching)
- fd (for Telescope file searching)
- A Nerd Font (recommended for icons)

### System Dependencies

For Mason formatters to install correctly, you need:

```bash
# On Ubuntu/Debian/WSL
sudo apt-get update && sudo apt-get install -y unzip python3-venv

# On macOS
brew install unzip python3

# On Arch Linux
sudo pacman -S unzip python
```

These are required for:
- **unzip** - Installing stylua and other binary tools
- **python3-venv** - Installing Python-based formatters (black, isort)

## 🔒 Environment Variables

This configuration uses several environment variables for API keys and secrets. Create a `.env` file in your Neovim config directory and add your keys:

### Required Environment Variables

| Variable           | Description                      | Used By                         |
| ------------------ | -------------------------------- | ------------------------------- |
| `DEEPSEEK_API_KEY` | API key for DeepSeek AI services | avante.nvim, codecompanion.nvim |

### Optional Environment Variables

| Variable         | Description                          | Default |
| ---------------- | ------------------------------------ | ------- |
| `TSS_MAX_MEMORY` | Maximum memory for TypeScript server | 4096    |

### Loading Environment Variables

1. Create a `.env` file in your Neovim config directory
2. Add your environment variables
3. Use one of these methods to load them:

#### Option 1: Direct in Shell

```bash
export DEEPSEEK_API_KEY="your-key-here"
nvim
```

## 🔧 Installation

1. Backup your existing Neovim configuration:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. Clone this configuration:

```bash
git clone https://github.com/npty/nvim-config.git ~/.config/nvim
```

3. Start Neovim:

```bash
nvim
```

The configuration will automatically:

- Install lazy.nvim (plugin manager)
- Install all configured plugins
- Set up LSP servers

## ⌨️ Key Mappings

Common keymaps are listed below. For a complete list of all keybindings, see [KEYMAPS.md](./KEYMAPS.md).

### Essential Mappings

- `<Space>` - Leader key
- `jk` - Exit insert mode
- `<C-\>` - Toggle terminal
- `<C-m>` - Toggle file tree
- `<leader>f` - Format buffer

### Quick Navigation

- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader>/` - Fuzzy find in current buffer

## 📦 Major Plugins

- **LSP Support**

  - nvim-lspconfig
  - mason.nvim
  - mason-lspconfig.nvim
  - nvim-cmp

- **Syntax and Navigation**

  - nvim-treesitter
  - nvim-treesitter-textobjects
  - nvim-treesitter-context
  - telescope.nvim

- **Git Integration**

  - gitsigns.nvim
  - vim-fugitive

- **UI Enhancements**

  - noice.nvim
  - trouble.nvim
  - aerial.nvim
  - which-key.nvim

- **File Management**
  - nvim-tree.lua
  - telescope.nvim

## 🎨 Appearance

The configuration uses the Neofusion color scheme by default. UI elements include:

- Status line with essential information
- Git decorations in the sign column
- LSP diagnostics with icons
- Indent guides
- File tree with icons

## 📱 Terminal Integration

- Integrated terminal with toggleterm.nvim
- Tmux navigation support
- OSC yank support for remote copying

## 🔍 Code Intelligence

### Language Servers

- typescript-language-server
- lua-language-server
- rust-analyzer
- solidity-ls
- and more...

### Formatting

- Configured with conform.nvim
- Support for:
  - TypeScript/JavaScript (prettier)
  - Lua (stylua)
  - Rust (rustfmt)
  - Python (black, isort)

## ⚡ Performance

The configuration is optimized for performance:

- Lazy loading of plugins
- Efficient plugin configurations
- Limited diagnostics in large files
- Smart handling of file indexing

## 🛠️ Customization

To customize the configuration:

1. Add new plugins in `lua/plugins/*`
2. Modify keymaps in the main configuration
3. Adjust LSP settings in the lspconfig setup
4. Update UI preferences in respective plugin configurations

## 📝 Tips

1. Use `:checkhealth` to verify your setup
2. Update plugins regularly with `:Lazy update`
3. Update Treesitter parsers with `:TSUpdate`
4. Check LSP status with `:LspInfo`

## 💡 Troubleshooting

Common issues and solutions:

1. **Icons not showing**

   - Install a Nerd Font and configure your terminal to use it

2. **LSP not working**

   - Run `:Mason` and check if servers are installed
   - Check `:LspInfo` for server status

3. **Search not working**

   - Ensure ripgrep is installed
   - Check Telescope health with `:checkhealth telescope`

4. **Performance issues**
   - Update plugins and Neovim
   - Check `:checkhealth` for any warnings
   - Consider adjusting LSP settings for large files

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/user/)
- [Lazy.nvim Wiki](https://github.com/folke/lazy.nvim/wiki)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig/wiki)
- [Treesitter Documentation](https://github.com/nvim-treesitter/nvim-treesitter/wiki)

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

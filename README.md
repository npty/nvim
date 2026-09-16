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

- Neovim >= 0.11
- Git
- Node.js (for TypeScript/JavaScript LSP)
- ripgrep (live grep via snacks.picker)
- fd (file finding via snacks.picker)
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

## 🔧 Installation

1. Backup your existing Neovim configuration:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. Clone this configuration:

```bash
git clone https://github.com/npty/nvim.git ~/.config/nvim
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

For the complete list, use which-key or `<leader>sk`.

## 📱 Terminal Integration

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

1. Add new plugins in `lua/plugins.lua`
2. Modify keymaps in the main configuration
3. Adjust LSP settings in the lspconfig setup

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

3. **Performance issues**
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

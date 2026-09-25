# Neovim controls

The leader key is Space. Restart Neovim after config changes.

| Action | Command | Shortcut |
| --- | --- | --- |
| Pick and save a theme | `:Theme` | Space t t |
| Set a theme directly | `:Theme tokyonight-night` | |
| Toggle file tree | `:NvimTreeToggle` | Space e or Space p v |
| Reveal current file | `:NvimTreeFindFile` | Space f e |
| Search keybindings | `:Keybindings` | Space ? |
| Show shortcut hints | `:WhichKey` | Press Space and wait |
| Update plugins | `:Lazy sync` | |
| Manage language servers | `:Mason` | |

Themes include Everforest, Tokyo Night, Catppuccin, Kanagawa, and Neovim's built-in themes.
In the theme picker, type to filter, use Ctrl-n / Ctrl-p to navigate, and Enter to save.
Escape leaves insert mode; Escape again closes the picker and restores the previous theme.
Selection is saved in `stdpath("state")/theme.json` and restored on startup.
Use `:Theme name` when you want a direct choice to persist; plain `:colorscheme` is temporary.
The original transparent background is retained.

Inside the file tree, Enter opens a file or expands a folder; `g?` shows tree shortcuts.

Plugins are managed by lazy.nvim and pinned in lazy-lock.json.
The config uses Neovim 0.11's native LSP API. Treesitter stays on the master compatibility
branch for Neovim 0.11. The unused archived rust-tools and Treesitter playground plugins
were removed; Rust LSP support remains enabled. Use `:InspectTree` to inspect syntax.
Existing Packer plugin downloads remain on disk but are not loaded by Lazy.

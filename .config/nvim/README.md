# Neovim config

Shared config for macOS and Linux. Tested with Neovim 0.11.4.
Use Neovim 0.11.4 or a newer 0.11 patch release on both laptops for the same behavior.
Plugins bootstrap on first launch; `lazy-lock.json` records the tested plugin revisions.

## Install on another laptop

Install Neovim, Git, ripgrep, a C compiler, curl, unzip, tar, Node.js/npm, and Go.
Elixir/Erlang are needed for Elixir development. Rust development needs a Rust toolchain.
On macOS, install command-line developer tools with `xcode-select --install`.
On Linux, clipboard integration needs `wl-clipboard` on Wayland or `xclip` on X11.
A Nerd Font is optional for plugin icons.

Clone the dotfiles repo once, then link only the Neovim directory:

```sh
git clone https://github.com/ikurotime/dotfiles.git ~/dotfiles
mkdir -p ~/.config
# If ~/.config/nvim already exists, move it to a backup before linking.
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
nvim
```

Wait for plugins and Mason language servers to finish installing. Run `:Lazy restore`
to match the committed plugin versions and `:TSUpdateSync` to install/update parsers.
Use `:Mason` to inspect language server installation and `:checkhealth` to diagnose
missing tools. SourceKit and Flow require their platform/project tools separately.
Optional formatters are `prettierd` or `prettier`, and `stylua`; install these on each
laptop if desired. Copilot authentication is also per laptop.

## Keep laptops in sync

```sh
git -C ~/dotfiles pull --ff-only
```

Restart Neovim and run `:Lazy restore`. To intentionally upgrade plugins, run
`:Lazy sync` and commit the changed `.config/nvim/lazy-lock.json` from `~/dotfiles`.
Keep config edits in this repository so the symlink uses them immediately.

Theme choices persist independently on each laptop in Neovim's state directory.
They are not committed. Use `:Theme name` on both laptops to choose the same theme.
Undo history, downloaded plugins, language servers, and credentials also stay local.

See [commands and shortcuts](COLORSCHEME_OPTIONS.md) for the theme picker, file tree,
and searchable keybindings. Space is the leader key.

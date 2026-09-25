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

## Working with Codex

Keep the Codex app and Neovim on the same project checkout, including the same
worktree if one is in use. Files changed on disk reload on focus or buffer entry
when there are no unsaved buffer edits. Conflicting unsaved edits retain Neovim's
normal warning. Space a r checks for external changes manually.

| Shortcut | Action |
| --- | --- |
| Space a c | Copy project path and current file/line reference |
| Visual selection, Space a c | Copy reference plus selected full lines |
| Space a a | Toggle a Codex CLI terminal for this project |
| Space g s | Git status, including new/untracked files |
| Space g d | Side-by-side diff of current tracked file against index |
| Space g p | Preview current Git hunk |
| ]c / [c | Next / previous Git hunk |
| Space t f | Toggle format on save for this Neovim session |

Paste copied context into the Codex app yourself. These mappings do not send prompts.
Clipboard support is needed for pasting outside Neovim; the unnamed register also
receives the copied context. Use `:FormatToggle`, `:AgentContext`, or `:Codex` as
command alternatives. Close the extra diff window and run `:diffoff` to leave review.

The terminal is optional and starts a separate CLI conversation, not the current
app task. It uses `codex` from PATH and the CLI's existing model/settings; it does
not override your GPT-6 choice in the app. Install Codex CLI on each laptop if needed.
Run `codex login` and sign in with ChatGPT for subscription access, subject to your
workspace permissions. API-key authentication uses separate API billing.
See [OpenAI authentication docs](https://learn.chatgpt.com/docs/auth).

While typing in Codex, press Ctrl-g to hide the pane directly. Alt-a also works.
Press Escape twice to enter terminal normal mode, then Space a a to hide it.
The standard Ctrl-\ then Ctrl-n escape also remains available. Hiding preserves the running CLI session; reopening
reuses it for that project. Closing Neovim ends the embedded terminal process.

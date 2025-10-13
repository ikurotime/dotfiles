# ==============================
#   ENVIRONMENT DETECTION
# ==============================
if [[ "$OSTYPE" == "darwin"* ]]; then
    export OS="macos"
else
    export OS="linux"
fi

# ==============================
#   PATHS
# ==============================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

if [[ "$OS" == "linux" ]]; then
    export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
    export IDF_PATH="$HOME/tmp/esp-idf"
    export PATH="$IDF_PATH/tools:$PATH"
elif [[ "$OS" == "macos" ]]; then
    # Homebrew paths (optional)
    if command -v brew >/dev/null 2>&1; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# ==============================
#   NVM (OS-SPECIFIC)
# ==============================
if [[ "$OS" == "macos" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# ==============================
#   PROMPT (oh-my-posh)
# ==============================
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/kuro.toml)"
fi

# ==============================
#   ALIASES
# ==============================
alias v="nvim"
alias k="kubectl"
alias p="pulumi"
alias gs="git status"
alias g="lazygit"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias gsw="git switch -"
alias gsc="git switch -c"
alias yeet="git push -u origin HEAD"
alias kcu="kubectl config use-context"
alias kcg="kubectl config get-contexts"
alias ps="pulumi stack ls"
alias pspro="pulumi stack select maisa-ai/workload-pro"
alias pspre="pulumi stack select maisa-ai/workload-pre"
alias lg="lazygit"
alias python="python3"
alias ls='ls --color=auto'

export AWS_PROFILE=infra_sdlc

# ==============================
#   HISTORY
# ==============================
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE

setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ==============================
#   KEYBINDINGS
# ==============================
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s ^f "tmux-sessionizer\n"

# ==============================
#   ZINIT & PLUGINS
# ==============================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# ==============================
#   FZF + ZOXIDE + FZF-TAB
# ==============================
if [ -f "$HOME/.fzf.zsh" ]; then
    source "$HOME/.fzf.zsh"
else
    # fallback: use fzf from PATH
    if command -v fzf >/dev/null 2>&1; then
        eval "$(fzf --zsh)"
    fi
fi

eval "$(zoxide init --cmd cd zsh)"
zinit light Aloxaf/fzf-tab

# ==============================
#   FZF-TAB STYLING
# ==============================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ==============================
#   OPTIONAL ZINIT ANNEXES
# ==============================
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl


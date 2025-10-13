# linux ---
export PATH=$PATH:/home/kuro/.local/bin
export PATH=$PATH:/usr/local/go/bin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# ---
#export NVM_DIR="$HOME/.nvm"
#      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


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
export AWS_PROFILE=infra_sdlc
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export IDF_PATH="$HOME/tmp/esp-idf"
export PATH="$IDF_PATH/tools:$PATH"
export LLVM_DIR=$(brew --prefix llvm)/lib/cmake/llvm

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/kuro.toml)"
fi
bindkey -s ^f "tmux-sessionizer\n"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load zsh-completions
autoload -U compinit && compinit


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUPLE=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space 
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups 

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
#eval "$(/opt/homebrew/bin/brew shellenv)"



### End of Zinit's installer chunk

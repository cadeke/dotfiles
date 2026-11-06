# Zinit
ZINIT_HOME="$HOME/.config/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "${ZINIT_HOME:h}"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Plugins
autoload -U compinit && compinit

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::kubectl
# zinit snippet OMZP::python
# zinit snippet OMZP::docker
# zinit snippet OMZP::docker-compose
# zinit snippet OMZP::terraform

zinit cdreplay -q

# Keybinds
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey "^F" autosuggest-accept
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char

# Completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt APPEND_HISTORY
setopt SHARE_HISTORY

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Fzf
if [[ -r /usr/share/fzf/shell/key-bindings.zsh ]]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

if command -v fzf >/dev/null; then
  bindkey '^R' fzf-history-widget
fi

# Path
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin 
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias ll='ls -la'
alias vim='nvim'
alias ls='ls --color=auto'
alias v='nvim'
alias lg='lazygit'
alias speed='speedtest-cli --simple --secure'
alias codium='flatpak run com.vscodium.codium'
alias code='codium'
alias k='kubectl'

# Starship prompt
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"

# Lazy-load nvm: sourcing nvm.sh is slow, so defer it until nvm/node/npm/npx is used.
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  # Keep the newest installed node (and its global bins, e.g. prettier) on PATH
  # without sourcing nvm, so editors and scripts still find them.
  _nvm_bin=("$NVM_DIR"/versions/node/v*/bin(Nn[-1]))
  [[ -n "$_nvm_bin" ]] && export PATH="$_nvm_bin:$PATH"
  unset _nvm_bin

  _nvm_lazy_load() {
    unset -f nvm node npm npx _nvm_lazy_load
    \. "$NVM_DIR/nvm.sh"
  }
  for _cmd in nvm node npm npx; do
    eval "$_cmd() { _nvm_lazy_load; $_cmd \"\$@\"; }"
  done
  unset _cmd
fi

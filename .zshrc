# Zinit
ZINIT_HOME="$HOME/.config/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "${ZINIT_HOME:h}"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZP::git
zinit snippet OMZP::python
zinit snippet OMZP::docker
zinit snippet OMZP::kubectl
zinit snippet OMZP::terraform
zinit snippet OMZP::docker-compose
zinit snippet OMZP::colored-man-pages

# Autoload completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybinds
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey "^f" autosuggest-accept
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^B" backward-char
bindkey "^F" forward-char

# Completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

setopt APPEND_HISTORY
setopt SHARE_HISTORY

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Fzf
if [[ -r /usr/share/fzf/shell/key-bindings.zsh ]]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' 2>/dev/null"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

if command -v fzf >/dev/null; then
  bindkey '^R' fzf-history-widget
fi

# Path
export PATH=$PATH:/usr/local/go/bin 
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias vim='nvim'
alias lg='lazygit'

# Starship prompt
eval "$(starship init zsh)"

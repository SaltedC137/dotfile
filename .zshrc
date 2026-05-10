# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

# Theme setup (https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
ZSH_THEME="robbyrussell"

# Performance optimization: Disable marking untracked files as dirty.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# History time format (yyyy-mm-dd)
HIST_STAMPS="yyyy-mm-dd"

# Add zsh-completions to fpath (MUST be before source $ZSH/oh-my-zsh.sh)
fpath+=(~/.oh-my-zsh/custom/plugins/zsh-completions/src)

# Oh My Zsh Plugins
# Note: Custom plugins should be in ~/.oh-my-zsh/custom/plugins
plugins=(git zsh-history-substring-search zsh-completions)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Environment Variables & Exports
export EDITOR='emacs'

# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Options for history management
setopt HIST_IGNORE_ALL_DUPS    # Do not record an event that was just recorded before.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history.
setopt HIST_SAVE_NO_DUPS       # Do not write duplicate events to the history file.
setopt HIST_IGNORE_SPACE       # Do not record an event starting with a space.
setopt INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY           # Share history between all sessions.
setopt HIST_FCNTL_LOCK         # Better file locking for history.

# Completion System
# Enable menu selection (use arrow keys to navigate the completion menu)
zstyle ':completion:*' menu select
# Case-insensitive matching and matching for dots/hyphens/underscores
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Better group and description formatting
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# FZF Configuration
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

# General fzf options
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border=rounded --margin=1 --padding=1"

# CTRL-R (History search) configuration
export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window=down:3:wrap
  --bind 'ctrl-r:toggle-preview'
  --bind 'ctrl-s:toggle-sort'
  --color='fg+:15,bg+:23,hl+:11,fg:240,bg:17,hl:240,header:117,info:23,pointer:117,marker:117'
  --exact
"

# CTRL-T (File search) configuration
export FZF_CTRL_T_OPTS="
  --preview='bat --color=always --style=numbers --line-range=:50 {} 2>/dev/null || ls -la {}'
  --preview-window=right:60%:wrap
  --bind 'ctrl-y:execute-silent(echo {} | wl-copy 2>/dev/null || xclip -selection clipboard 2>/dev/null)'
  --color='fg:240,bg:17,hl:240,fg+:15,bg+:23,hl+:11,header:117,info:23,pointer:117,marker:117'
"

# External Plugins & Sourcing
# 1. Zsh Auto-suggestions (System location)
if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # Custom strategy for suggestions
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT=()
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240,italic'
fi

# 2. Zsh Syntax Highlighting (Common system locations)
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# 3. Zsh History Substring Search (Configuring keybindings)
if [[ -n "$terminfo[kcuu1]" ]] && [[ -n "$terminfo[kcud1]" ]]; then
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
fi
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases
alias zshconfig="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias ll="ls -lah"

# where proxy
proxy () {
  export http_proxy="http://127.0.0.1:7897"
  export https_proxy="http://127.0.0.1:7897"
  echo "HTTP Proxy on"
}

# where noproxy
noproxy () {
  unset http_proxy
  unset https_proxy
  echo "HTTP Proxy off"
}

export TERMINAL=kitty
export TERM=xterm-kitty


export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export SDL_IM_MODULE=fcitx5

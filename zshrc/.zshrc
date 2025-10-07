# ========================================
# Zsh Configuration
# ========================================

### 🔹 Powerlevel10k Instant Prompt (nếu dùng)
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

### 🔹 Setup
typeset -gi FUNCNEST=1000
export EDITOR="nvim"

### 🔹 PATH setup
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

### 🔹 Go environment
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

### 🔹 Starship prompt
export STARSHIP_CONFIG="$HOME/.starship.toml"
eval "$(starship init zsh)"

### 🔹 Oh My Zsh settings
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/Cellar/zsh-autosuggestions/0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### 🔹 Completion
zstyle ":completion:*:commands" rehash 1

### 🔹 FZF Configuration
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
  --color=fg:#c0caf5,fg+:#bb9af7,bg:#1a1b26,bg+:#292e42
  --color=hl:#7aa2f7,hl+:#7dcfff,info:#7aa2f7,marker:#ff9e64
  --color=prompt:#7dcfff,spinner:#7dcfff,pointer:#ff007c,header:#565f89
  --color=gutter:#1a1b26,border:#414868,separator:#414868,scrollbar:#414868
  --color=preview-fg:#c0caf5,label:#c0caf5,query:#7aa2f7
  --border=rounded --border-label=FZF --border-label-pos=8 --preview-window=right:60%:wrap:border-rounded
  --padding=1 --prompt=  --marker=  --pointer=
  --separator=│ --scrollbar=█ --info=inline
  --preview='bat --style=numbers --color=always --theme=TwoDark --line-range :500 {}'
"

### 🔹 Zoxide (alias z)
eval "$(zoxide init zsh)"
alias cd='z'

### 🔹 Key bindings
bindkey -v
bindkey '^I' complete-word
bindkey '^[Z' autosuggest-accept
bindkey '\t\t' autosuggest-accept
bindkey "^[[3;5~" backward-kill-line

### 🔹 Aliases
alias ss='source ~/.zshrc'
alias gs="git status"
alias :q="exit"
alias cls="clear"

# Folder shortcuts
alias zshconf="nvim ~/.zshrc"
# alias nvimconf="nvim ~/.config/nvim"
alias nvimconf='nvim -c "cd ~/.config/nvim"'
alias project='cd ~/ && cd /Users/nguyenthong/Study/Code && ls'
alias openf='~/scripts/openf.sh'

# WezTerm startup
alias oh='cd ~/'

# Yabai
alias startyb="yabai --start-service"
alias stopyb="yabai --stop-service"

# tmux shortcuts
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias newtmux="tmux new -s"
function ta() {
  local session
  session=$(tmux list-sessions -F "#S" | fzf)
  if [[ -n "$session" ]]; then
    tmux attach -t "$session"
  fi
}

# eza (ls thay thế)
alias l="eza --icons=always"
alias ls="eza --icons=always"
alias ll="eza -lg --icons=always"
alias la="eza -lag --icons=always"
alias lt="eza -lTg --icons=always"
alias lt1="eza -lTg --level=1 --icons=always"
alias lt2="eza -lTg --level=2 --icons=always"
alias lt3="eza -lTg --level=3 --icons=always"
alias lta="eza -lTag --icons=always"
alias lta1="eza -lTag --level=1 --icons=always"
alias lta2="eza -lTag --level=2 --icons=always"
alias lta3="eza -lTag --level=3 --icons=always"

### 🔹 Yazi helper
# 🔹 Hàm mở yazi và giữ thư mục hiện tại
# Hàm yazi với cd
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"

    if [ -f "$tmp" ]; then
        local cwd
        cwd=$(<"$tmp")  # đọc thư mục mới
        rm -f "$tmp"
        if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"      # chuyển cwd trong shell hiện tại
            zle reset-prompt          # nếu dùng ZLE, cập nhật prompt
        fi
    fi
}

# Tạo widget ZLE cho Ctrl+Y
zle -N y_widget yy
bindkey '^Y' y_widget

# 🔹 FZF zsh integration
source <(fzf --zsh)

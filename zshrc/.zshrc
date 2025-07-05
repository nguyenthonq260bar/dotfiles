### 🔹 Powerlevel10k (nếu dùng)
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


### 🔹 setup
typeset -gi FUNCNEST=1000

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

### 🔹 Zsh settings
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
plugins=(git zsh-autosuggestions)

### 🔹 Source Oh My Zsh and plugins
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/Cellar/zsh-autosuggestions/0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### 🔹 Completion
zstyle ":completion:*:commands" rehash 1

### 🔹 FZF config (giữ nguyên như bạn muốn)
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

### 🔹 Zoxide (cd thay bằng z)
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

# Folder
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim"
alias project='cd ~/ && cd /Users/nguyenthong/Study/Code && ls'
alias openf='~/scripts/openf.sh'

# WezTerm startup
alias oh='cd ~/'

# Yabai
alias startyb="yabai --start-service"
alias stopyb="yabai --stop-service"

# tmux
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
alias lt="eza -lTg  --icons=always"
alias lt1="eza -lTg --level=1 --icons=always"
alias lt2="eza -lTg --level=2 --icons=always"
alias lt3="eza -lTg --level=3 --icons=always"
alias lta="eza -lTag --icons=always"
alias lta1="eza -lTag --level=1 --icons=always"
alias lta2="eza -lTag --level=2 --icons=always"
alias lta3="eza -lTag --level=3 --icons=always"

### 🔹 Hàm mở yazi và quay lại thư mục đã chọn
bindkey -s '^Y' 'yazi\n'
function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


source <(fzf --zsh)

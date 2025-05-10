# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi



export STARSHIP_CONFIG="$HOME/.starship.toml"
eval "$(starship init zsh)"



# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="/usr/local/bin:$PATH"

export EDITOR="nvim"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git zsh-autosuggestions 
)

source $ZSH/oh-my-zsh.sh

# Kích hoạt plugin zsh-autosuggestions
source /opt/homebrew/Cellar/zsh-autosuggestions/0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh



source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


zstyle ":completion:*:commands" rehash 1



#
export GOPATH=$HOME/go
export GOROOT=/usr/local/go  
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


bindkey -v

alias ss='source ~/.zshrc'
alias oh='cd ~/ && cat ~/dotfiles/wezterm/.wezterm_ascii.txt && l' 

alias project='cd ~/ && cd /Users/nguyenthong/Study/Code && ls'
eval "$(zoxide init zsh)"
alias cd='z'


source <(fzf --zsh)

# has character "a" - all include ."file"
# has character  "t" - tree include show tree file
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
alias lta3="eza -lTag  --level=3 --icons=always"


alias gs="git status"
alias :q="exit"
alias ll="ls -l"
alias cls="clear"
alias startyb="yabai --start-service"
alias stopyb="yabai --stop-service"
#folders:  Shortcuts for folders
#-----------------------------------------------------
alias zshconf="nvim ~/.zshrc"
alias nvimconf="nvim ~/.config/nvim"
alias newtmux="tmux new -s"


alias openf='~/scripts/openf.sh'



export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#ffe4e4,fg+:#ff06da,bg:-1,bg+:#ffffff
  --color=hl:#00ff59,hl+:#ff0888,info:#ffff00,marker:#ff2bd1
  --color=prompt:#3a5d62,spinner:#3f1336,pointer:#50e8ff,header:#ff76e1
  --color=gutter:#fa69ff,border:#ff00d9,separator:#ffffff,scrollbar:#ffffff
  --color=preview-fg:#ffffff,label:#ffffff,query:#ffffff
  --border="double" --border-label="fzf" --border-label-pos="8" --preview-window="border-thinblock"
  --padding="1" --prompt=">>>" --marker=">>" --pointer="◆→"
  --separator="|" --scrollbar="│" --info="right"'
#
# if [[ $TERM_PROGRAM == "WezTerm" ]]; then
#   cat ~/dotfiles/wezterm/.wezterm_ascii.txt
# fi

function p() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

bindkey '^ I'   complete-word       # tab          | complete
bindkey '^ [[Z' autosuggest-accept  # shift + tab  | autosuggest
bindkey '\t\t' autosuggest-accept


bindkey "^[[3;5~" backward-kill-line

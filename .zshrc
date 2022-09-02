# Load Antigen
if [[ "$(uname)" == "Darwin" ]]; then
    source $(brew --prefix)/share/antigen/antigen.zsh
else
    if [ -d "/usr/share/zsh-antigen" ]; then
        source /usr/share/zsh-antigen/antigen.zsh
    else
        source /usr/share/zsh/share/antigen.zsh
    fi
fi

eval "$(starship init zsh)"

# Antigen plugins
antigen bundle hlissner/zsh-autopair
antigen bundle agkozak/zsh-z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen apply

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

function gir () {
    cd $(git rev-parse --show-cdup)
}

if type "exa" > /dev/null; then
    alias ls="exa -l"
else
    alias ls="ls --color=auto -lh"
fi

if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/go" ]; then
    export PATH="$HOME/go/bin:$PATH"
fi

export EDITOR="vim"
export GPG_TTY=$(tty)

# Vim mode
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
bindkey -v

# Bind substring history to up and down arrow
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

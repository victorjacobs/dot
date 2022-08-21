source $(brew --prefix)/share/antigen/antigen.zsh
eval "$(starship init zsh)"

# Antigen plugins
antigen bundle hlissner/zsh-autopair
antigen bundle agkozak/zsh-z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle vi-mode
antigen apply

# Aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

if type "exa" > /dev/null; then
    alias ls="exa -l"
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

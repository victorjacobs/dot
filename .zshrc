# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Antigen plugins
antigen theme romkatv/powerlevel10k
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

# History file configuration (ohmyzsh/lib/history.zsh)
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
# setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local

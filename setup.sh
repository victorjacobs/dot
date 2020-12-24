#!/bin/bash
git clone --bare https://github.com/victorjacobs/dot.git "$HOME/.cfg"

function config {
    /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}

mkdir -p .config-backup

if config checkout; then
    echo "Checked out config.";
else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep -E "\s+\." | awk '{$1=$1;print}' | xargs -I{} mv {} .config-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

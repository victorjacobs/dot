#!/bin/bash
git clone --bare https://github.com/victorjacobs/dot.git "$HOME/.cfg"

function config {
    /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}

mkdir -p .config-backup

if config checkout; then
    echo "Checked out config."
else
    echo "Backing up pre-existing dot files..."
    
    for file in $(config checkout 2>&1 | grep -E "\s+\." | awk '{$1=$1;print}'); do
        echo "Moving $file"
        mkdir -p .config-backup/$(dirname $file)
        mv $file .config-backup/$file
    done
fi;

config checkout
config config status.showUntrackedFiles no

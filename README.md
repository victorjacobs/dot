# Dot files

This repository contains my dot files for:

- fish
- vim
- git

## Installation

1. Install git
2. Generate SSH key and add it to GitHub account
3. Run following script in Bash:

```bash
git clone --bare git@github.com:victorjacobs/dot.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```

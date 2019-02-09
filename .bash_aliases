# This file is read by Debian's .bashrc. For systems where we don't want to bother installing Fish
function config {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

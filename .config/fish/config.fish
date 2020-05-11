if not functions -q fisher
    set FISHER_VERSION "3.2.7"
    set FISHER_CHECKSUM "7d7ec9edc9b3ef0c610db8eeb153995633fb07a8"

    set FISHER_URL "https://raw.githubusercontent.com/jorgebucaran/fisher/$FISHER_VERSION/fisher.fish"
    set REMOTE_CHECKSUM (curl -Lks $FISHER_URL | shasum | awk '{print $1}')

    if [ $FISHER_CHECKSUM != $REMOTE_CHECKSUM ]
        echo "Fisher install failed, checksums don't match"
    else
        echo "Downloading fisher..."
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
        curl $FISHER_URL --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
        fish -c fisher
    end
end

set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -g theme_display_date no

if test -e /usr/libexec/java_home
    set -x JAVA_HOME (/usr/libexec/java_home -v 12)
end

if test -d $HOME/bin
    set -gx PATH $HOME/bin $PATH
end

if test -d $HOME/go
    set -gx PATH $HOME/go/bin $PATH
    set -gx GOPATH $HOME/go
    set -gx GOBIN $GOPATH/bin
end

alias dc "docker-compose"
alias d "docker"
alias dl "docker ps -l -q"
alias dit "docker exec -it"
alias drm "docker run --rm -it"

alias gic "git commit"
alias gip "git pull"
alias gir "cd (git rev-parse --show-cdup)"
alias gim "git co master; git pull"
alias gis "git st"
alias gil "git lo"

if type -q exa
    alias ls "exa -l"
else
    alias ls "ls --color=auto -lh"
end

if type -q bat
    alias cat "bat"
end

alias config "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

if type -q hub
    alias gpr "git pr show 2&>1 || git pull-request -op"
    eval (hub alias -s)
end

function m2d
    perl -e "print scalar localtime($argv / 1000)"
end

function d2m
    python -c 'from time import time; print int(round(time() * 1000))'
end

function projects
    cd $HOME/Projects
    if count $argv > /dev/null
        cd $argv
    end
end

function mvn-install
    mvn clean install -U -pl $argv -am -Dmaven.test.skip=true
end

function gb
    # TODO fix edgecases and re-enable stashing
    set -l modifiedFiles (git ls-files -m)
    set -l newBranchName $argv[1]

    if test -n modifiedFiles
        echo $modifiedFiles
        echo "Stashing changes..."
        # git stash > /dev/null 2>&1
    end

    git co master
    git pull
    git checkout $newBranchName 2> /dev/null ;or git checkout -b $newBranchName

    if test -n modifiedFiles
        # git stash pop > /dev/null 2>&1
    end
end

if type -q gpgconf
    gpgconf --launch gpg-agent
    set -e SSH_AUTH_SOCK
    set -U -x SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh
    set -x GPG_TTY (tty)
end

if test -e $HOME/.config/fish/config.local.fish
    source $HOME/.config/fish/config.local.fish
end

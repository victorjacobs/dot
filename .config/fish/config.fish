set -gx PATH /Users/Victor/bin /Users/Victor/go/bin $PATH

set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)

set -gx GOPATH "/Users/Victor/go"
set -gx GOBIN "$GOPATH/bin"

alias dc "docker-compose"
alias d "docker"
alias dl "docker ps -l -q"
alias dit "docker exec -it"
alias drm "docker run --rm -it"
alias gic "git clone"
alias gip "git pull"
alias ls "exa -l"
alias gim "git co master; git pull"
alias cat "bat"
alias config "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

eval (hub alias -s)

function m2d
    perl -e "print scalar localtime($argv / 1000)"
end

function mvn-install
    mvn clean install -U -pl $argv -am -Dmaven.test.skip=true
end

set -g theme_display_date no
